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

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set Login Button Attributes
    // Set button background color
    UIColor *twitterBlueColor = [UIColor colorWithRed:0.33 green:0.67 blue:0.93 alpha:1.0];
    [self.loginButton setBackgroundColor:twitterBlueColor];
    
    // Set the button text font
    //[self.loginButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:16.0f]];
    [self.loginButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
    
    // Round the button corners
    CALayer *loginButtonLayer = [self.loginButton layer];
    [loginButtonLayer setMasksToBounds:YES];
    [loginButtonLayer setCornerRadius:5.0f];
    
    // Apply a rotation to the button
    //self.loginButton.transform = CGAffineTransformMakeRotation(M_PI / 180 * 5.0f);
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
