//
//  Tweet.m
//  TwitterDemo
//
//  Created by  Matthew Buckle on 1/31/17.
//  Copyright © 2017 Matthew Buckle. All rights reserved.
//

#import "Tweet.h"
#import "MWFeedParser/NSString+HTML.h"
#import "Utils.h"

@implementation Tweet

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    NSString *createdAtString;
    
    if (self) {
        // Check if tweet is a retweet
        if (dictionary[@"retweeted_status"]) {
            self.retweetedBy = [NSString stringWithFormat:@"%@ Retweeted", [dictionary valueForKeyPath:@"user.name"]];
            
            // Create new user from dictionary
            self.user = [[User alloc] initWithDictionary:[dictionary valueForKeyPath:@"retweeted_status.user"]];
            
            // Get the tweet text
            self.text = [dictionary valueForKeyPath:@"retweeted_status.text"];
            
            // Get tweet stats
            self.retweetCount = [dictionary valueForKeyPath:@"retweeted_status.retweet_count"];
            self.favoriteCount = [dictionary valueForKeyPath:@"retweeted_status.favorite_count"];
            
            // Get the tweet created at date
            createdAtString = [dictionary valueForKeyPath:@"retweeted_status.created_at"];
        } else {
            self.retweetedBy = @"";
            
            // Create new user from dictionary
            self.user = [[User alloc] initWithDictionary:dictionary[@"user"]];
            
            // Get the tweet text
            self.text = dictionary[@"text"];
            
            // Get tweet stats
            self.retweetCount = dictionary[@"retweet_count"];
            self.favoriteCount = dictionary[@"favorite_count"];
            
            // Get the tweet created at date
            createdAtString = dictionary[@"created_at"];
        }
        
        // Decode all HTML entities in the tweet text
        self.text = [self.text stringByDecodingHTMLEntities];
        
        // Format tweet created at date
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
        [dateFormatter dateFromString:createdAtString];
        self.createdAt = [dateFormatter dateFromString:createdAtString];
        
        // Set tweet stats
        self.retweetCount = [Utils formattedStringFromNumber:dictionary[@"retweet_count"]];
        self.favoriteCount = [Utils formattedStringFromNumber:dictionary[@"favorite_count"]];
    }
    
    return self;
}

+ (NSArray *)tweetsWithArray:(NSArray *)array {
    // Helper method to take in an array of dictionaries and return an array of tweets
    NSMutableArray *tweets = [NSMutableArray array];
    
    for (NSDictionary *dictionary in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:dictionary]];
    }
    return tweets;
}

@end
