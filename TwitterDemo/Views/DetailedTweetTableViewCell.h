//
//  DetailedTweetTableViewCell.h
//  TwitterDemo
//
//  Created by  Matthew Buckle on 2/2/17.
//  Copyright © 2017 Matthew Buckle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailedTweetTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *retweetedByLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriteCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;


@end
