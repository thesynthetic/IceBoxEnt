//
//  ImageViewerController.h
//  IceBoxEnt
//
//  Created by Ryan Hittner on 1/1/14.
//  Copyright (c) 2014 Ryan Hittner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewerController : UIViewController

@property (retain, nonatomic) NSString *imageURL;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) IBOutlet UILabel *test;
@property (assign, nonatomic) NSInteger index;

@end
