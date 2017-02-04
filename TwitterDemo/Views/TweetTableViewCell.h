//
//  TweetTableViewCell.h
//  TwitterDemo
//
//  Created by  Matthew Buckle on 1/30/17.
//  Copyright © 2017 Matthew Buckle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@protocol TweetTableViewCellDelegate;

@interface TweetTableViewCell : UITableViewCell

@property (weak, nonatomic) id<TweetTableViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UILabel *retweetLabel;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) User *user;

@end

@protocol TweetTableViewCellDelegate <NSObject>
- (void)tweetCellDidSelectImage:(TweetTableViewCell *)tweetTableViewCell;
@end
