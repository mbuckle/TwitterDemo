//
//  TweetTableViewCell.m
//  TwitterDemo
//
//  Created by  Matthew Buckle on 1/30/17.
//  Copyright © 2017 Matthew Buckle. All rights reserved.
//

#import "TweetTableViewCell.h"

@interface TweetTableViewCell ()

@end

@implementation TweetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.nameLabel.text = @"My Twitter Name";
    self.handleLabel.text = @"@MyTwitterHandle";
    self.timestampLabel.text = @"24h";
    self.contentLabel.text = @"My Tweet Content";
    self.retweetLabel.text = @"My Retweet Label Text";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
