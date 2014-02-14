//
//  FirstViewController.h
//  IceBoxEnt
//
//  Created by Ryan Hittner on 10/4/13.
//  Copyright (c) 2013 Ryan Hittner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController

@property (nonatomic, retain) IBOutlet UILabel *day;
@property (nonatomic, retain) IBOutlet UILabel *hour;
@property (nonatomic, retain) IBOutlet UILabel *minute;
@property (nonatomic, retain) IBOutlet UILabel *second;
@property (nonatomic, retain) IBOutlet UILabel *eventNameLabel;
@property (nonatomic, retain) IBOutlet UIView *box1;
@property (nonatomic, retain) IBOutlet UIView *box2;
@property (nonatomic, retain) IBOutlet UIView *box3;
@property (nonatomic, retain) IBOutlet UIView *box4;
@property (nonatomic, retain) IBOutlet UIView *box5;

@property (nonatomic, retain) NSString *eventDateString;
@property (nonatomic, retain) NSString *eventName;
@property (nonatomic, retain) NSDate *eventDate;

@property (nonatomic) BOOL partyTime;

@end
