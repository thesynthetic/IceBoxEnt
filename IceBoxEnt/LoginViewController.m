//
//  LoginViewController.m
//  IceBoxEnt
//
//  Created by Ryan Hittner on 2/19/14.
//  Copyright (c) 2014 Ryan Hittner. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize first_name;
@synthesize last_name;
@synthesize username;
@synthesize email;
@synthesize profilePictureURL;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    FBLoginView *loginView = [[FBLoginView alloc] initWithReadPermissions:@[@"basic_info", @"email"]];
    [loginView setFrame:CGRectMake(60,350,200,50 )];
    
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:loginView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0f constant:50.0f];
    [self.view addConstraint:constraint1];
    
    [loginView setDelegate:self];
    [self.view addSubview:loginView];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Facebook Login Delegate

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
    
    self.email = [user objectForKey:@"email"];
    self.first_name = [user objectForKey:@"first_name"];
    self.last_name = [user objectForKey:@"last_name"];
    self.username = [user objectForKey:@"username"];
    self.profilePictureURL = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture", self.username];
    
    //Saving to User Defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.first_name forKey:@"first_name"];
    [defaults setObject:self.last_name forKey:@"last_name"];
    [defaults setObject:self.username forKey:@"username"];
    [defaults setObject:self.email forKey:@"email"];
    [defaults setObject:self.profilePictureURL forKey:@"profilePictureURL"];
    [defaults synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)closeWindow:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
