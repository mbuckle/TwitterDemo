//
//  DetailedTweetTableViewCell.h
//  TwitterDemo
//
//  Created by  Matthew Buckle on 2/2/17.
//  Copyright © 2017 Matthew Buckle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@protocol DetailedTweetTableViewCellDelegate;

@interface DetailedTweetTableViewCell : UITableViewCell

@property (weak, nonatomic) id<DetailedTweetTableViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *retweetedByLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriteCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) User *user;

@end

@protocol DetailedTweetTableViewCellDelegate <NSObject>
- (void)detailedTweetCellDidSelectImage:(DetailedTweetTableViewCell *)detailedTweetTableViewCell;
@end
