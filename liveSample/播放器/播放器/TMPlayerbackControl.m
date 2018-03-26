//
//  TMPlayerbackControl.m
//  liveSample
//
//  Created by Tom on 2018/3/24.
//  Copyright © 2018年 Tom. All rights reserved.
//


#import "TMPlayerbackControl.h"
#import <Masonry.h>

static const CGFloat PlaybackControlsAutoHideTimeInterval = 3.0f;
@interface TMPlayerbackControl()
/** 控制面板是否显示 */
@property (nonatomic, assign) BOOL isShowing;
/** 加载指示器是否显示 */
@property (nonatomic, assign) BOOL isActivityShowing;
/** 重新加载是否显示 */
@property (nonatomic, assign) BOOL isRetryShowing;
@end
@implementation TMPlayerbackControl

/** 初始化*/
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
/**重置控制面板*/
- (void)resetPlaybackControls{
    self.bottomControlsBar.alpha = 0;
    self.isShowing = NO;
    [self activityIndicatorViewShow:YES];
}
/**
 设置视频时间显示以及滑杆状态
 @param playTime 当前播放时间
 @param totalTime 视频总时间
 @param sliderValue 滑杆滑动值
 */
- (void)setPlaybackControlsWithPlayTime:(NSInteger)playTime totalTime:(NSInteger)totalTime sliderValue:(CGFloat)sliderValue{
    //当前时常进度progress
    NSInteger proMin = playTime / 60; //当前秒
    NSInteger proSec = playTime % 60; //当前分钟
    //duration
    NSInteger durMin = totalTime / 60; //总秒
    NSInteger durSec = totalTime % 60; //总分钟
    
    //更新当前播放时间
    self.videoSlider.value = sliderValue;
    self.playTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", proMin, proSec];
    self.totalTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", durMin, durSec];
}

/**显示或隐藏加载指示器*/
- (void)activityIndicatorViewShow:(BOOL)show{
    self.isActivityShowing = show;
    if (show) {
        self.playButton.hidden = YES;
        [self.activityIndicatorView startAnimating];
    }else{
        if (self.isShowing) {
            self.playButton.hidden = NO;
        }
        [self.activityIndicatorView stopAnimating];
    }
}

/**显示或隐藏重新加载按钮*/
- (void)retryButtonShow:(BOOL)show{
    self.isRetryShowing = show;
    if (show) {
        self.playButton.selected = NO;
        self.playButton.hidden = YES;
        self.retryButton.hidden = NO;
    }else{
        self.retryButton.hidden = YES;
    }
}

/** progress显示缓冲进度 */
- (void)setPlayProgress:(CGFloat)progress{
    [self.progress setProgress:progress animated:YES];
}

/** 控制播放按钮选择状态 */
- (void)setPlayButtonSelect:(BOOL)select{
    self.playButton.selected = select;
}

/** 显示或隐藏控制面板 */
- (void)playerShowOrHidePlaybackControl{
    if (self.isShowing) {
        [self playerHidePlaybackControls];
    }else{
        [self playerShowPlaybackControl];
    }
}

/**显示控制面板*/
- (void)playerShowPlaybackControl{
    [self playerCancelAutoHidePlaybackControls];
    [UIView animateWithDuration:PlaybackControlsAutoHideTimeInterval animations:^{
        [self showPlaybackControls];
    } completion:^(BOOL finished) {
        self.isShowing = YES;
        [self playerAutoHidePlaybackControls];
    }];
}

/**隐藏控制面板*/
- (void)playerHidePlaybackControls{
    [self playerCancelAutoHidePlaybackControls];
    [UIView animateWithDuration:PlaybackControlsAutoHideTimeInterval animations:^{
        [self hidePlaybackControl];
    } completion:^(BOOL finished) {
        self.isShowing = NO;
    }];
}

/**显示控制面板*/
- (void)showPlaybackControls{
    self.isShowing = YES;
    self.bottomControlsBar.alpha = 1;
    if (!self.isActivityShowing && !self.isRetryShowing) {
        self.playButton.hidden = NO;
    }
    [self showOrHideStatusBar];
}
/**隐藏控制面板*/
- (void)hidePlaybackControl{
    self.isShowing = NO;
    self.bottomControlsBar.alpha = 0;
    self.playButton.hidden = YES;
    if (self.isFullScreen) {
        [self showOrHideStatusBar];
    }
}

