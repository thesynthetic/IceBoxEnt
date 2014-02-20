//
//  FeedCell.h
//  IceBoxEnt
//
//  Created by Ryan Hittner on 2/8/14.
//  Copyright (c) 2014 Ryan Hittner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface FeedCell : UITableViewCell <UIActionSheetDelegate>

@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIImageView *profileImageView;
@property (nonatomic, retain) IBOutlet UILabel *name;
@property (nonatomic, retain) NSString *photoID;
@property (nonatomic, retain) UIActionSheet *moreActionSheet;

@end
