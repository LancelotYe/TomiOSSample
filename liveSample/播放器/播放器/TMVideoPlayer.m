//
//  TMVideoPlayer.m
//  liveSample
//
//  Created by Tom on 2018/3/23.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import "TMVideoPlayer.h"
#import "TMPlayerConfiguration.h"
#import "TMPlayerbackControl.h"
#import <AVFoundation/AVFoundation.h>

/** 播放器的播放状态 */
typedef NS_ENUM(NSInteger, TMVideoPlayerState) {
    TMVideoPlayerStateFailed,     // 播放失败
    TMVideoPlayerStateBuffering,  // 缓冲中
    TMVideoPlayerStatePlaying,    // 播放中
    TMVideoPlayerStatePause,      // 暂停播放
};
@interface TMVideoPlayer()<TMPlaybackControlDelegate>
/** 播放器 */
@property (nonatomic, strong) AVPlayerItem *playerItem;
/** 播放器item */
@property (nonatomic, strong) AVPlayer *player;
/** 播放器layer */
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
/** 是否播放完毕 */
@property (nonatomic, assign) BOOL isFinish;
/** 是否处于全屏状态 */
@property (nonatomic, assign) BOOL isFullScreen;
/** 播放器配置信息 */
@property (nonatomic, strong) TMPlayerConfiguration *playerConfiguration;
/** 视频播放控制面板 */
@property (nonatomic, strong) TMPlayerbackControl *playbackControls;
/** 非全屏状态下播放器 superview */
@property (nonatomic, strong) UIView *originalSuperview;
/** 非全屏状态下播放器 frame */
@property (nonatomic, assign) CGRect originalRect;
/** 时间监听器 */
@property (nonatomic, strong) id timeObserve;
/** 播放器的播放状态 */
@property (nonatomic, assign) TMVideoPlayerState playerState;
/** 是否结束播放 */
@property (nonatomic, assign) BOOL playDidEnd;

@end
@implementation TMVideoPlayer

/**
 初始化播放器
 @param configuration 播放器配置信息
 */
- (instancetype)initWithFrame:(CGRect)frame configuration:(TMPlayerConfiguration *)configuration{
    self = [super initWithFrame:frame];
    if (self) {
        _playerConfiguration = configuration;
        [self setupPlayer];
        [self setupPlayControls];
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground:) name:UIApplicationWillResignActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterPlayground:) name:UIApplicationDidBecomeActiveNotification object:nil];
    }
    return self;
}

/** 屏幕翻转监听事件 */
- (void)orientationChanged:(NSNotification*)notif{
    if (_playerConfiguration.shouldAutorotate) {
        [self orientationAspect];
    }
}

/** 根据屏幕旋转方向改变当前视频屏幕状态 */
- (void)orientationAspect{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if (orientation == UIDeviceOrientationLandscapeLeft) {
        if (!_isFullScreen) {
            [self videoZoomInWithDirection:UIInterfaceOrientationLandscapeRight];
        }
    }
    else if (orientation == UIDeviceOrientationLandscapeRight){
        if (!_isFullScreen) {
            [self videoZoomInWithDirection:UIInterfaceOrientationLandscapeLeft];
        }
    }else if (orientation == UIDeviceOrientationPortrait){
        if (!_isFullScreen) {
            [self videoZoomOut];
        }
    }
}

/**
 视频放大全屏幕
 @param orientation 旋转方向
 */
- (void)videoZoomInWithDirection:(UIInterfaceOrientation)orientation{
    _originalSuperview = self.superview;
    _originalRect = self.frame;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
    [[UIApplication sharedApplication] setStatusBarOrientation:orientation animated:NO];
    [UIView animateWithDuration:duration animations:^{
        if (orientation == UIInterfaceOrientationLandscapeLeft) {
            self.transform = CGAffineTransformMakeRotation(-M_PI/2);
        }else if (orientation == UIInterfaceOrientationLandscapeRight){
            self.transform = CGAffineTransformMakeRotation(M_PI/2);
        }
    } completion:^(BOOL finished) {
        
    }];
    self.frame = keyWindow.bounds;
    [self setNeedsLayout];
    [self layoutIfNeeded];
    self.isFullScreen = YES;
    [self.playbackControls showOrHideStatusBar];
    
}

