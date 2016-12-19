//
//  ViewController.h
//  VideoFeed
//
//  Created by Mayur on 12/19/16.
//  Copyright © 2016 Mayur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoCell.h"

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

