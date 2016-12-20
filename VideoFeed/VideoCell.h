//
//  VideoCell.h
//  VideoFeed
//
//  Created by Mayur on 12/19/16.
//  Copyright © 2016 Mayur. All rights reserved.
//

@import AVFoundation;
@import AVKit;

#import <UIKit/UIKit.h>

@interface VideoCell : UITableViewCell


@property (strong, nonatomic) AVPlayer* videoPlayer;

@property (strong, nonatomic) AVPlayerLayer* avLayer;

@end
