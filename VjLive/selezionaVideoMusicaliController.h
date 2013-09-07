//
//  selezionaVideoMusicaliController.h
//  VjLive
//  Created by Alessandro Belli on 04/05/13.
//  Copyright (c) 2013 Alessandro Belli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "VideoCell.h"
@protocol PopOverSelectionDelegate;
@protocol PopOverSelectionDelegate
@optional

- (void)popOverItemSelected:(NSURL *)selectedItem;
@end

@interface selezionaVideoMusicaliController : UIViewController<MPMediaPickerControllerDelegate,UITableViewDelegate,UITableViewDataSource>{
    id                              myDelegate;
}
@property (nonatomic,weak) id <PopOverSelectionDelegate> delegate;
@property (strong,nonatomic) NSArray *items;
@property (strong,nonatomic) NSURL *url;

@property (weak, nonatomic) IBOutlet UITableView *primaTabella;
@property (weak, nonatomic) IBOutlet UITableView *secondaTabella;

@end
