//
//  FeedCell.m
//  IceBoxEnt
//
//  Created by Ryan Hittner on 2/8/14.
//  Copyright (c) 2014 Ryan Hittner. All rights reserved.
//

#import "FeedCell.h"

@implementation FeedCell

@synthesize imageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
