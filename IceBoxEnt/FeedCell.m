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
@synthesize profileImageView;
@synthesize name;
@synthesize moreActionSheet;
@synthesize photoID;
@synthesize elapsedTime;

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

-(IBAction)moreClicked:(id)sender
{
    
    moreActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Report Inappropriate" otherButtonTitles:nil, nil];
    
    [moreActionSheet showInView:self];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
        switch (buttonIndex)
        {
            case 0:
            {
                PFQuery *query = [PFQuery queryWithClassName:@"CrowdPicture"];
                [query getObjectInBackgroundWithId:photoID block:^(PFObject *object, NSError *error) {
                    // Do something with the returned PFObject in the gameScore variable.
                    object[@"active"] = @NO;
                    [object saveInBackground];
                }];

                break;
            }
            case 1:
                break;
                
        
        }
}


@end
