//
//  Tweet.h
//  TwitterDemo
//
//  Created by  Matthew Buckle on 1/31/17.
//  Copyright © 2017 Matthew Buckle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSString *retweetedBy;
@property (nonatomic, strong) NSNumber *retweetCount;
@property (nonatomic, strong) NSNumber *favoriteCount;

- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)tweetsWithArray:(NSArray *)array;

@end