/** 视频退出全屏幕 */
- (void)videoZoomOut{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO];
    [UIView animateWithDuration:duration animations:^{
        self.transform = CGAffineTransformMakeRotation(0);
    } completion:^(BOOL finished) {
        
    }];
    self.frame = _originalRect;
    [_originalSuperview addSubview:self];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    self.isFullScreen = NO;
}


/** 播放器控制面板 */
- (TMPlayerbackControl *)playbackControls{
    if (!_playbackControls) {
        _playbackControls = [[TMPlayerbackControl alloc] init];
        _playbackControls.delegate = self;
        _playbackControls.hideInterval = _playerConfiguration.hideControlsInterval;
        _playbackControls.statusBarHideState = _playerConfiguration.statusBarHideState;
    }
    return _playbackControls;
}

/**
 @param playerState 播放器的播放状态
 */
- (void)setPlayerState:(TMVideoPlayerState)playerState{
    _playerState = playerState;
    switch (_playerState) {
        case TMVideoPlayerStateBuffering:
        {
            [_playbackControls activityIndicatorViewShow:YES];
        }
            break;
        case TMVideoPlayerStatePlaying:
        {
            [_playbackControls activityIndicatorViewShow:NO];
        }
            break;
        case TMVideoPlayerStateFailed:
        {
            [_playbackControls activityIndicatorViewShow:NO];
            [_playbackControls retryButtonShow:YES];
        }
            break;
        default:
            break;
    }}
/** 应用进入后台 */
- (void)appDidEnterBackground:(NSNotification*)notif{
    [self pauseVideo];
}
/** 应用进入前台 */
- (void)appDidEnterPlayground:(NSNotification*)notif{
    
}




