//
//  WaveformImageView.h
//  VjLive
//
//  Created by Alessandro Belli on 25/08/13.
//  Copyright (c) 2013 Alessandro Belli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@class BackgroundProcessor;

@interface WaveformImageView : UIImageView<AVAssetResourceLoaderDelegate,AVAudioPlayerDelegate>{
    
}
-(id)initWithUrl:(NSURL*)url;
- (NSData *) renderPNGAudioPictogramLogForAssett:(AVURLAsset *)songAsset;
@end
