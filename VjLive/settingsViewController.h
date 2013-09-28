//
//  settingsViewController.h
//  VjLive
//
//  Created by Alessandro Belli on 18/09/13.
//  Copyright (c) 2013 Alessandro Belli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "FlatUIKit.h"
@protocol settingsDelegate;
@protocol settingsDelegate
@optional

- (void)changeColor:(UIColor*)colore;

@end
@interface settingsViewController : UIViewController{
    MPVolumeView * volumeView;
    UIColor *backogrund;
    NSString *currentImage;
}
@property (nonatomic,weak) id <settingsDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *settingsLabel;
@property (weak, nonatomic) IBOutlet UISwitch *switchNightMode;

@property (weak, nonatomic) IBOutlet FUIButton *buttonBackground;
- (IBAction)changeBackgroundColour:(id)sender;

@end
