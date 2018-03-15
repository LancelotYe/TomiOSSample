//
//  PointIconView.m
//  liveSample
//
//  Created by Tom on 2018/3/9.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import "PointIconView.h"
#import "StatisticModel.h"
@interface PointIconView()
@property(nonatomic, strong)UILabel *desLbl;
@property(nonatomic, strong)UIImageView *homeTeamImageView;
@property(nonatomic, strong)UIImageView *visitorTeamImageView;
@end
@implementation PointIconView

- (UILabel *)desLbl{
    if(!_desLbl){
        _desLbl = [[UILabel alloc] init];
        _desLbl.font = [UIFont systemFontOfSize:10];
        _desLbl.textAlignment = NSTextAlignmentCenter;
#warning skin
        [_desLbl setTextColor:[UIColor whiteColor]];
        _desLbl.text = @"球队";
    }
    return _desLbl;
}
- (UIImageView *)homeTeamImageView{
    if(!_homeTeamImageView){
        _homeTeamImageView = [[UIImageView alloc] init];
        _homeTeamImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _homeTeamImageView;
}
- (UIImageView *)visitorTeamImageView{
    
    if(!_visitorTeamImageView){
        _visitorTeamImageView = [[UIImageView alloc] init];
        _visitorTeamImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _visitorTeamImageView;
}
- (void)setHomeIconUrl:(NSString *)homeIconUrl{
    _homeIconUrl = homeIconUrl;
    _homeTeamImageView.image = [UIImage imageNamed:_homeIconUrl];
}
-(void)setVisitorIconUrl:(NSString *)visitorIconUrl{
    _visitorIconUrl = visitorIconUrl;
    _visitorTeamImageView.image = [UIImage imageNamed:_visitorIconUrl];
}
+ (instancetype)loadPointIconView{
    PointIconView *iconView = [[PointIconView alloc] initWithFrame:CGRectMake(0, 0, pointIconW, pointItemH+pointCellH*2)];
    
    return iconView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
#warning skin
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.desLbl];
        [self addSubview:self.homeTeamImageView];
        [self addSubview:self.visitorTeamImageView];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w = pointIconW;
    CGFloat lblH = pointItemH;
    CGFloat imgH = pointCellH;
    _desLbl.frame = CGRectMake(0, 0, w, lblH);
    CGFloat deltaY = pointItemH;
    CGFloat centerX = w*0.5;
    CGFloat imgW = pointIconImgW;
    CGFloat imgX = centerX - imgW*0.5;
    CGFloat imgY = (imgH - imgW) * 0.5;
    
    _homeTeamImageView.frame = CGRectMake(imgX,imgY+deltaY,imgW,imgW);
    _homeTeamImageView.layer.cornerRadius = imgW*0.5;
    _homeTeamImageView.clipsToBounds = YES;
    _homeTeamImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    deltaY = pointItemH + pointCellH;
    _visitorTeamImageView.frame = CGRectMake(imgX, deltaY+imgY, imgW, imgW);
    _visitorTeamImageView.layer.cornerRadius = imgW * 0.5;
    _visitorTeamImageView.clipsToBounds = YES;
    _visitorTeamImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
}
@end
