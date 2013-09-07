//
//  ContainerController.h
//  VjLive
//
//  Created by Alessandro Belli on 20/08/13.
//  Copyright (c) 2013 Alessandro Belli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CMTime.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVVideoComposition.h>
#import "avPlayer.h"
#import "ContainerController.h"

@class AVPlayer;
@class avPlayer;

@interface ContainerController : UIViewController{

    NSArray *audioTracksdx;
    NSArray *audioTracksdxMUTE;
    NSArray *audioTrackssx;
    NSArray *audioTrackssxMUTE;
}


@property (strong, nonatomic) UIStoryboardPopoverSegue* popSegue;
@property int chie;
@property int mutesx;
@property int mutedx;
@property int loopdx;
@property int loopsx;
@property float ratedx;
@property float ratesx;

@property (nonatomic,retain) IBOutlet avPlayer *playerViewsx;
@property (nonatomic,retain) IBOutlet avPlayer *playerViewdx;

@property (nonatomic,retain) AVPlayer *playerVideo;
@property (nonatomic,retain) AVPlayer *playerVideosx;
@property (weak, nonatomic) IBOutlet UIView *vistaGrande;


@end
