//
//  EventTableCell.m
//  IceBoxEnt
//
//  Created by Ryan Hittner on 12/31/13.
//  Copyright (c) 2013 Ryan Hittner. All rights reserved.
//

#import "EventTableCell.h"
#import "UIImageView+WebCache.h"

@implementation EventTableCell

@synthesize eventImage;

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
