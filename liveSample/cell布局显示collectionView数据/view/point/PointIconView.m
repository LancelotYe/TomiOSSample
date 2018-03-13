//
//  PointIconView.m
//  liveSample
//
//  Created by Tom on 2018/3/9.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import "PointIconView.h"
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
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:self.desLbl];
        [self addSubview:self.homeTeamImageView];
        [self addSubview:self.visitorTeamImageView];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat selfW = self.frame.size.width;
    CGFloat selfH = self.frame.size.height;
    CGFloat h = selfH/3;
    CGFloat imageW = selfW-17*2;
    imageW = imageW>h?h:imageW;
    CGFloat marginX = (selfW - imageW)*0.5;
    CGFloat marginY = (h-imageW)*0.5;
    
    
    _desLbl.frame = CGRectMake(20, 0, selfW, selfH/3);
    _homeTeamImageView.frame = CGRectMake(marginX,selfH/3+ marginY, imageW, imageW);
    _homeTeamImageView.layer.cornerRadius = imageW/2;
    _homeTeamImageView.clipsToBounds = YES;
    _homeTeamImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _visitorTeamImageView.frame = CGRectMake(marginX, selfH*2/3+marginY, imageW, imageW);
    _visitorTeamImageView.layer.cornerRadius = imageW/2;
    _visitorTeamImageView.clipsToBounds = YES;
    _visitorTeamImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
}
@end
