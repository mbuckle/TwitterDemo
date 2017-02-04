//
//  ComposeTweetViewController.m
//  TwitterDemo
//
//  Created by  Matthew Buckle on 2/3/17.
//  Copyright © 2017 Matthew Buckle. All rights reserved.
//

#import "ComposeTweetViewController.h"
#import "TwitterClient.h"
#import "User.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface ComposeTweetViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *tweetSentLabel;

@end

@implementation ComposeTweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tweetSentLabel.hidden = YES;
    
    // Set up nav bar items
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleDone target:self action:@selector(sendTweet:)];
    self.title = @"Compose Tweet";
    self.navigationController.navigationBar.translucent = NO;
    
    // Get the currently logged in user
    User *user = [[TwitterClient sharedInstance] getLoggedInUser];
    self.nameLabel.text = user.name;
    self.handleLabel.text = user.screenname;
    
    // Set profile image async
    self.profileImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.profileImageView setImageWithURL:user.profileImageUrl];
}

- (IBAction)sendTweet:(id)sender {
    self.tweetSentLabel.hidden = NO;
}

@end