/**延时自动隐藏控制面板*/
- (void)playerAutoHidePlaybackControls{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(playerHidePlaybackControls) object:nil];
    [self performSelector:@selector(playerHidePlaybackControls) withObject:nil afterDelay:_hideInterval];
}

/**显示或隐藏状态栏*/
- (void)showOrHideStatusBar{
    switch (_statusBarHideState) {
        case TMStatusBarHideStateFollowControls:
            [[UIApplication sharedApplication] setStatusBarHidden:!self.isShowing];
            break;
        case TMStatusBarHideStateNever:
            [[UIApplication sharedApplication] setStatusBarHidden:NO];
            break;
        case TMStatusBarHideStateAlways:
            [[UIApplication sharedApplication] setStatusBarStyle:YES];
            break;
        default:
            break;
    }
}



/**是否处于全屏状态*/
- (void)setIsFullScreen:(BOOL)isFullScreen{
    _isFullScreen = isFullScreen;
    self.fullScreenButton.selected = _isFullScreen;
}


/**取消延时隐藏playbackControls*/
- (void)playerCancelAutoHidePlaybackControls{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}


/**创建UI*/
- (void)setupUI{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.playButton];
    [self addSubview:self.bottomControlsBar];
    [self addSubview:self.activityIndicatorView];
    [self addSubview:self.retryButton];
    
    [_bottomControlsBar addSubview:self.fullScreenButton];
    [_bottomControlsBar addSubview:self.playTimeLabel];
    [_bottomControlsBar addSubview:self.totalTimeLabel];
    [_bottomControlsBar addSubview:self.progress];
    [_bottomControlsBar addSubview:self.videoSlider];
    
    [self makeConstraints];
    [self resetPlaybackControls];
    [self addGesture];
    
}

/**添加手势*/
- (void)addGesture{
    //单击手势
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:singleTapGesture];
    //双击手势
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubleTapGesture];
    
    //当系统检测不到双击手势时执行再识别单机手势，解决单双击收拾冲突
    [singleTapGesture requireGestureRecognizerToFail:doubleTapGesture];
}


/** 添加约束 */
- (void)makeConstraints{
    [_playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    [_bottomControlsBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@30);
    }];
    [_activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    [_retryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    [_fullScreenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(_bottomControlsBar);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [_playTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bottomControlsBar).offset(5);
        make.width.equalTo(@4);
        make.centerY.equalTo(_bottomControlsBar.mas_centerY);
    }];
    [_totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_fullScreenButton.mas_left).offset(-5);
        make.width.equalTo(@45);
        make.centerY.equalTo(_bottomControlsBar.mas_centerY);
    }];
    [_progress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_playTimeLabel.mas_right).offset(5);
        make.right.equalTo(_totalTimeLabel.mas_left).offset(-5);
        make.height.equalTo(@2);
        make.centerY.equalTo(_bottomControlsBar.mas_centerY);
    }];
    [_videoSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_progress);
    }];
}

/**加载指示器*/
- (UIActivityIndicatorView *)activityIndicatorView{
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    }
    return _activityIndicatorView;
}

/**底部控制栏*/
- (UIView *)bottomControlsBar{
    if (!_bottomControlsBar) {
        _bottomControlsBar = [[UIView alloc] init];
        _bottomControlsBar.userInteractionEnabled = YES;
    }
    return _bottomControlsBar;
}

