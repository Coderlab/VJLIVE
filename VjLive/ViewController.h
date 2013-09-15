//
//  ViewController.h
//  VjLive
//
//  Created by Alessandro Belli on 26/04/13.
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
#import "FXBlurView.h"
#import "FlatUIKit.h"

@class avPlayer;
@class AVPlayer;


@interface ViewController : UIViewController<MPMediaPickerControllerDelegate,AVAudioPlayerDelegate>{
    UIPopoverController* popover;
    UIPopoverController* popover2;

    id segui;
    CGPoint  initialPosition;
    NSURL *urlSongDestra;
    NSURL *urlSongSinistra;
    NSURL *urlVideoDestra;
    NSURL *urlVideoSinistra;
    
    AVAudioPlayer *player;
    AVAudioPlayer *player2;
    
    NSString *chi;
    id delegate;
    NSMutableArray *arraySegmenti;
    NSTimer *sliderTimerSx;
    NSTimer *sliderTimerDx;
    NSDate* ddx;
    NSInteger mutesx;
    NSInteger mutedx;
    
    NSInteger loopdx;
    NSInteger loopsx;

    ContainerController *videoview;
    AVAsset *videoDestra;
    AVPlayerItem *videoItemDestra;
    AVAsset *videoSinistra;
    AVPlayerItem *videoItemSinistra;
    NSArray *audioTracksdx;
    NSArray *audioTracksdxMUTE;
    NSArray *audioTrackssx;
    NSArray *audioTrackssxMUTE;
    NSDateFormatter *dateFormatter;
    
    
    NSTimer *sliderTimerVideo;
    NSTimer *sliderTimerVideoSx;
    CGFloat nuovomassimodx;
    CGFloat nuovomassimosx;
    CGRect curFramesx;
    CGRect curFramedx;
    CGRect curFrameAlpha;
    CGFloat ratesx;
    CGFloat ratedx;
    NSInteger toccoTimeDx;
    NSInteger toccoTimeSx;
    MPMediaPickerController* picker2;
    MPMediaPickerController* picker;
    MPMediaPickerController* picker3;
    

}


@property (weak, nonatomic) IBOutlet UIView *questoSiDeveVedere;
@property (weak,nonatomic) ContainerController * checkVC;
@property (weak,nonatomic) ContainerController * checkVC2;

@property (weak, nonatomic) IBOutlet UISlider *timeSliderDx;
@property (weak, nonatomic) IBOutlet UISlider *timeSliderSx;
@property (weak, nonatomic) IBOutlet FUISegmentedControl *segmentedTransizione;
@property (weak, nonatomic) IBOutlet UILabel *labelTimeVideoDx;
@property (weak, nonatomic) IBOutlet UILabel *labelTimeVideoSx;

- (IBAction)showMediaPicker:(id)sender;
- (IBAction)showMediaPicker2:(id)sender;
-(IBAction)pausaPlayCanzoneSelezionatadx;
-(IBAction)stopCanzonedx:(id)sender;
-(IBAction)pausaPlayCanzoneSelezionatasx;
-(IBAction)stopCanzonesx:(id)sender;
-(IBAction)stopMovie;
-(IBAction)stopMovie2;
- (IBAction)sliderValueChanged:(UISlider *)sliderdx;
- (IBAction)sliderValueChangeddx:(UISlider *)sliderdx;
- (IBAction)alphaChannelSliderChanged:(UISlider *)alphaChannelSlider;
- (IBAction)volumeSliderAvplayer2Changed:(UISlider *)volumeSliderAvplayer2;
-(IBAction)muteVideoSx:(id)sender;
-(IBAction)muteVideoDx:(id)sender;
- (IBAction)playerItemmmDidReachEnd;
- (IBAction)playerItemmDidReachEnd;
- (IBAction)sliderRateVideo:(UISlider *)sliderSx;
- (IBAction)sliderRateVideodx:(UISlider *)sliderDx;
- (void)handleTapGesture:(UITapGestureRecognizer *)sender;


@property (strong, nonatomic) UIWindow *secondWindow;

@property (weak, nonatomic) IBOutlet UISlider *sliderDurationSx;
@property (weak, nonatomic) IBOutlet UISlider *sliderDurationDx;
@property (weak, nonatomic) IBOutlet UISlider *alphaChannelSlider;
@property (weak, nonatomic) IBOutlet UISlider *volumeSliderAvplayer2;
@property (weak, nonatomic) IBOutlet UISlider *sliderDx;
@property (weak, nonatomic) IBOutlet UISlider *sliderSx;


@property (strong, nonatomic) IBOutlet UISlider *sliderdx;
@property (strong, nonatomic) IBOutlet UISlider *slidersx;
@property (weak, nonatomic) IBOutlet UIButton *muteVideoDx;
@property (weak, nonatomic) IBOutlet UIButton *muteVideoSx;




@property (weak, nonatomic) IBOutlet UILabel *labelTempoSx;
@property (weak, nonatomic) IBOutlet UILabel *labelTempoDx;
@property (weak, nonatomic) IBOutlet FUIButton *preloadedSx;
@property (weak, nonatomic) IBOutlet FUIButton *addVideoSx;
@property (weak, nonatomic) IBOutlet FUIButton *preloadedDx;
@property (weak, nonatomic) IBOutlet FUIButton *addVideoDx;
@property (weak, nonatomic) IBOutlet UIButton *playSx;
@property (weak, nonatomic) IBOutlet UIButton *muteSx;
@property (weak, nonatomic) IBOutlet UIButton *stopSx;
@property (weak, nonatomic) IBOutlet UIButton *loopSx;
@property (weak, nonatomic) IBOutlet UIButton *loopDx;
@property (weak, nonatomic) IBOutlet UIButton *playDx;


@property (strong, nonatomic) IBOutlet UILabel *titolo1;
@property (strong, nonatomic) IBOutlet UILabel *titolo2;
@property (weak, nonatomic) IBOutlet UILabel *artista1;
@property (weak, nonatomic) IBOutlet UILabel *artista2;

@property (strong, nonatomic) UIPopoverController* popSegue;

@property (strong, nonatomic) IBOutlet UIButton *bottone;
@property (strong, nonatomic) IBOutlet UIButton *bottone2;
@property (strong, nonatomic) IBOutlet UIButton *bottone3;

@property (strong, nonatomic) IBOutlet UIImageView *cover1;
@property (strong, nonatomic) IBOutlet UIImageView *cover2;
@property (strong,nonatomic)    id delegate;


@property (weak, nonatomic) IBOutlet FXBlurView *scalette;
@property (strong, nonatomic) NSURL *urlVideo;

@property (readwrite,nonatomic) NSInteger su;
@property (readwrite,nonatomic) NSInteger chie;

@end
