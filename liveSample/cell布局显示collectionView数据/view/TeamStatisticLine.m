//
//  TeamStatisticLine.m
//  liveSample
//
//  Created by Tom on 2018/3/14.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import "TeamStatisticLine.h"
@interface TeamStatisticLine()
@property(nonatomic, strong)UIView *homeLine;
@property(nonatomic, strong)UIView *visitorLine;

@end
@implementation TeamStatisticLine
- (UIView *)homeLine{
    if (!_homeLine) {
        _homeLine = [[UIView alloc] init];
    }
    return _homeLine;
}
- (UIView *)visitorLine{
    if (!_visitorLine) {
        _visitorLine = [[UIView alloc] init];
    }
    return _visitorLine;
}
- (void)loadVisitorLine{
    CGRect frame = self.frame;
    self.visitorLine.frame = CGRectMake(frame.size.width*0.5, 0, frame.size.width*0.5, frame.size.height);

    [self addSubview:_visitorLine];
}
- (void)loadHomeLine{
    CGRect frame = self.frame;
    self.homeLine.frame = CGRectMake(0, 0, frame.size.width*0.5, frame.size.height);
    [self addSubview:_homeLine];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadHomeLine];
        [self loadVisitorLine];
    }
    return self;
}
+ (instancetype)loadTeamStatisticLineWithFrame:(CGRect)frame{
    TeamStatisticLine *line = [[TeamStatisticLine alloc] initWithFrame:frame];
    return line;
}
- (void)setHomeItemScore:(CGFloat)homeItemScore VisitorItemScore:(CGFloat)visItemScore{
    _homeItemScore = homeItemScore;
    _visitorItemScore = visItemScore;
    if (_homeItemScore>=_visitorItemScore) {
        [_homeLine setBackgroundColor:[UIColor redColor]];
        [_visitorLine setBackgroundColor:[UIColor grayColor]];
    }else{
        [_homeLine setBackgroundColor:[UIColor grayColor]];
        [_visitorLine setBackgroundColor:[UIColor redColor]];
    }
    CGFloat total = _homeItemScore + _visitorItemScore;
    CGFloat eachTotalW = self.bounds.size.width * 0.5;
    CGFloat homeScale = _homeItemScore==0?0:_homeItemScore/total;
    CGFloat visScale = _visitorItemScore==0?0:_visitorItemScore/total;
    CGFloat homeW = eachTotalW*homeScale;
    CGFloat visW = eachTotalW*visScale;
    self.homeLine.frame = CGRectMake(eachTotalW-homeW-1, 0, homeW, self.bounds.size.height);
    self.visitorLine.frame = CGRectMake(eachTotalW+1, 0, visW, self.bounds.size.height);
    [self cutCorner:_homeLine Corner:UIRectCornerBottomRight];
    [self cutCorner:_visitorLine Corner:UIRectCornerTopLeft];
}
- (void)cutCorner:(UIView*)view Corner:(UIRectCorner)corner{
    CGRect bounds = view.bounds;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:corner cornerRadii:CGSizeMake(10, 10)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = bounds;
    maskLayer.path = maskPath.CGPath;
    [view.layer addSublayer:maskLayer];
    view.layer.mask = maskLayer;
}
@end
