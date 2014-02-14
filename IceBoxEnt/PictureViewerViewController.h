//
//  PictureViewerViewController.h
//  IceBoxEnt
//
//  Created by Ryan Hittner on 11/17/13.
//  Copyright (c) 2013 Ryan Hittner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureViewerViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, retain) IBOutlet UIImageView  *imageView;
@property (nonatomic, retain) NSString *imageURL;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@end
