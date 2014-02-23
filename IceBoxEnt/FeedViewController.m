//
//  FeedViewController.m
//  IceBoxEnt
//
//  Created by Ryan Hittner on 2/8/14.
//  Copyright (c) 2014 Ryan Hittner. All rights reserved.
//

#import "FeedViewController.h"
#import <Parse/Parse.h>
#import "FeedCell.h"
#import "PickerController.h"

@interface FeedViewController ()

@end

@implementation FeedViewController

@synthesize imageArray;
@synthesize first_name;
@synthesize last_name;
@synthesize username;
@synthesize email;
@synthesize profilePictureURL;
@synthesize photoArray;
@synthesize eventName;
@synthesize moreActionSheet;
@synthesize settingsActionSheet;
@synthesize waitScreen;
@synthesize statusBar;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    UIViewController *waitView = (UIViewController*)[[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"WaitScreen"];

    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    eventName = [defaults objectForKey:@"eventName"];
    
    

        [self.navigationItem setTitle:[NSString stringWithFormat:@"Live @ %@",eventName]];
        
        imageArray = [[NSMutableArray alloc] init];
        
        
        
        self.navigationController.navigationBar.translucent = YES;
        self.automaticallyAdjustsScrollViewInsets = YES;
        
        
        //Add Refresh Control
        UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
        [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
        [self setRefreshControl:refreshControl];
        [refreshControl beginRefreshing];
        [self refresh:refreshControl];
        
        
        UIButton *settingsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [settingsButton addTarget:self
                           action:@selector(settingsClick) forControlEvents:UIControlEventTouchDown];
        [settingsButton setImage:[UIImage imageNamed:@"Settings"] forState:UIControlStateNormal];
        [settingsButton setAlpha:0.7];
        settingsButton.frame = CGRectMake(6.0, -4.0, 45.0, 45.0);
        
        
        UIButton *cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cameraButton addTarget:self
                         action:@selector(startCamera) forControlEvents:UIControlEventTouchDown];
        [cameraButton setImage:[UIImage imageNamed:@"CameraIcon"] forState:UIControlStateNormal];
        [cameraButton setAlpha:0.7];
        cameraButton.frame = CGRectMake(266.0, -4.0, 45.0, 45.0);
        
        [self.navigationController.navigationBar addSubview:settingsButton];
        [self.navigationController.navigationBar addSubview:cameraButton];
    
    if (![[defaults objectForKey:@"partyTime"] isEqualToString:@"YES"]){
        waitScreen = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"WaitScreen"]];
        [self.navigationController.navigationBar addSubview:waitScreen];
        statusBar = TRUE;
        [self prefersStatusBarHidden];
        [self setNeedsStatusBarAppearanceUpdate];
    }
    
    
    
}


