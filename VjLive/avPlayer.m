//
//  avPlayer.m
//  VjLive
//
//  Created by Alessandro Belli on 06/05/13.
//  Copyright (c) 2013 Alessandro Belli. All rights reserved.
//

#import "avPlayer.h"
#import <AVFoundation/AVFoundation.h>

@implementation avPlayer

+ (Class)layerClass
{
    
    return [AVPlayerLayer class];
}

- (AVPlayer*)player
{
    
    return [(AVPlayerLayer*)[self layer]player];
}

- (void)setMovieToPlayer:(AVPlayer *)player
{

    [(AVPlayerLayer*)[self layer]setPlayer:player];
    [self setVideoFillMode:@"AVLayerVideoGravityResize"];
}
- (void)setVolume:(CGFloat)volume chi:(AVPlayer*)player{
    NSArray *audioTracks = [player.currentItem.asset tracksWithMediaType:AVMediaTypeAudio];
    NSMutableArray *allAudioParams = [NSMutableArray array];
    
        AVMutableAudioMixInputParameters *audioInputParams = [AVMutableAudioMixInputParameters audioMixInputParameters];
        [audioInputParams setVolume:volume atTime:kCMTimeZero];
        [audioInputParams setTrackID:[audioTracks[0] trackID]];
        [allAudioParams addObject:audioInputParams];
    
    AVMutableAudioMix *audioMix = [AVMutableAudioMix audioMix];
    [audioMix setInputParameters:allAudioParams];
    [player.currentItem setAudioMix:audioMix];
}

/* Specifies how the video is displayed within a player layer’s bounds.
 (AVLayerVideoGravityResizeAspect is default) */
- (void)setVideoFillMode:(NSString *)fillMode
{
	AVPlayerLayer *playerLayer = (AVPlayerLayer*)[self layer];
	playerLayer.videoGravity = fillMode;
}
- (CGRect)getVideoContentFrame {
    AVPlayerLayer *avLayer = (AVPlayerLayer *)[self layer];
    // AVPlayerLayerContentLayer
    CALayer *layer = (CALayer *)[[avLayer sublayers] objectAtIndex:0];
    CGRect transformedBounds = CGRectApplyAffineTransform(layer.bounds, CATransform3DGetAffineTransform(layer.sublayerTransform));
    return transformedBounds;
}
@end
