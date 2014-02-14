//
//  ImageViewerController.m
//  IceBoxEnt
//
//  Created by Ryan Hittner on 1/1/14.
//  Copyright (c) 2014 Ryan Hittner. All rights reserved.
//

#import "ImageViewerController.h"
#import "ImageScrollView.h"

@interface ImageViewerController ()

@end

@implementation ImageViewerController

@synthesize imageURL;
@synthesize imageView;
@synthesize test;
@synthesize index;


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
}


- (void)loadView
{
    ImageScrollView *scrollView = [[ImageScrollView alloc] init];
    [scrollView setImageURL:imageURL];
    [scrollView displayImage];
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view =  scrollView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
