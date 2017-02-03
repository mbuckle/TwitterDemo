//
//  TwitterClient.h
//  TwitterDemo
//
//  Created by  Matthew Buckle on 1/31/17.
//  Copyright © 2017 Matthew Buckle. All rights reserved.
//

#import <BDBOAuth1Manager/BDBOAuth1SessionManager.h>
#import "User.h"
#import "Tweet.h"

@interface TwitterClient : BDBOAuth1SessionManager

+ (TwitterClient *)sharedInstance;

- (void)loginWithCompletion:(void (^)(User *user, NSError *error))completion;
- (void)openURL:(NSURL *)url;
- (void)getTweetsWithCompletion:(void (^)(NSArray<Tweet *> *tweets, NSError *error))completion;

@end
