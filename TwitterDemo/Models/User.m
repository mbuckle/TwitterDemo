//
//  User.m
//  TwitterDemo
//
//  Created by  Matthew Buckle on 1/31/17.
//  Copyright © 2017 Matthew Buckle. All rights reserved.
//

#import "User.h"

@implementation User

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (self) {
        self.name = dictionary[@"name"];
        self.screenname = [NSString stringWithFormat:@"@%@", dictionary[@"screen_name"]];
        self.profileImageUrl = [NSURL URLWithString:dictionary[@"profile_image_url_https"]];
        self.tagline = dictionary[@"description"];
        self.bannerImageUrl = [NSURL URLWithString:dictionary[@"profile_banner_url"]];
        self.friendsCount = [NSString stringWithFormat:@"%@", dictionary[@"friends_count"]];
        self.followersCount = [NSString stringWithFormat:@"%@", dictionary[@"followers_count"]];
        self.statusCount = [NSString stringWithFormat:@"%@", dictionary[@"statuses_count"]];
    }
    
    return self;
}

@end
