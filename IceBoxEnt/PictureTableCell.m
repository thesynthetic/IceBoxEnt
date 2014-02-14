//
//  PictureTableCell.m
//  IceBoxEnt
//
//  Created by Ryan Hittner on 11/11/13.
//  Copyright (c) 2013 Ryan Hittner. All rights reserved.
//

#import "PictureTableCell.h"

@implementation PictureTableCell

@synthesize largeURL1;
@synthesize largeURL2;
@synthesize largeURL3;
@synthesize image1;
@synthesize image2;
@synthesize image3;
@synthesize delegate;
@synthesize indexBase;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

-(IBAction)buttonClick1:(id)sender
{
    [delegate launchViewer:largeURL1 forIndex:indexBase + 0];
}

-(IBAction)buttonClick2:(id)sender
{
    [delegate launchViewer:largeURL2 forIndex:indexBase + 1];
}

-(IBAction)buttonClick3:(id)sender
{
    [delegate launchViewer:largeURL3 forIndex:indexBase + 2];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




@end
