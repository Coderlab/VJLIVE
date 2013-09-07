//
//  avPlayer.h
//  VjLive
//
//  Created by Alessandro Belli on 06/05/13.
//  Copyright (c) 2013 Alessandro Belli. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AVPlayer;
@interface avPlayer : UIView

@property (nonatomic,retain) AVPlayer* player;

-(void)setMovieToPlayer:(AVPlayer*)player;
- (void)setVideoFillMode:(NSString *)fillMode;
- (CGRect)getVideoContentFrame;
- (void)setVolume:(CGFloat)volume chi:(AVPlayer*)player;
@end
