//
//  User.m
//  TwitterDemo
//
//  Created by  Matthew Buckle on 1/31/17.
//  Copyright © 2017 Matthew Buckle. All rights reserved.
//

#import "User.h"
#import "Utils.h"

@implementation User

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (self) {
        self.name = dictionary[@"name"];
        self.screenname = [NSString stringWithFormat:@"@%@", dictionary[@"screen_name"]];
        self.profileImageUrl = [NSURL URLWithString:dictionary[@"profile_image_url_https"]];
        self.tagline = dictionary[@"description"];
        self.backgroundImageUrl = [NSURL URLWithString:dictionary[@"profile_background_image_url_https"]];
        self.bannerImageUrl = [NSURL URLWithString:dictionary[@"profile_banner_url"]];
        if (!self.bannerImageUrl) {
            self.bannerImageUrl = self.backgroundImageUrl;
        }
        
        // Set user stats
        self.friendsCount = [Utils formattedStringFromNumber:dictionary[@"friends_count"]];
        self.followersCount = [Utils formattedStringFromNumber:dictionary[@"followers_count"]];
        self.statusCount = [Utils formattedStringFromNumber:dictionary[@"statuses_count"]];
    }
    
    return self;
}

@end
