//
//  PickerController.m
//  IceBoxEnt
//
//  Created by Ryan Hittner on 2/20/14.
//  Copyright (c) 2014 Ryan Hittner. All rights reserved.
//

#import "PickerController.h"

@interface PickerController ()

@end

@implementation PickerController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    [self setNeedsStatusBarAppearanceUpdate];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}
@end
