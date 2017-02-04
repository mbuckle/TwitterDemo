//
//  DetailedTweetTableViewCell.m
//  TwitterDemo
//
//  Created by  Matthew Buckle on 2/2/17.
//  Copyright © 2017 Matthew Buckle. All rights reserved.
//

#import "DetailedTweetTableViewCell.h"

@implementation DetailedTweetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
    self.nameLabel.text = @"Twitter Name";
    self.handleLabel.text = @"Handle Name";
    self.dateLabel.text = @"Date Created";
    self.retweetedByLabel.text = @"Retweeted by Name";
    self.retweetCountLabel.text = @"####";
    self.favoriteCountLabel.text = @"####";
    self.tweetLabel.text = @"My tweet content";
    
    [self setImageTapGestureRecognizer];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setImageTapGestureRecognizer {
    UITapGestureRecognizer *imageTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleImageTap)];
    self.profileImageView.userInteractionEnabled = true;
    [self.profileImageView addGestureRecognizer:imageTapGesture];
}

- (IBAction)handleImageTap {
    if (self.delegate && [self.delegate respondsToSelector:@selector(detailedTweetCellDidSelectImage:)]) {
        [self.delegate detailedTweetCellDidSelectImage:self];
    }
}

@end
