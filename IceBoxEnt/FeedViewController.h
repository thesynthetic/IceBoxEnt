//
//  FeedViewController.h
//  IceBoxEnt
//
//  Created by Ryan Hittner on 2/8/14.
//  Copyright (c) 2014 Ryan Hittner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "FeedContainerViewController.h"
#import <AWSS3/AWSS3.h>
#import <AWSRuntime/AWSRuntime.h>


@interface FeedViewController : UITableViewController <UIImagePickerControllerDelegate, AmazonServiceRequestDelegate>

@property (nonatomic, retain) NSMutableArray *imageArray;

-(void)startCamera;

@end