- (void)setPlayerItem:(AVPlayerItem *)playerItem{
    if (_playerItem == playerItem) {
        return;
    }
    if (_playerItem) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        [_playerItem removeObserver:self forKeyPath:@"status"];
        [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
        [_playerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
        [_playerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
    }
    _playerItem = playerItem;
    if (playerItem) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoDidPlayToEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
        [playerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
        [playerItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        //计算缓冲进度
        NSTimeInterval timeInterval = [self availableDuration];
        CMTime duration = self.playerItem.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
    }else if([keyPath isEqualToString:@"playbackBufferEmpty"]){
        //当无缓冲视频数据时
        if (self.playerItem.playbackBufferEmpty) {
            self.playerState = TMVideoPlayerStateBuffering;
            
        }
    }else if([keyPath isEqualToString:@"playbackLikelyToKeepUp"]){
        
    }else if([keyPath isEqualToString:@"status"]){
        
    }
}
/**
 *  计算缓冲进度
 *  @return 缓冲进度
 */
- (NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanges = [[_player currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;//计算缓冲总进度
    return result;
}

- (void)setupPlayer{
    self.playerItem = [AVPlayerItem playerItemWithURL:_playerConfiguration.sourceUrl];
    self.player = [AVPlayer playerWithPlayerItem:_playerItem];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    [self setVideoGravity:_playerConfiguration.videoGravity];
    self.backgroundColor = [UIColor blackColor];
    
    //add layer
    [self.layer insertSublayer:_playerLayer atIndex:0];
    
}

- (void)setVideoGravity:(TMVideoGravity)videoGravity{
    NSString *fillMode = AVLayerVideoGravityResize;
    switch (videoGravity) {
        case TMVideoGravityResize:
            fillMode = AVLayerVideoGravityResize;
            break;
        case TMVideoGravityResizeAspect:
            fillMode = AVLayerVideoGravityResizeAspect;
            break;
        case TMVideoGravityResizeAspectFill:
            fillMode = AVLayerVideoGravityResizeAspectFill;
            break;
        default:
            break;
    }
    _playerLayer.videoGravity = fillMode;
}
- (void)videoDidPlayToEnd{
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.playerLayer.frame = self.bounds;
    self.playbackControls.frame = self.bounds;
}
- (void)playVideo{
    if (self.playDidEnd) {
        [self replayVideo];
    }else{
        [_player play];
    }
}
/** 重新播放 */
- (void)replayVideo
{
    self.playDidEnd = NO;
    [_player seekToTime:CMTimeMake(0, 1) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    [self playVideo];
}
-(void)pauseVideo{
    [_player pause];
    
}
-(void)deallocPlayer{
    [self pauseVideo];
    [self.playerLayer removeFromSuperlayer];
    [self removeFromSuperview];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}
/** 释放Self */
- (void)dealloc{
    self.playerItem = nil;
    [self.playbackControls playerCancelAutoHidePlaybackControls];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
    if (self.timeObserve) {
        [self.player removeTimeObserver:self.timeObserve];
        self.timeObserve = nil;
    }
    self.playerLayer = nil;
    self.player = nil;
}
#pragma mark - 缓冲较差时候

/**
 *  缓冲较差时候回调这里
 */
- (void)bufferingSomeSecond{
    self.playerState == TMVideoPlayerStateBuffering;
    //playbackBufferEmpty会反复进入，因此在bufferingOneSecond延时播放执行完之前再调用bufferingSomeSecond都忽略
    __block BOOL isBuffering = NO;
    if (isBuffering) {
        return;
    }
    
    //需要先暂停一小会之后再播放，否则网络状况不好的时候时间再走，声音播放不出来
    [self pauseVideo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self playVideo];
        //如果执行了play还是没有播放则说明还没有缓存好，则再次缓存一段时间
        isBuffering = NO;
        if (!self.playerItem.isPlaybackLikelyToKeepUp) {
            [self bufferingSomeSecond];
        }
    });
}
/** 添加播放器控制面板 */
- (void)setupPlayControls
{
    [self addSubview:self.playbackControls];
}
#pragma mark - TMPlayerbackControlDelegate
- (void)fullScreenButtonAction {
    if (!_isFullScreen) {
        [self videoZoomInWithDirection:UIInterfaceOrientationLandscapeRight];
    }else
    {
        [self videoZoomOut];
    }
}

- (void)playButtonAction:(BOOL)selected {
    if (selected){
        [self pauseVideo];
    }else{
        [self playVideo];
    }
}

- (void)retryButtonAction {
    [_playbackControls retryButtonShow:NO];
    [_playbackControls activityIndicatorViewShow:YES];
    [self setupPlayer];
    [self playVideo];

}

- (void)videoSliderTouchBegan:(TMVideoSlider *)slider {
    [self pauseVideo];
    [_playbackControls playerCancelAutoHidePlaybackControls];
}

- (void)videoSliderTouchEnded:(TMVideoSlider *)slider {
    if (slider.value != 1) {
        self.playDidEnd = NO;
    }
    if (!self.playerItem.isPlaybackLikelyToKeepUp) {
        [self bufferingSomeSecond];
    }else{
        //继续播放
        [self playVideo];
    }
    [_playbackControls playerAutoHidePlaybackControls];
}

- (void)videoSliderValueChanged:(TMVideoSlider *)slider {
    CGFloat totalTime = (CGFloat)_playerItem.duration.value / _playerItem.duration.timescale;
    CGFloat dragedSeconds = totalTime * slider.value;
    //转换成CMTime才能给player来控制播放进度
    CMTime dragedCMTime = CMTimeMake(dragedSeconds, 1);
    [_player seekToTime:dragedCMTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    NSInteger currentTime = (NSInteger)CMTimeGetSeconds(dragedCMTime);
    [_playbackControls setPlaybackControlsWithPlayTime:currentTime totalTime:totalTime sliderValue:slider.value];
}



@end
