//
//  GalleryTableCell.m
//  IceBoxEnt
//
//  Created by Ryan Hittner on 10/6/13.
//  Copyright (c) 2013 Ryan Hittner. All rights reserved.
//

#import "GalleryTableCell.h"

@implementation GalleryTableCell

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
