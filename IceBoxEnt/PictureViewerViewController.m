//
//  PictureViewerViewController.m
//  IceBoxEnt
//
//  Created by Ryan Hittner on 11/17/13.
//  Copyright (c) 2013 Ryan Hittner. All rights reserved.
//

#import "PictureViewerViewController.h"
#import "UIImageView+WebCache.h"

#define ZOOM_VIEW_TAG 100
#define ZOOM_STEP 2.0

@interface PictureViewerViewController ()

@end

@implementation PictureViewerViewController

@synthesize imageView;
@synthesize imageURL;
@synthesize scrollView;

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
    
    
    //imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,360,200)];
    [imageView setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    [imageView setTag:ZOOM_VIEW_TAG];
    
    // add gesture recognizers to the image view
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    UITapGestureRecognizer *twoFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingerTap:)];
    
    [doubleTap setNumberOfTapsRequired:2];
    [twoFingerTap setNumberOfTouchesRequired:2];
    
    [imageView addGestureRecognizer:singleTap];
    [imageView addGestureRecognizer:doubleTap];
    [imageView addGestureRecognizer:twoFingerTap];
    
    float minimumScale = [scrollView frame].size.width  / [imageView frame].size.width;
    [scrollView setMinimumZoomScale:minimumScale];
    [scrollView setMaximumZoomScale:3.0f];
    [scrollView setZoomScale:minimumScale];
    [scrollView setDelegate:self];
    [scrollView setScrollEnabled:YES];
    
    //[self.scrollView setContentSize:CGSizeMake(360,900)];
    //self.scrollView.minimumZoomScale = 1.0f;
    //self.scrollView.maximumZoomScale = 5.0f;
    //self.scrollView.zoomScale = 1.0f;
    //[self.scrollView addSubview:imageView];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
     
-(IBAction)closeWindow:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:Nil];
}

-(void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer
{
    NSLog(@"Double Tappe");
    CGPoint pointInView = [recognizer locationInView:self.imageView];
    
    // 2
    CGFloat newZoomScale = self.scrollView.zoomScale * 1.5f;
    newZoomScale = MIN(newZoomScale, self.scrollView.maximumZoomScale);
    
    // 3
    CGSize scrollViewSize = self.scrollView.bounds.size;
    
    CGFloat w = scrollViewSize.width / newZoomScale;
    CGFloat h = scrollViewSize.height / newZoomScale;
    CGFloat x = pointInView.x - (w / 2.0f);
    CGFloat y = pointInView.y - (h / 2.0f);
    
    CGRect rectToZoomTo = CGRectMake(x, y, w, h);
    
    // 4
    [self.scrollView zoomToRect:rectToZoomTo animated:YES];
}


- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer {
    // Zoom out slightly, capping at the minimum zoom scale specified by the scroll view
    CGFloat newZoomScale = self.scrollView.zoomScale / 1.5f;
    newZoomScale = MAX(newZoomScale, self.scrollView.minimumZoomScale);
    [self.scrollView setZoomScale:newZoomScale animated:YES];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [[self scrollView] viewWithTag:ZOOM_VIEW_TAG];
}


- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    // single tap does nothing for now
}

- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {
    // double tap zooms in
    float newScale = [[self scrollView] zoomScale] * ZOOM_STEP;
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
    [[self scrollView] zoomToRect:zoomRect animated:YES];
}

- (void)handleTwoFingerTap:(UIGestureRecognizer *)gestureRecognizer {
    // two-finger tap zooms out
    if ([[self scrollView] zoomScale] != 1.0f)
    {
        float newScale = [[self scrollView] zoomScale] / ZOOM_STEP;
        CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
        [[self scrollView] zoomToRect:zoomRect animated:YES];
    }
    
}

#pragma mark Utility methods

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    // the zoom rect is in the content view's coordinates.
    //    At a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.
    //    As the zoom scale decreases, so more content is visible, the size of the rect grows.
    zoomRect.size.height = [[self scrollView] frame].size.height / scale;
    zoomRect.size.width  = [[self scrollView] frame].size.width  / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}


@end
