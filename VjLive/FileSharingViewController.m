//
//  FileSharingViewController.m
//  VjLive
//
//  Created by Alessandro Belli on 10/08/13.
//  Copyright (c) 2013 Alessandro Belli. All rights reserved.
//

#import "FileSharingViewController.h"
#import "FUIPopoverBackgroundView.h"
#import "UITableViewCell+FlatUI.h"
#import "UIColor+FlatUI.h"

@interface FileSharingViewController ()

@end

@implementation FileSharingViewController
@synthesize items;

- (void)viewDidLoad
{
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    //Set the separator color
    self.primaTabella.separatorColor = [UIColor peterRiverColor];
    
    //Set the background color
    self.primaTabella.backgroundColor = [UIColor peterRiverColor];
    //Set the separator color
    self.secondaTabella.separatorColor = [UIColor peterRiverColor];
    
    //Set the background color
    self.secondaTabella.backgroundColor = [UIColor peterRiverColor];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *fileList =
    [manager contentsOfDirectoryAtPath:documentsDirectory error:nil];

    // Return the number of sections.
    return [fileList count];}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    static NSString *CellIdentifier = @"Cell";
   //VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    VideoCell *cell = [VideoCell configureFlatCellWithColor:[UIColor peterRiverColor] selectedColor:[UIColor belizeHoleColor] reuseIdentifier:CellIdentifier inTableView:tableView];
    
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        [cell configureFlatCellWithColor:[UIColor greenSeaColor] selectedColor:[UIColor cloudsColor]];
        cell.cornerRadius = 5.f; //Optional
        if (tableView.style == UITableViewStyleGrouped) {
            cell.separatorHeight = 1.f; //Optional
        }
        else {
            cell.separatorHeight = 0.;
        }
    }

    NSInteger row = indexPath.row;
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *fileList = [manager contentsOfDirectoryAtPath:documentsDirectory error:nil];

    
    NSArray *path =[manager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    
    cell.titoloVideo.text = [NSString stringWithFormat:@"%@", fileList[row]];
    cell.titoloVideo.font =  [UIFont flatFontOfSize:19.0];

    fullpath = [NSString stringWithFormat:@"%@%@", path[0], fileList[row]];

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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    static NSString *CellIdentifier = @"Cell";
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *fileList =
    [manager contentsOfDirectoryAtPath:documentsDirectory error:nil];    

    NSArray *path =[manager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];

    cell.titoloVideo.text = fileList[row];
    
    finalfullpath = [NSString stringWithFormat:@"%@%@", path[0], fileList[row]];


    NSString* urlTextEscaped = [finalfullpath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSURL *url = [NSURL URLWithString:urlTextEscaped];

    [self.delegate popOverItemSelected:url];
    
    
    

    
}
@end