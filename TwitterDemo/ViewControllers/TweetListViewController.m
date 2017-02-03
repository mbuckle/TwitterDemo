//
//  TweetListViewController.m
//  TwitterDemo
//
//  Created by  Matthew Buckle on 1/30/17.
//  Copyright © 2017 Matthew Buckle. All rights reserved.
//

#import "TweetListViewController.h"
#import "TweetTableViewCell.h"
#import "TwitterClient.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "DetailedTweetViewController.h"

@interface TweetListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray<Tweet *> *tweets;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation TweetListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.estimatedRowHeight = 200; // starting point for dynamic view
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // Register nib
    UINib *nib = [UINib nibWithNibName:@"TweetTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"TweetTableViewCell"];
    
    [self fetchTweets];
    
    // Implement UI Refresh Control
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (void)refreshTable {
    [self fetchTweets];
}

- (void)fetchTweets {
        // Get the user's tweets
        [[TwitterClient sharedInstance] getTweetsWithCompletion:^(NSArray<Tweet *> *tweets, NSError *error) {
            if (tweets != nil) {
                self.tweets = tweets;
                [self.tableView reloadData];
            } else {
                // Present error view
                NSLog(@"Getting user tweets failed with error: %@", error);
            }
            
            [self.refreshControl endRefreshing];
        }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetTableViewCell" forIndexPath:indexPath];
    
    // Set tweet text data
    Tweet *tweet = [self.tweets objectAtIndex:indexPath.row];
    cell.nameLabel.text = tweet.user.name;
    cell.handleLabel.text = tweet.user.screenname;
    cell.contentLabel.text = tweet.text;
    cell.retweetLabel.text = tweet.retweetedBy;
    
    // Set profile image async
    cell.profileImageView.contentMode = UIViewContentModeScaleAspectFit;
    [cell.profileImageView setImageWithURL:tweet.user.profileImageUrl];
    
    // Set elapsed time on the tweet
    NSDateComponentsFormatter *formatter = [[NSDateComponentsFormatter alloc] init];
    formatter.unitsStyle = NSDateComponentsFormatterUnitsStyleAbbreviated;
    formatter.allowedUnits = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    formatter.maximumUnitCount = 1;
    NSString *elapsed = [formatter stringFromDate:tweet.createdAt toDate:[NSDate date]];
    cell.timestampLabel.text = elapsed;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailedTweetViewController *dtvc = [[DetailedTweetViewController alloc] initWithNibName:@"DetailedTweetViewController" bundle:nil];
    dtvc.tweet = [self.tweets objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:dtvc animated:YES];
}

@end
