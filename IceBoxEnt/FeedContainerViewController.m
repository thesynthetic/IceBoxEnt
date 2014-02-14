//
//  FeedContainerViewController.m
//  IceBoxEnt
//
//  Created by Ryan Hittner on 2/8/14.
//  Copyright (c) 2014 Ryan Hittner. All rights reserved.
//

#import "FeedContainerViewController.h"


@interface FeedContainerViewController ()

@end

@implementation FeedContainerViewController


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
    
    
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton addTarget:self
               action:@selector(closeLive) forControlEvents:UIControlEventTouchDown];
    [closeButton setImage:[UIImage imageNamed:@"XIcon"] forState:UIControlStateNormal];
    [closeButton setAlpha:0.7];
    closeButton.frame = CGRectMake(15.0, 20.0, 27.0, 27.0);
    
    UIButton *cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cameraButton addTarget:self
                    action:@selector(cameraClick) forControlEvents:UIControlEventTouchDown];
    [cameraButton setImage:[UIImage imageNamed:@"CameraIcon"] forState:UIControlStateNormal];
    [cameraButton setAlpha:0.7];
    cameraButton.frame = CGRectMake(270.0, 20.0, 27.0, 27.0);
    
    
    
//    feedView = (FeedViewController*)[[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"FeedViewController"];
    
    
    
    
//    [self.view addSubview:feedView.view];
//    [self.view insertSubview:closeButton aboveSubview:feedView.view];
//    [self.view insertSubview:cameraButton aboveSubview:feedView.view];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)closeLive
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)cameraClick
{
//    [feedView startCamera];
}

@end
