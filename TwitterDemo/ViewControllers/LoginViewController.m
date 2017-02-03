//
//  LoginViewController.m
//  TwitterDemo
//
//  Created by  Matthew Buckle on 1/31/17.
//  Copyright © 2017 Matthew Buckle. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"
#import "NavigationController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)onLogin:(id)sender {
    [[TwitterClient sharedInstance] loginWithCompletion:^(User *user, NSError *error) {
        if (user != nil) {
            [[NavigationManager shared] logIn];
        } else {
            // Present error view
            NSLog(@"Login failed with error: %@", error);
        }
    }];
}


@end
