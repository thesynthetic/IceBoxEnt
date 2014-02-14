//
//  GalleryTableViewController.m
//  IceBoxEnt
//
//  Created by Ryan Hittner on 10/4/13.
//  Copyright (c) 2013 Ryan Hittner. All rights reserved.
//

#import "GalleryTableViewController.h"
#import <Parse/Parse.h>
#import "UIImageView+WebCache.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"


@interface GalleryTableViewController ()

@end

@implementation GalleryTableViewController

@synthesize albumArray;
@synthesize selected;


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
    
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Gallery"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Album"];
    [query orderByDescending:@"albumDate"];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            //NSLog(@"Successfully retrieved %d objects.", objects.count);
            albumArray = [objects copy];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return albumArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"GalleryTableCell";
    GalleryTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PFObject *tempObject = [albumArray objectAtIndex:indexPath.row];
    
    [cell.albumImage setImageWithURL:[NSURL URLWithString:[tempObject objectForKey:@"imageURL"] ] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    [cell.albumName setText:[tempObject objectForKey:@"albumName"]];
    [cell.albumPhotographer setText:[tempObject objectForKey:@"photographer"]];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MM-dd-yyyy"];
    
    NSString *dateString = [df stringFromDate:[tempObject objectForKey:@"albumDate"]];
    
    [cell.albumDate setText:dateString];
    
    // Configure the cell...
    
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selected = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"GalleryToAlbum"])
    {
        PFObject *tempObject = [albumArray objectAtIndex:self.tableView.indexPathForSelectedRow.row];
        id tracker = [[GAI sharedInstance] defaultTracker];
        
        NSString *name = [NSString stringWithFormat:@"%@ (%@)", [tempObject objectForKey:@"albumName"] , [tempObject objectForKey:@"photographer"]];
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"UI Actions"                                                               action:@"Clicked Album" label:name value:nil] build]];
        
        
        PictureTableViewController *viewController = [segue destinationViewController];
        [viewController setAlbumId:tempObject.objectId];
    }
}



@end
