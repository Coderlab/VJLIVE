//
//  VideoCell.m
//  VjLive
//
//  Created by Alessandro Belli on 04/05/13.
//  Copyright (c) 2013 Alessandro Belli. All rights reserved.
//

#import "VideoCell.h"

@implementation VideoCell
@synthesize titoloVideo = _titoloVideo;
@synthesize durataVideo = _durataVideo;
@synthesize urlVideo = _urlVideo;
@synthesize snapVideo = _snapVideo;
@synthesize artistaVideo = _artistaVideo;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
