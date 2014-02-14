//
//  DetailEventViewController.m
//  IceBoxEnt
//
//  Created by Ryan Hittner on 11/15/13.
//  Copyright (c) 2013 Ryan Hittner. All rights reserved.
//

#import "DetailEventViewController.h"
#import <Parse/Parse.h>
#import "UIImageView+WebCache.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"

@interface DetailEventViewController ()

@end

@implementation DetailEventViewController

@synthesize scrollView;
@synthesize textView;
@synthesize button;
@synthesize eventHeader;
@synthesize eventTitle;
@synthesize eventId;
@synthesize buttonLink;
@synthesize eventImageView;

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
    
    //Load all stuff based on id.
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    [query getObjectInBackgroundWithId:eventId block:^(PFObject *object, NSError *error) {
        if (!error) {
            NSString *eventContentText = [object objectForKey:@"eventContent"];
            NSAttributedString *test = [[NSAttributedString alloc] initWithString:eventContentText];
            

            CGRect frame = CGRectMake(textView.frame.origin.x,textView.frame.origin.y, textView.frame.size.width, [self textViewHeightForAttributedText:test andWidth:287.0]);
            
            [textView setFrame:frame];
            
            button.frame = CGRectMake(button.frame.origin.x, textView.frame.size.height+200, button.frame.size.width, button.frame.size.height);
            
            
            
            [scrollView setContentSize:CGSizeMake(320,textView.frame.size.height+240)];
            NSString *eventNameText = [object objectForKey:@"eventName"];
            NSString *eventHeaderText = [object objectForKey:@"eventHeader"];
            NSString *eventImageURLWideText = [object objectForKey:@"eventImageURLWide"];
            buttonLink = [object objectForKey:@"eventLink"];
            

            
            if (!buttonLink)
            {
                [button setHidden:YES];
                [button setUserInteractionEnabled:NO];
                
            }
            
            [eventHeader setText:eventHeaderText];
            [eventTitle setText:eventNameText];
            [textView setText:eventContentText];
            [textView setTextAlignment:NSTextAlignmentCenter];
            
            [eventImageView setImageWithURL:[NSURL URLWithString:eventImageURLWideText] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
            
        }
        else {
            //NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
    }];
    
    
    textView.scrollEnabled = NO;
    [scrollView setScrollEnabled:YES];
    
	// Do any additional setup after loading the view.
}

- (CGFloat)textViewHeightForAttributedText: (NSAttributedString*)text andWidth: (CGFloat)width {
    UITextView *calculationView = [[UITextView alloc] init];
    [calculationView setAttributedText:text];
    CGSize size = [calculationView sizeThatFits:CGSizeMake(width, FLT_MAX)];
    return size.height;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed {
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"UI Actions"                                                               action:@"Clicked Buy Ticket" label:[eventTitle text]  value:nil] build]];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:buttonLink]];
}

@end
