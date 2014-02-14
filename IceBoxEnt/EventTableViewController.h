//
//  EventTableViewController.h
//  IceBoxEnt
//
//  Created by Ryan Hittner on 11/15/13.
//  Copyright (c) 2013 Ryan Hittner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventTableViewController : UITableViewController


@property (nonatomic, retain) NSArray *eventArray;
@property (nonatomic) NSInteger selected;

@end