/**播放按钮*/
- (UIButton *)playButton{
    if (!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setImage:[UIImage imageNamed:@"btn_play"] forState:UIControlStateNormal];
        [_playButton setImage:[UIImage imageNamed:@"btn_pause"] forState:UIControlStateNormal];
        [_playButton addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}

/**全屏切换按钮*/
- (UIButton *)fullScreenButton{
    if (!_fullScreenButton) {
        _fullScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fullScreenButton setImage:[UIImage imageNamed:@"ic_turn_screen_white_18x18_"] forState:UIControlStateNormal];
        [_fullScreenButton setImage:[UIImage imageNamed:@"ic_zoomout_screen_white_18x18_"] forState:UIControlStateNormal];
        [_fullScreenButton addTarget:self action:@selector(fullScreenAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fullScreenButton;
}
/**当前播放时间*/
- (UILabel *)playTimeLabel{
    if (!_playTimeLabel) {
        _playTimeLabel = [[UILabel alloc] init];
        _playTimeLabel.font = [UIFont systemFontOfSize:14];
        _playTimeLabel.text = @"00:00";
        _playTimeLabel.adjustsFontSizeToFitWidth = YES;
        _playTimeLabel.textAlignment = NSTextAlignmentCenter;
        _playTimeLabel.textColor = [UIColor whiteColor];
    }
    return _playTimeLabel;
}

/**视频总时间*/
- (UILabel *)totalTimeLabel{
    if (!_totalTimeLabel) {
        _totalTimeLabel = [[UILabel alloc] init];
        _totalTimeLabel.font = [UIFont systemFontOfSize:14];
        _totalTimeLabel.text = @"00:00";
        _totalTimeLabel.adjustsFontSizeToFitWidth = YES;
        _totalTimeLabel.textAlignment = NSTextAlignmentCenter;
        _totalTimeLabel.textColor = [UIColor whiteColor];
    }
    return _totalTimeLabel;
}


/**加载失败重试按钮*/
- (UIButton *)retryButton{
    if (!_retryButton) {
        _retryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_retryButton setImage:[UIImage imageNamed:@"Action_reload_player_100x100_"] forState:UIControlStateNormal];
        [_retryButton addTarget:self action:@selector(retryAction) forControlEvents:UIControlEventTouchUpInside];
        _retryButton.hidden = YES;
    }
    return _retryButton;
}


/**播放进度条*/
- (UIProgressView *)progress{
    if (!_progress) {
        _progress = [[UIProgressView alloc] init];
        _progress.progressTintColor = [UIColor whiteColor];
        _progress.trackTintColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4];
    }
    return _progress;
}


/**滑杆*/
- (TMVideoSlider *)videoSlider{
    if (!_videoSlider) {
        _videoSlider = [[TMVideoSlider alloc] init];
        _videoSlider.maximumTrackTintColor = [UIColor clearColor];
        //开始拖动事件
        [_videoSlider addTarget:self action:@selector(progressSliderTouchBegan:) forControlEvents:UIControlEventTouchDown];
        //拖动中事件
        [_videoSlider addTarget:self action:@selector(progressSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        //结束拖动事件
        [_videoSlider addTarget:self action:@selector(progressSliderTouchEnded:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchCancel|UIControlEventTouchUpOutside];
    }
    return _videoSlider;
}




#pragma mark - 滑杆
/**开始拖动事件*/
- (void)progressSliderTouchBegan:(TMVideoSlider *)slider{
    if (_delegate && [_delegate respondsToSelector:@selector(videoSliderTouchBegan:)]) {
        [_delegate videoSliderTouchBegan:slider];
    }
}
/**拖动事件*/
- (void)progressSliderValueChanged:(TMVideoSlider *)slider{
    if (_delegate && [_delegate respondsToSelector:@selector(videoSliderValueChanged:)]) {
        [_delegate videoSliderValueChanged:slider];
    }
}
/**结束拖动事件*/
- (void)progressSliderTouchEnded:(TMVideoSlider *)slider{
    if (_delegate && [_delegate respondsToSelector:@selector(videoSliderTouchEnded:)]) {
        [_delegate videoSliderTouchEnded:slider];
    }
}
/**播放按钮点击事件*/
- (void)playAction:(UIButton *)btn{
    if (_delegate && [_delegate respondsToSelector:@selector(playButtonAction:)]) {
        [_delegate playButtonAction:btn.selected];
    }
}
/**全屏切换按钮点击事件*/
- (void)fullScreenAction{
    if (_delegate && [_delegate respondsToSelector:@selector(fullScreenButtonAction)]) {
        [_delegate fullScreenButtonAction];
    }
}
/**重试按钮点击事件*/
- (void)retryAction{
    if (_delegate && [_delegate respondsToSelector:@selector(retryButtonAction)]) {
        [_delegate retryButtonAction];
    }
}
/**控制面板单击事件*/
- (void)tap:(UIGestureRecognizer *)gesture{
    if (_delegate && [_delegate respondsToSelector:@selector(tapGesture)]) {
        [_delegate tapGesture];
    }
}
/**控制面板双击事件*/
- (void)doubleTap:(UIGestureRecognizer *)gesture{
    if (_delegate && [_delegate respondsToSelector:@selector(doubleTapGesture)]) {
        [_delegate doubleTapGesture];
    }
}
@end
