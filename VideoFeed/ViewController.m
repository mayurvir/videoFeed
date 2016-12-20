//
//  ViewController.m
//  VideoFeed
//
//  Created by Mayur on 12/19/16.
//  Copyright © 2016 Mayur. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    // constants
    NSString *contstantUrl;
    int n;  // number of videos in list
    
    // variables
    NSMutableArray *urls;
    int visibleIndex;
    float videoHeight;
    
    NSMutableDictionary *cache;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // init constants
    contstantUrl = @"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4";
    n = 10;
    
    // init variables
    cache = [[NSMutableDictionary alloc] init];
    visibleIndex = 0;
    
    // init URLs
    urls = [[NSMutableArray alloc] init];
    for(int i=0;i<n;i++){
        [urls addObject:contstantUrl];  //repeating the same url n times
    }
    
    // calculate video height
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:[[NSURL alloc] initWithString:contstantUrl] options:nil];
    NSArray *tracks = [asset tracksWithMediaType:AVMediaTypeVideo];
    AVAssetTrack *track = [tracks objectAtIndex:0];
    CGSize mediaSize = track.naturalSize;
    videoHeight = (self.view.frame.size.width * mediaSize.height)/mediaSize.width;
    
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 20;
    [_tableView reloadData];
    
}


#pragma mark datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [urls count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"VideoView";
    
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[VideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    // get url
    NSURL *url = [[NSURL alloc] initWithString:urls[indexPath.row]];
    
    // get cahched AVPLayerLayer
    AVPlayerLayer *avLayer = [cache objectForKey:[NSString stringWithFormat:@"%d", (int)indexPath.row]];
    if(avLayer==nil){
        AVPlayerItem *videoItem = [AVPlayerItem playerItemWithURL:url];
        AVPlayer *videoPlayer = [AVPlayer playerWithPlayerItem:videoItem];
        avLayer = [AVPlayerLayer playerLayerWithPlayer:videoPlayer];
        [avLayer setBackgroundColor:[UIColor whiteColor].CGColor];
        
        [cache setObject:avLayer forKey:[NSString stringWithFormat:@"%d",(int)indexPath.row]];
        
    }
    
    // refresh layer
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);

    dispatch_async(queue, ^{
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            // Causing some flicker due to old layer being removed and new layer being added
            // TODO : perform video load in this
            
            
        });
    });
    
    cell.contentView.layer.sublayers=nil;
    [cell.contentView.layer addSublayer:avLayer];
    
    
    cell.avLayer = avLayer;
    cell.videoPlayer = avLayer.player;
    [cell.videoPlayer pause];
    
    if(visibleIndex == indexPath.row){
        NSLog(@"Playing video at index : %ld",cell.tag);
        [cell.videoPlayer play];
    }
    
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.tag = indexPath.row;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  videoHeight;
}



-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self resetVisibleIndex];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)aScrollView
{
    visibleIndex = -1;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(!decelerate){
        [self resetVisibleIndex];
    }
}

#pragma mark functions

- (void)resetVisibleIndex{
    BOOL found = NO;
    
    for(UITableViewCell *cell in [_tableView visibleCells])
    {
        VideoCell *vCell = (VideoCell*)cell;
        
        CGRect ccellRect = [self.view.window convertRect:vCell.bounds fromView:vCell];
        
        CGPoint p = ccellRect.origin;
        [vCell.videoPlayer pause];
        
        if(!found && p.y > (_tableView.frame.size.height-videoHeight)/2)
        {
            NSLog(@"Visible video at index : %ld",vCell.tag);
            visibleIndex = (int)cell.tag;
            found = YES;
        }
    }
    
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
