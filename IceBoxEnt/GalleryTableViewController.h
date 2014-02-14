//
//  GalleryTableViewController.h
//  IceBoxEnt
//
//  Created by Ryan Hittner on 10/4/13.
//  Copyright (c) 2013 Ryan Hittner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GalleryTableCell.h"
#import "PictureTableViewController.h"

@interface GalleryTableViewController : UITableViewController

@property (nonatomic, retain) NSArray *albumArray;
@property (nonatomic) NSInteger selected;


@end
