//
//  GalleryTableViewController.m
//  IceBoxEnt
//
//  Created by Ryan Hittner on 10/4/13.
//  Copyright (c) 2013 Ryan Hittner. All rights reserved.
//

#import "PictureTableViewController.h"
#import <Parse/Parse.h>
#import "UIImageView+WebCache.h"
#import "ImageViewerController.h"
#import "ContainerViewController.h"

@interface PictureTableViewController ()

@end

@implementation PictureTableViewController

@synthesize pictureArray;
@synthesize albumId;
@synthesize fullScreenImageURL;
@synthesize pv;
@synthesize currentIndex;
@synthesize container;


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
    
    PFQuery *query = [PFQuery queryWithClassName:@"Picture"];
    [query whereKey:@"albumId" containsString:albumId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            //NSLog(@"Successfully retrieved %d pictures.", objects.count);
            pictureArray = [objects copy];
            [[self tableView] reloadData];
        } else {
            // Log details of the failure
            //NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 79.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return floor(pictureArray.count/3);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PictureTableCell";
    PictureTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.delegate = self;
    
    PFObject *tempObject1 = [pictureArray objectAtIndex:indexPath.row*3+0];
    PFObject *tempObject2 = [pictureArray objectAtIndex:indexPath.row*3+1];
    PFObject *tempObject3 = [pictureArray objectAtIndex:indexPath.row*3+2];
    
    
    [cell.image1 setImageWithURL:[NSURL URLWithString:[tempObject1 objectForKey:@"smallURL"] ] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    [cell.image2 setImageWithURL:[NSURL URLWithString:[tempObject2 objectForKey:@"smallURL"] ] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    [cell.image3 setImageWithURL:[NSURL URLWithString:[tempObject3 objectForKey:@"smallURL"] ] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    cell.largeURL1 = [tempObject1 objectForKey:@"largeURL"];
    cell.largeURL2 = [tempObject2 objectForKey:@"largeURL"];
    cell.largeURL3 = [tempObject3 objectForKey:@"largeURL"];
    
    [cell setIndexBase:indexPath.row*3];
    
    
    // Configure the cell...
    
    return cell;
}



/*
 //Override to support conditional editing of the table view.
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

-(void)launchViewer:(NSString *)largeURL forIndex:(NSInteger)index
{
    container = [[ContainerViewController alloc] init];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(closeViewer)
     forControlEvents:UIControlEventTouchDown];
    //[button setTitle:@"Close" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"DoneButton"] forState:UIControlStateNormal];
     button.frame = CGRectMake(255.0, 15.0, 51.0, 27.0);

    
    pv = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];

    pv.dataSource = self;
    
    ImageViewerController *initialViewController = [self viewControllerAtIndex:index];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [container.view addSubview:button];
    [container.view addSubview:pv.view];
    
    [pv setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    currentIndex = index;
    
    [container setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:container animated:YES completion:nil];

    [container.view bringSubviewToFront:button];
}




- (ImageViewerController *)viewControllerAtIndex:(NSUInteger)index {
    ImageViewerController *childViewController = [[ImageViewerController alloc] init];
    
    [childViewController setImageURL:[[pictureArray objectAtIndex:index] objectForKey:@"largeURL"]];
    [childViewController setIndex:index];
    
    return childViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(ImageViewerController *)viewController index];
    
    if (index == 0) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {

    NSUInteger index = [(ImageViewerController *)viewController index];
    
    index++;
    
    if (index == pictureArray.count) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

-(void)closeViewer
{
    [container dismissViewControllerAnimated:YES completion:nil];
    
}



@end
