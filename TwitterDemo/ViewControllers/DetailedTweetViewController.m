//
//  DetailedTweetViewController.m
//  TwitterDemo
//
//  Created by  Matthew Buckle on 2/2/17.
//  Copyright © 2017 Matthew Buckle. All rights reserved.
//

#import "DetailedTweetViewController.h"
#import "DetailedTweetTableViewCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "ProfileViewController.h"

@interface DetailedTweetViewController () <UITableViewDataSource, DetailedTweetTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *detailedTableView;

@end

@implementation DetailedTweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.detailedTableView.dataSource = self;
    
    self.detailedTableView.estimatedRowHeight = 200; // starting point for dynamic view
    self.detailedTableView.rowHeight = UITableViewAutomaticDimension;
    
    // Register nib
    UINib *nib = [UINib nibWithNibName:@"DetailedTweetTableViewCell" bundle:nil];
    [self.detailedTableView registerNib:nib forCellReuseIdentifier:@"DetailedTweetTableViewCell"];
    
    [self.detailedTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailedTweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailedTweetTableViewCell" forIndexPath:indexPath];
    cell.delegate = self;
    
    // Set detailed tweet info
    cell.retweetedByLabel.text = self.tweet.retweetedBy;
    cell.nameLabel.text = self.tweet.user.name;
    cell.handleLabel.text = self.tweet.user.screenname;
    cell.tweetLabel.text = self.tweet.text;
    cell.user = self.tweet.user;
    
    // Set profile image async
    cell.profileImageView.contentMode = UIViewContentModeScaleAspectFit;
    [cell.profileImageView setImageWithURL:self.tweet.user.profileImageUrl];
    
    // Set date for the tweet
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"d/M/yy, h:mm a"];
    cell.dateLabel.text = [dateFormatter stringFromDate:self.tweet.createdAt];
    
    // Set tweet stats
    cell.retweetCountLabel.text = self.tweet.retweetCount;
    cell.favoriteCountLabel.text = self.tweet.favoriteCount;
    
    return cell;
}

- (void)detailedTweetCellDidSelectImage:(DetailedTweetTableViewCell *)detailedTweetTableViewCell {
    ProfileViewController *pvc = [[ProfileViewController alloc] initWithUser:detailedTweetTableViewCell.user];
    
    [self.navigationController pushViewController:pvc animated:YES];
}

@end
