//
//  TwitterClient.m
//  TwitterDemo
//
//  Created by  Matthew Buckle on 1/31/17.
//  Copyright © 2017 Matthew Buckle. All rights reserved.
//

#import "TwitterClient.h"
#import "Tweet.h"

NSString * const kTwitterConsumerKey = @"4eKwioMpzG9L4Rz1jQCeFe4bR";
NSString * const kTwitterConsumerSecret = @"30eqXJkFpH5QxvNKAP0gI3AZ8nG86gz8wncf0liGvKUc8RRiYU";
NSString * const kTwitterBaseUrl = @"https://api.twitter.com";

@interface TwitterClient()

@property (nonatomic, strong) void (^loginCompletion)(User *user, NSError *error);
@property (nonatomic, strong) void (^getTweetsCompletion)(NSArray<Tweet *> *tweets, NSError *error);
@property (nonatomic, strong) void (^getMentionsCompletion)(NSArray<Tweet *> *tweets, NSError *error);
@property (nonatomic, strong) User *loggedInUser;

@end

@implementation TwitterClient

+ (TwitterClient *) sharedInstance {
    static TwitterClient *instance = nil;
    
    // wrap in dispatch to make it thread safe
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:kTwitterBaseUrl] consumerKey:kTwitterConsumerKey consumerSecret:kTwitterConsumerSecret];
        }
    });
    
    return instance;
}

- (void)loginWithCompletion:(void (^)(User *user, NSError *error))completion {
    // Set login completion property after loginWithCompletion has finished
    self.loginCompletion = completion;
    
    // Clear previous state before requesting new token
    [self.requestSerializer removeAccessToken];
    
    // Request new token
    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"cptwitterdemo://oauth"] scope:nil success:^(BDBOAuth1Credential *requestToken) {
        //NSLog(@"Successfully got the request token!");
        
        // Create authentication Url
        NSURL *authURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token]];
        [[UIApplication sharedApplication] openURL:authURL options:@{} completionHandler:^(BOOL success) {
            //NSLog(@"Successfully opened the URL!");
        }];
        
    } failure:^(NSError *error) {
        NSLog(@"Failed to get the request token!");
        // Set the login completion property with an error if there is a failure
        self.loginCompletion(nil, error);
    }];
}

- (void)openURL:(NSURL *)url {
    // Request access token after returning from twitter auth url
    BDBOAuth1Credential *requestToken = [BDBOAuth1Credential credentialWithQueryString:url.query];
    [self fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:requestToken success:^(BDBOAuth1Credential *accessToken) {
        //NSLog(@"Successfully got the access token!");
        
        // Save the access token for all future requests
        [self.requestSerializer saveAccessToken:accessToken];
        
        // Get new user info
        [self getNewUser];
    } failure:^(NSError *error) {
        NSLog(@"Failed to get the access token!");
    }];
}

- (void)getNewUser {
    // Get current user info
    [self GET:@"1.1/account/verify_credentials.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // Create new user object
        User *user = [[User alloc] initWithDictionary:responseObject];
        self.loggedInUser = user;
        
        // Set the login completion property with the user if there are no errors
        self.loginCompletion(user, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Failed to get the current user info!");
        // Set the login completion property with an error if there is a failure
        self.loginCompletion(nil, error);
    }];
}

- (void)getTweetsWithCompletion:(void (^)(NSArray<Tweet *> *tweets, NSError *error))completion {
    self.getTweetsCompletion = completion;
    // Get current user tweets
    [self GET:@"1.1/statuses/home_timeline.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // Create new tweet object
        NSArray *tweets = [Tweet tweetsWithArray:responseObject];
        self.getTweetsCompletion(tweets, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Failed to get the current user tweets!");
        self.getTweetsCompletion(nil, error);
    }];
}

- (void)getMentionsWithCompletion:(void (^)(NSArray<Tweet *> *tweets, NSError *error))completion {
    self.getMentionsCompletion = completion;
    // Get current user tweets
    [self GET:@"1.1/statuses/mentions_timeline.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // Create new tweet object
        NSArray *tweets = [Tweet tweetsWithArray:responseObject];
        self.getMentionsCompletion(tweets, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Failed to get the current user mentions!");
        self.getMentionsCompletion(nil, error);
    }];
}

- (User *)getLoggedInUser {
    return self.loggedInUser;
}

@end
