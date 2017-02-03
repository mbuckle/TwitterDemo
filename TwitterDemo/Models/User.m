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
    }
    
    return self;
}

@end
