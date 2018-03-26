//
//  TMVideoPlayer.h
//  liveSample
//
//  Created by Tom on 2018/3/23.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TMPlayerConfiguration;

@interface TMVideoPlayer : UIView
- (instancetype)initWithFrame:(CGRect)frame configuration:(TMPlayerConfiguration *)configuration;

- (void)playVideo;
- (void)pauseVideo;
- (void)deallocPlayer;
@end
