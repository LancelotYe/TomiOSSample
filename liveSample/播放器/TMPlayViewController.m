//
//  TMPlayViewController.m
//  liveSample
//
//  Created by Tom on 2018/3/20.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import "TMPlayViewController.h"
#import <AVKit/AVKit.h>
//#import <AVFoundation/AVFoundation.h>
#import "TMIconImageView.h"

@interface TMPlayViewController ()

@end

@implementation TMPlayViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    

}
- (void)watchRemoteVideo{
    UIView *playerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*0.6)];
    [playerView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:playerView];
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_02.mp4"]];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
    AVPlayerViewController *vc = [[AVPlayerViewController alloc] init];
    vc.player = player;
    vc.view.frame = playerView.bounds;
    [self addChildViewController:vc];
    [playerView addSubview:vc.view];
    [vc.player play];
}
- (void)watchLocalVideo{
    UIView *playerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*0.6)];
    [playerView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:playerView];
    NSString *url = [[NSBundle mainBundle]pathForResource:@"minion_02.mp4" ofType:nil];
    NSURL *sourceUrl = [NSURL fileURLWithPath:url];
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:sourceUrl options:nil];
    AVPlayerItem *playItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    AVPlayerViewController *vc = [[AVPlayerViewController alloc] init];
    vc.player = [AVPlayer playerWithPlayerItem:playItem];
    vc.view.frame = playerView.bounds;
    [self addChildViewController:vc];
    [playerView addSubview:vc.view];
    [vc.player play];
}
- (void)watchLocalVideoPlus{
    UIView *playerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*0.6)];
    [playerView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:playerView];
    NSString *url = [[NSBundle mainBundle]pathForResource:@"minion_02.mp4" ofType:nil];
    NSURL *sourceUrl = [NSURL fileURLWithPath:url];
    AVPlayerViewController *vc = [[AVPlayerViewController alloc] init];
    vc.player = [[AVPlayer alloc] initWithURL:sourceUrl];
    vc.view.frame = playerView.bounds;
    [self addChildViewController:vc];
    [playerView addSubview:vc.view];
    [vc.player play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
