//
//  selezionaVideoMusicaliController.m
//  VjLive
//
//  Created by Alessandro Belli on 22/08/13.
//  Copyright (c) 2013 Alessandro Belli. All rights reserved.
//

#import "selezionaVideoMusicaliController.h"
#import "UITableViewCell+FlatUI.h"
#import "UIColor+FlatUI.h"

@interface selezionaVideoMusicaliController ()

@end

@implementation selezionaVideoMusicaliController
@synthesize items;


- (void)viewDidLoad
{
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    MPMediaPropertyPredicate *predicate = [MPMediaPropertyPredicate predicateWithValue:[NSNumber numberWithInteger:MPMediaTypeAnyVideo] forProperty:MPMediaItemPropertyMediaType];
    
    MPMediaQuery *query = [[MPMediaQuery alloc] init];
    [query addFilterPredicate:predicate];
    
    items = [query items];
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
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    MPMediaPropertyPredicate *predicate = [MPMediaPropertyPredicate predicateWithValue:[NSNumber numberWithInteger:MPMediaTypeMusicVideo] forProperty:MPMediaItemPropertyMediaType];
    
    MPMediaQuery *query = [[MPMediaQuery alloc] init];
    [query addFilterPredicate:predicate];
    
    items = [query items];
    
    // Return the number of rows in the section.
    return [items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
 //   VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    
    MPMediaItem* item = [items objectAtIndex:row];
    
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

    
    NSString* title = [item valueForProperty:MPMediaItemPropertyTitle];

    NSNumber* durata = [item valueForProperty:MPMediaItemPropertyPlaybackDuration];
    float secondi =   [durata floatValue];
  int min = secondi/60;
    int sec = lroundf(secondi)%60;
    NSString *durataS = [NSString stringWithFormat:@"%d:%2.02d", min,sec];
    
    NSString* artista = [item valueForProperty:MPMediaItemPropertyArtist];

    
    cell.titoloVideo.text = title;
    cell.titoloVideo.font = [UIFont flatFontOfSize:20.0];
    cell.durataVideo.text = durataS;
    cell.artistaVideo.text = artista;
    cell.artistaVideo.font =  [UIFont flatFontOfSize:18.0];

    MPMediaItemArtwork *artWork = [item valueForProperty:MPMediaItemPropertyArtwork];
    
    cell.snapVideo.image = [artWork imageWithSize:CGSizeMake(120, 70)];

    
    if ([[item valueForProperty:MPMediaItemPropertyIsCloudItem] boolValue]) {
        cell.titoloVideo.textColor = [UIColor grayColor];
        cell.durataVideo.textColor = [UIColor grayColor];
        cell.artistaVideo.textColor = [UIColor grayColor];
        cell.snapVideo.alpha = 0.5;
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.userInteractionEnabled = NO;

    }
    
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    MPMediaPropertyPredicate *predicate = [MPMediaPropertyPredicate predicateWithValue:[NSNumber numberWithInteger:MPMediaTypeMusicVideo] forProperty:MPMediaItemPropertyMediaType];
    NSInteger row = indexPath.row;
    MPMediaQuery *query = [[MPMediaQuery alloc] init];
    [query addFilterPredicate:predicate];
    
    items = [query items];
    
    
    MPMediaItem* item = [items objectAtIndex:row];
    
    
    _url = [item valueForProperty:MPMediaItemPropertyAssetURL];
    NSString *titolo = [item valueForProperty:MPMediaItemPropertyTitle];
    [self.delegate popOverItemSelected:_url titoloItem:titolo];

}


@end
