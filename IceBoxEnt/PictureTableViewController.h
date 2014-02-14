//
//  GalleryTableViewController.h
//  IceBoxEnt
//
//  Created by Ryan Hittner on 10/4/13.
//  Copyright (c) 2013 Ryan Hittner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureTableCell.h"


@interface PictureTableViewController : UITableViewController <PictureTableCellDelegate, UIPageViewControllerDataSource>

@property (nonatomic, retain) NSArray *pictureArray;
@property (nonatomic, retain) NSString *albumId;
@property (nonatomic, retain) NSString *fullScreenImageURL;
@property (nonatomic) NSUInteger currentIndex;

@property (nonatomic, strong) UIPageViewController *pv;
@property (nonatomic, retain) UIViewController *container;

@end
