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
    // Create root VC for the tab's navigation controller
    TweetListViewController *vc = [[TweetListViewController alloc] initWithNibName:@"TweetListViewController" bundle:nil];
    vc.title = @"Twitter";
    
    // Create navigation controller
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    
    // Add compose button to nav bar
    vc.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"edit-icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(showCompose:)];
    vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(onLogOut:)];
    
    // Create tab bar view controller
    UITabBarController *tabController = [[UITabBarController alloc] init];
    
    // Add navigation controller to tab bar controller
    tabController.viewControllers = @[navController];
    
    [[tabController.tabBar.items objectAtIndex:0] setTitle:@"Home"];
    [[tabController.tabBar.items objectAtIndex:0] setImage:[UIImage imageNamed:@"home-icon.png"]];
//    [[tabController.tabBar.items objectAtIndex:1] setTitle:@"Mentions"];
//    [[tabController.tabBar.items objectAtIndex:2] setTitle:@"Profile"];
    
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

- (IBAction)onLogOut:(id)sender {
    [self logOut];
}

// TODO: implement this
- (IBAction)showCompose:(id)sender {
    NSLog(@"Open tweet composition view");
}

@end
