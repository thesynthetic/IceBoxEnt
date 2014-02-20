//
//  LoginViewController.h
//  IceBoxEnt
//
//  Created by Ryan Hittner on 2/19/14.
//  Copyright (c) 2014 Ryan Hittner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface LoginViewController : UIViewController <FBLoginViewDelegate>

@property (nonatomic, retain) NSString *first_name;
@property (nonatomic, retain) NSString *last_name;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *profilePictureURL;
@property (nonatomic, retain) NSString *email;


@end
