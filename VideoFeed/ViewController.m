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
    NSArray *urls;
    bool playedYN;
    AVPlayerViewController *playerViewController;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // init URLs
    urls = [NSArray arrayWithObjects:
            @"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4",
            @"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4",
            @"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4",
            @"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4",
            @"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4",
            @"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4",
            @"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4",
            @"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4",
            @"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4",
            @"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4",
            nil];
    
    playerViewController = [[AVPlayerViewController alloc] init];
    
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 20;
}


#pragma datasource
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
    
    if(!playedYN){
        cell.videoItem = [AVPlayerItem playerItemWithURL:[[NSURL alloc] initWithString:urls[indexPath.row]]];
        cell.videoPlayer = [AVPlayer playerWithPlayerItem:cell.videoItem];
        cell.avLayer = [AVPlayerLayer playerLayerWithPlayer:cell.videoPlayer];
        
        [cell.avLayer setBackgroundColor:[UIColor whiteColor].CGColor];
        [cell.contentView.layer addSublayer:cell.avLayer];
        [cell.videoPlayer play];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        playedYN=YES;
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 400 ;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
