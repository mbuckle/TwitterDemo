//
//  User.h
//  TwitterDemo
//
//  Created by  Matthew Buckle on 1/31/17.
//  Copyright © 2017 Matthew Buckle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenname;
@property (nonatomic, strong) NSURL *profileImageUrl;
@property (nonatomic, strong) NSString *tagline;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
