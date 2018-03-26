//
//  TMPlayerbackControl.h
//  liveSample
//
//  Created by Tom on 2018/3/24.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMVideoSlider.h"
#import "TMPlayerConfiguration.h"

/** 播放器控制面板代理*/
@protocol TMPlaybackControlDelegate <NSObject>
@required
/**播放按钮点击事件
 @param selected 按钮选中状态
 */
- (void)playButtonAction:(BOOL)selected;
/**全屏切换按钮点击事件*/
- (void)fullScreenButtonAction;
- (void)retryButtonAction;

/**滑杆开始拖动*/
- (void)videoSliderTouchBegan:(TMVideoSlider *)slider;
/**滑杆拖动中*/
- (void)videoSliderValueChanged:(TMVideoSlider *)slider;
/**滑杆结束拖动*/
- (void)videoSliderTouchEnded:(TMVideoSlider *)slider;

@optional
/**控制面板单机事件*/
- (void)tapGesture;
/**控制面板双击事件*/
- (void)doubleTapGesture;
@end
@interface TMPlayerbackControl : UIView
/**底部控制栏*/
@property(nonatomic, strong)UIView *bottomControlsBar;
/**播放按钮*/
@property(nonatomic, strong)UIButton *playButton;
/**全屏切换按钮*/
@property(nonatomic, strong)UIButton *fullScreenButton;
/**进度滑杆*/
@property(nonatomic, strong)TMVideoSlider *videoSlider;
/**播放时间*/
@property(nonatomic, strong)UILabel *playTimeLabel;
/**视频总时间*/
@property(nonatomic, strong)UILabel *totalTimeLabel;
/**进度条*/
@property(nonatomic, strong)UIProgressView *progress;
/**播放器控制面板代理*/
@property(nonatomic, weak)id <TMPlaybackControlDelegate>delegate;
/**隐藏控制面板延时时间 缺省5s*/
@property(nonatomic, assign)NSTimeInterval hideInterval;
/**是否处于全屏状态*/
@property(nonatomic, assign)BOOL isFullScreen;
/**全屏状态下状态栏显示方式*/
@property(nonatomic, assign)TMStatusBarHideState statusBarHideState;
/**加载指示器*/
@property(nonatomic, strong)UIActivityIndicatorView *activityIndicatorView;
/**加载失败重试按钮*/
@property(nonatomic, strong)UIButton *retryButton;

/**
 设置视频时间显示以及滑杆状态
 @param playTime 当前播放时间
 @param totalTime 视频总时间
 @param sliderValue 滑杆滑动值
 */
- (void)setPlaybackControlsWithPlayTime:(NSInteger)playTime totalTime:(NSInteger)totalTime sliderValue:(CGFloat)sliderValue;

/**progress显示缓冲进度*/
- (void)setPlayProgress:(CGFloat)progress;
/**显示或隐藏控制面板*/
- (void)playerShowOrHidePlaybackControl;
/**显示或隐藏状态栏*/
- (void)showOrHideStatusBar;
/**取消延时隐藏playbackControls*/
- (void)playerCancelAutoHidePlaybackControls;
/**延时自动隐藏控制面板*/
- (void)playerAutoHidePlaybackControls;
/**显示或隐藏加载指示器*/
- (void)activityIndicatorViewShow:(BOOL)show;
/**控制播放按钮选择状态*/
- (void)setPlayButtonSelect:(BOOL)select;
/**显示或隐藏重新加载按钮*/
- (void)retryButtonShow:(BOOL)show;
@end
