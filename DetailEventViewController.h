//
//  DetailEventViewController.h
//  IceBoxEnt
//
//  Created by Ryan Hittner on 11/15/13.
//  Copyright (c) 2013 Ryan Hittner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <float.h>

@interface DetailEventViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (nonatomic, retain) IBOutlet UIButton *button;
@property (nonatomic, retain) IBOutlet UILabel *eventTitle;
@property (nonatomic, retain) IBOutlet UILabel *eventHeader;
@property (nonatomic, retain) IBOutlet UIImageView *eventImageView;
@property (nonatomic, retain) NSString *eventId;
@property (nonatomic, retain) NSString *buttonLink;

@end
