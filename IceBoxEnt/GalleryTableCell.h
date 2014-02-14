//
//  GalleryTableCell.h
//  IceBoxEnt
//
//  Created by Ryan Hittner on 10/6/13.
//  Copyright (c) 2013 Ryan Hittner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryTableCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *albumName;
@property (nonatomic, strong) IBOutlet UILabel *albumPhotographer;
@property (nonatomic, strong) IBOutlet UILabel *albumDate;
@property (nonatomic, strong) IBOutlet UIImageView *albumImage;




@end