-(void)viewDidAppear:(BOOL)animated
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([[defaults objectForKey:@"partyTime"] isEqualToString:@"YES"]){
        [waitScreen removeFromSuperview];
        statusBar = FALSE;
        [self prefersStatusBarHidden];
        [self setNeedsStatusBarAppearanceUpdate];
    }

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [photoArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FeedCell";
    FeedCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    

    
    PFObject *tempObject = [photoArray objectAtIndex:indexPath.row];
    
    [cell.imageView setImageWithURL:[NSURL URLWithString:[tempObject objectForKey:@"imageURL"]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    [cell.profileImageView setImageWithURL:[NSURL URLWithString:[tempObject objectForKey:@"profilePictureURL"]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    NSString *first = [tempObject objectForKey:@"first_name"];
    NSString *last = [tempObject objectForKey:@"last_name"];
    NSDate *createdAt = [tempObject createdAt];
    
    //Elapsed time calculation
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:now toDate:createdAt options:0];
    
    NSInteger hours    = [dateComponents hour];
    NSInteger minutes  = [dateComponents minute];
    NSInteger seconds  = [dateComponents second];
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *componentsDaysDiff = [gregorianCalendar components:NSDayCalendarUnit
                                                            fromDate:now toDate:createdAt options:0];

    NSString *elapsedString;
    
    if (-componentsDaysDiff.day > 6){
        elapsedString = [NSString stringWithFormat:@"%iw", (int)(-componentsDaysDiff.day / 7)];
    }
    else if (-componentsDaysDiff.day > 0)
    {
        elapsedString = [NSString stringWithFormat:@"%id",-componentsDaysDiff.day];
    }
    else if (-hours > 0)
    {
        elapsedString = [NSString stringWithFormat:@"%ih",-hours];
    }
    else if (-minutes > 0)
    {
        elapsedString = [NSString stringWithFormat:@"%im",-minutes];
    }
    else
    {
        elapsedString = [NSString stringWithFormat:@"%is",-seconds];
    }
    

    cell.elapsedTime.text = elapsedString;
    
    

    cell.name.text = [NSString stringWithFormat:@"%@ %c", first, [last characterAtIndex:0]];
    cell.photoID = [tempObject objectId];
    
    
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

-(IBAction)initiateImagePicker:(id)sender
{
//    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
//    imagePicker.delegate = self;
//    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//    imagePicker.allowsEditing = YES;
//    imagePicker.allowsEditing = YES;
//    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    if(!img) img = [info objectForKey:UIImagePickerControllerOriginalImage];

    [imageArray insertObject:img atIndex:0];
    
    
    //Get Date for Filename
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss-zzz"];
    NSDate *currentTime = [NSDate date];
    NSString *dateString = [dateFormatter stringFromDate:currentTime];
    NSString *filename = [NSString stringWithFormat:@"%@.jpg",dateString];


    //Save image to S3
    AmazonS3Client *s3 = [[AmazonS3Client alloc] initWithAccessKey:@"AKIAJYCZMCQO6AFBRTWA" withSecretKey:@"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"];
    S3TransferManager *tm = [S3TransferManager new];
    tm.s3 = s3;
    S3PutObjectRequest *putObjectRequest = [[S3PutObjectRequest alloc] initWithKey:filename inBucket:@"iceboxent"];
    CGSize newSize = CGSizeMake(img.size.height*0.5, img.size.width*0.5);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [img drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *imageData = UIImageJPEGRepresentation(newImage, 0.8);
    [putObjectRequest setData:imageData];
    [tm upload:putObjectRequest];
    
    
    //Adding photo to Parse
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    PFObject *crowdPicture = [PFObject objectWithClassName:@"CrowdPicture"];
    crowdPicture[@"email"] = [defaults objectForKey:@"email"];
    crowdPicture[@"username"] = [defaults objectForKey:@"username"];
    crowdPicture[@"active"] = @YES;
    crowdPicture[@"imageURL"] = [NSString stringWithFormat:@"https://s3.amazonaws.com/iceboxent/%@", filename];
    crowdPicture[@"profilePictureURL"] = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture", [defaults objectForKey:@"username"]];
    crowdPicture[@"eventName"] = [defaults objectForKey:@"eventName"];
    crowdPicture[@"first_name"] = [defaults objectForKey:@"first_name"];
    crowdPicture[@"last_name"] = [defaults objectForKey:@"last_name"];
    [crowdPicture saveInBackground];
    
}

-(void)addPicture:(UIImage *)image
{
    
}

-(void)startCamera
{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"username"]){
        PickerController *imagePicker = [[PickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.allowsEditing = YES;
        imagePicker.allowsEditing = YES;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    else {
        LoginViewController *loginViewController = (LoginViewController*)[[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self presentViewController:loginViewController animated:YES completion:nil];
    }
    
}


-(void)settingsClick
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:@"username"])
    {
        NSString *title = [NSString stringWithFormat:@"Logged in as %@ %@",[defaults objectForKey:@"first_name"], [defaults objectForKey:@"last_name"]];
        settingsActionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Logout" otherButtonTitles:nil, nil];
            [settingsActionSheet showInView:self.view];
    }
    else
    {
        
        settingsActionSheet = [[UIActionSheet alloc] initWithTitle:@"Not logged in" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
            [settingsActionSheet showInView:self.view];
    }
    

}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
   
        switch (buttonIndex)
        {
            case 0:
            {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:nil forKey:@"username"];
                [defaults synchronize];
                [[FBSession activeSession] closeAndClearTokenInformation];
                break;
            }
            case 1:
                break;

        }
    
}


- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {

    self.email = [user objectForKey:@"email"];
    self.first_name = [user objectForKey:@"first_name"];
    self.last_name = [user objectForKey:@"last_name"];
    self.username = [user objectForKey:@"username"];
    self.profilePictureURL = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture", self.username];
    
    NSLog(@"First Name: %@", self.first_name);
    NSLog(@"Last Name: %@", self.last_name);
    NSLog(@"Username: %@", self.username);
    NSLog(@"Email: %@", self.email);
    NSLog(@"Profile Picture URL: %@", self.profilePictureURL);
}

- (void)refresh:(id)sender{
    
    PFQuery *query = [PFQuery queryWithClassName:@"CrowdPicture"];
    [query orderByDescending:@"createdAt"];
    [query whereKey:@"active" equalTo:@YES];
    [query whereKey:@"eventName" equalTo:eventName];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            photoArray = [objects copy];
            NSLog(@"Count: %i", [objects count]);
            [[self tableView] reloadData];
        }
        else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    
        [(UIRefreshControl *)sender endRefreshing];
    }];
}

-(BOOL)prefersStatusBarHidden
{
    return statusBar;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

@end
