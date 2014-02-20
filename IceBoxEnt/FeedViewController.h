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
#import <FacebookSDK/FacebookSDK.h>
#import "LoginViewController.h"


@interface FeedViewController : UITableViewController <UIImagePickerControllerDelegate, AmazonServiceRequestDelegate, FBLoginViewDelegate, UIActionSheetDelegate>

@property (nonatomic, retain) NSMutableArray *imageArray;
@property (nonatomic, retain) NSString *first_name;
@property (nonatomic, retain) NSString *last_name;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *profilePictureURL;
@property (nonatomic, retain) NSString *email;

@property (nonatomic, retain) NSString *eventName;

@property (nonatomic, retain) NSArray *photoArray;

@property (nonatomic, retain) UIActionSheet *settingsActionSheet;
@property (nonatomic, retain) UIActionSheet *moreActionSheet;
@property (nonatomic, retain) UIImageView *waitScreen;

@property (nonatomic) BOOL statusBar;

-(void)startCamera;

@end
