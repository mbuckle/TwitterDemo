//
//  ProfileViewController.m
//  TwitterDemo
//
//  Created by  Matthew Buckle on 2/3/17.
//  Copyright © 2017 Matthew Buckle. All rights reserved.
//

#import "ProfileViewController.h"
#import "ComposeTweetViewController.h"
#import "NavigationController.h"
#import "TwitterClient.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface ProfileViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *bannerImageView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersCountLabel;

@end

@implementation ProfileViewController

- (id)initWithUser:(User *)user {
    self = [super init];
    
    if (self) {
        self.user = user;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set up nav bar items
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"edit-icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(showCompose:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(onLogOut:)];
    self.navigationController.navigationBar.translucent = NO;
    
    // Set up user info
    if (!self.user) {
        self.user = [[TwitterClient sharedInstance] getLoggedInUser];
    }
    
    self.nameLabel.text = self.user.name;
    self.handleLabel.text = self.user.screenname;
    self.tweetCountLabel.text = self.user.statusCount;
    self.followingCountLabel.text = self.user.friendsCount;
    self.followersCountLabel.text = self.user.followersCount;
    
    // Load banner and profile image async
    self.profileImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.profileImageView setImageWithURL:self.user.profileImageUrl];
    self.bannerImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.bannerImageView setImageWithURL:self.user.bannerImageUrl];
}

- (IBAction)onLogOut:(id)sender {
    [[NavigationManager shared] logOut];
}

- (IBAction)showCompose:(id)sender {
    ComposeTweetViewController *ctvc = [[ComposeTweetViewController alloc] initWithNibName:@"ComposeTweetViewController" bundle:nil];
    
    [self.navigationController pushViewController:ctvc animated:YES];
}

@end
