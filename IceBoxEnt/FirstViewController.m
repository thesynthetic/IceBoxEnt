//
//  FirstViewController.m
//  IceBoxEnt
//
//  Created by Ryan Hittner on 10/4/13.
//  Copyright (c) 2013 Ryan Hittner. All rights reserved.
//

#import "FirstViewController.h"
#import <Parse/Parse.h>
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"
#import "FeedContainerViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

@synthesize day;
@synthesize hour;
@synthesize minute;
@synthesize second;
@synthesize eventNameLabel;
@synthesize eventDate;
@synthesize eventDateString;
@synthesize eventName;
@synthesize box1;
@synthesize box2;
@synthesize box3;
@synthesize box4;
@synthesize box5;
@synthesize partyTime;
@synthesize userDefaults;

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    [self setNeedsStatusBarAppearanceUpdate];
    
    userDefaults = [NSUserDefaults standardUserDefaults];
    
    partyTime = NO;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *currentTime = [NSDate date];
    NSString *filterString = [dateFormatter stringFromDate:currentTime];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    [query orderByAscending:@"eventDateTime"];
    [query whereKey:@"eventDateTime" greaterThan:filterString];
    
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!error) {
            eventDateString = [object objectForKey:@"eventDateTime"];
            eventName = [object objectForKey:@"eventName"];
            NSLog(@"eventname: %@", eventName);
            [eventNameLabel setText:eventName];
            
            eventDate = [dateFormatter dateFromString:eventDateString];
            
            userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:self.eventName forKey:@"eventName"];
            [userDefaults setObject:self.eventDate forKey:@"eventDate"];
            [userDefaults synchronize];
            
            //Get string with +0000
            
            [self updateCountdown];
            [self initiateTimer];
        }
        else {
            //NSLog(@"Error: %@ %@", error, [error userInfo]);
        }

    }];
    
    [box1 setFrame:CGRectMake(-75.0,50.0,75.0,75.0)];
    [box2 setFrame:CGRectMake(-75.0,125.0,75.0,75.0)];
    [box3 setFrame:CGRectMake(-75.0,200.0,75.0,75.0)];
    [box4 setFrame:CGRectMake(-75.0,275.0,75.0,75.0)];
    [box5 setFrame:CGRectMake(-75.0,350.0,75.0,75.0)];
    
    //[self  updateCountdown];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Home Screen"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    
}

-(void)initiateTimer
{
    
    
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationCurveEaseInOut
                     animations:^{
                         [box1 setFrame:CGRectMake(0.0,50.0,75.0,75.0)];
                         
                         [UIView animateWithDuration:1.0 delay:0.2 options: UIViewAnimationCurveEaseInOut animations:^{[box2 setFrame:CGRectMake(0.0,125.0,75.0,75.0)];
                         [UIView animateWithDuration:1.0 delay:0.4 options: UIViewAnimationCurveEaseInOut animations:^{[box3 setFrame:CGRectMake(0.0,200.0,75.0,75.0)];
                         [UIView animateWithDuration:1.0 delay:0.6 options: UIViewAnimationCurveEaseInOut animations:^{[box4 setFrame:CGRectMake(0.0,275.0,75.0,75.0)];
                         [UIView animateWithDuration:1.0 delay:0.8 options: UIViewAnimationCurveEaseInOut animations:^{[box5 setFrame:CGRectMake(0.0,350.0,75.0,75.0)];} completion:^(BOOL finished){}];
                         } completion:^(BOOL finished){}];
                             
                         } completion:^(BOOL finished){}];
                             
                         } completion:^(BOOL finished){}];
                         
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target:self selector:@selector(updateCountdown) userInfo:nil repeats: YES];
    
}

-(void)updateCountdown
{
    second.alpha = 1;
 
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:now toDate:eventDate options:0];
    
    NSInteger hours    = [dateComponents hour];
    NSInteger minutes  = [dateComponents minute];
    NSInteger seconds  = [dateComponents second];

    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *componentsDaysDiff = [gregorianCalendar components:NSDayCalendarUnit
        fromDate:now toDate:eventDate options:0];
    
    if (hours < 0 || minutes < 0 || seconds < 0)
    {
        day.text=@"00";
        hour.text=@"00";
        minute.text=@"00";
        second.text=@"00";
        partyTime = YES;
        [eventNameLabel setTextColor:[UIColor colorWithRed:10.0/255.0 green:159.0/255.0 blue:250.0/255.0 alpha:1.0]];


        if (eventNameLabel.tag == 1) {
            [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationCurveEaseInOut animations:^{
                [eventNameLabel setTransform:CGAffineTransformMakeScale(1/1.1, 1/1.1)];
                [eventNameLabel setTag:2];
            }
                             completion:^(BOOL finished) {}];
        }
        else {
            [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationCurveEaseInOut animations:^{
                [eventNameLabel setTransform:CGAffineTransformMakeScale(1.1, 1.1)];
                [eventNameLabel setTag:1];
            }
                             completion:^(BOOL finished) {}];
            
        }
        
        [userDefaults setObject:@"YES" forKey:@"partyTime"];
        [userDefaults synchronize];
    }
    else {
        partyTime = NO;
        [eventNameLabel setTextColor:[UIColor whiteColor]];
        day.text=[NSString stringWithFormat:@"%02d",componentsDaysDiff.day];
        hour.text=[NSString stringWithFormat:@"%02d",hours];
        minute.text=[NSString stringWithFormat:@"%02d",minutes];
        second.text=[NSString stringWithFormat:@"%02d",seconds];
        [userDefaults setObject:@"NO" forKey:@"partyTime"];
        [userDefaults synchronize];
    }
}

-(BOOL)prefersStatusBarHidden
{
    return NO;
}




@end
