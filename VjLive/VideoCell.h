//
//  VideoCell.h
//  VjLive
//
//  Created by Alessandro Belli on 04/05/13.
//  Copyright (c) 2013 Alessandro Belli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoCell : UITableViewCell{
    
}


@property (nonatomic, weak) IBOutlet UILabel *titoloVideo;
@property (nonatomic, weak) IBOutlet UILabel *durataVideo;
@property (nonatomic, weak) IBOutlet UILabel *urlVideo;
@property (weak, nonatomic) IBOutlet UILabel *artistaVideo;
@property (nonatomic, weak) IBOutlet UIImageView *snapVideo;

@end
