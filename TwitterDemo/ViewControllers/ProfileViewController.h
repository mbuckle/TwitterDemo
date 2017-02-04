//
//  ProfileViewController.h
//  TwitterDemo
//
//  Created by  Matthew Buckle on 2/3/17.
//  Copyright © 2017 Matthew Buckle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ProfileViewController : UIViewController

@property (nonatomic, strong) User *user;

- (id)initWithUser:(User *)user;

@end
