//
//  NavigationController.m
//  TwitterDemo
//
//  Created by  Matthew Buckle on 2/1/17.
//  Copyright © 2017 Matthew Buckle. All rights reserved.
//

#import "NavigationController.h"
#import "LoginViewController.h"
#import "TweetListViewController.h"
#import "ProfileViewController.h"

@interface NavigationManager ()

@property (nonatomic, assign) BOOL isLoggedIn;
@property (nonatomic, strong) UINavigationController *navigationController;

@end

@implementation NavigationManager

+(instancetype)shared {
    static NavigationManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NavigationManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.isLoggedIn = NO;
        
        UIViewController *root = self.isLoggedIn ? [self loggedInVC] : [self loggedOutVC];
        
        self.navigationController = [[UINavigationController alloc] init];
        self.navigationController.viewControllers = @[root];
        [self.navigationController setNavigationBarHidden:YES];
    }
    return self;
}

- (UIViewController *)rootViewController {
    return self.navigationController;
}

- (UIViewController *)loggedInVC {
    // Create root nav controller for the home tab bar item
    TweetListViewController *homeVC = [[TweetListViewController alloc] initWithNibName:@"TweetListViewController" bundle:nil];
    homeVC.feedType = @"Home";
    homeVC.title = @"Home";
    UINavigationController *homeNavController = [[UINavigationController alloc] initWithRootViewController:homeVC];
    
    // Create root nav controller for the mentions tab bar item
    TweetListViewController *mentionsVC = [[TweetListViewController alloc] initWithNibName:@"TweetListViewController" bundle:nil];
    mentionsVC.feedType = @"Mentions";
    mentionsVC.title = @"Mentions";
    UINavigationController *mentionsNavController = [[UINavigationController alloc] initWithRootViewController:mentionsVC];
    
    // Create root nav controller for the profile tab bar item
    ProfileViewController *profileVC = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
    profileVC.title = @"Profile";
    UINavigationController *profileNavController = [[UINavigationController alloc] initWithRootViewController:profileVC];
    
    // Create tab bar view controller
    UITabBarController *tabController = [[UITabBarController alloc] init];
    
    // Add navigation controllers to tab bar controller
    tabController.viewControllers = @[homeNavController, mentionsNavController, profileNavController];
    
    [[tabController.tabBar.items objectAtIndex:0] setTitle:@"Home"];
    [[tabController.tabBar.items objectAtIndex:0] setImage:[UIImage imageNamed:@"home-icon.png"]];
    [[tabController.tabBar.items objectAtIndex:1] setTitle:@"Mentions"];
    [[tabController.tabBar.items objectAtIndex:1] setImage:[UIImage imageNamed:@"moment-icon.png"]];
    [[tabController.tabBar.items objectAtIndex:2] setTitle:@"Profile"];
    [[tabController.tabBar.items objectAtIndex:2] setImage:[UIImage imageNamed:@"profile-icon.png"]];
    
    return tabController;
}

- (UIViewController *)loggedOutVC {
    LoginViewController *vc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    
    return vc;
}

- (void)logIn {
    self.isLoggedIn = YES;
    
    NSArray *vcs = @[[self loggedInVC]];
    [self.navigationController setViewControllers:vcs];
}

- (void)logOut {
    self.isLoggedIn = NO;
    self.navigationController.viewControllers = @[[self loggedOutVC]];
}

@end
