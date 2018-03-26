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
#import "TMVideoPlayer.h"
#import "TMPlayerConfiguration.h"

@interface TMPlayViewController ()
@property(nonatomic, strong)TMVideoPlayer *player;
@end

@implementation TMPlayViewController
NSString *http = @"http://120.25.226.186:32812/resources/videos/minion_02.mp4";
NSString *ftp = @"ftp://ygdy8:ygdy8@yg90.dydytt.net:3037/[阳光电影www.ygdy8.com]我是僵尸第四季第01集[中英双字].rmvb";
- (TMVideoPlayer *)player{
    if (!_player) {
        TMPlayerConfiguration *config = [[TMPlayerConfiguration alloc] init];
        
        config.sourceUrl = [NSURL URLWithString:http];
        config.videoGravity = TMVideoGravityResizeAspect;
        config.shouldAutorotate = YES;
        _player = [[TMVideoPlayer alloc] initWithFrame:CGRectMake(0, 60, 400, 200) configuration:config];
    }
    return _player;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([[UIDevice currentDevice].systemVersion floatValue] > 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    TMPlayerConfiguration *config = [[TMPlayerConfiguration alloc] init];
    config.shouldAutoPlay = YES;
    config.supportedDoubleTap = YES;
    config.shouldAutorotate = YES;
    config.repeatPlay = YES;
    config.statusBarHideState = TMStatusBarHideStateFollowControls;
    config.sourceUrl = [NSURL URLWithString:http];
    config.videoGravity = TMVideoGravityResizeAspect;
    CGFloat width = self.view.frame.size.width;
    _player = [[TMVideoPlayer alloc] initWithFrame:CGRectMake(0, 100, width, 300) configuration:config];
    [self.view addSubview:_player];
//    [self watchRemoteVideo];
}

- (void)playCustomPlayer{
    [self.view addSubview:self.player];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(40, 270, 100, 60)];
    [btn setTitle:@"bofang" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor greenColor]];
    [btn addTarget:self action:@selector(playme) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)playme{
    [_player playVideo];
}

- (void)watchRemoteVideo{
    UIView *playerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*0.6)];
    [playerView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:playerView];
    
    
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:http]];
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
