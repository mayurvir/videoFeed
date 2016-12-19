//
//  VideoCell.m
//  VideoFeed
//
//  Created by Mayur on 12/19/16.
//  Copyright © 2016 Mayur. All rights reserved.
//

#import "VideoCell.h"

@implementation VideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.avLayer setFrame:CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y, self.contentView.frame.size.width,  self.contentView.frame.size.height)];
    
}
@end
