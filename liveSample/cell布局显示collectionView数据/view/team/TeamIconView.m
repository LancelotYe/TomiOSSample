//
//  TeamIconView.m
//  liveSample
//
//  Created by Tom on 2018/3/9.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import "TeamIconView.h"
#import "StatisticModel.h"
@interface TeamIconView()

@property(nonatomic, strong)UILabel *desLbl;
@property(nonatomic, strong)UIImageView *homeTeamImageView;
@property(nonatomic, strong)UIImageView *visitorTeamImageView;
@property(nonatomic, strong)UIView *line;
@end
@implementation TeamIconView
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
- (UILabel *)desLbl{
    if(!_desLbl){
        _desLbl = [[UILabel alloc] init];
        _desLbl.textAlignment = NSTextAlignmentCenter;
#warning skin
        _desLbl.textColor = [UIColor whiteColor];
        _desLbl.text =@"VS";
    }
    return _desLbl;
}

-(void)setHomeIconUrl:(NSString *)homeIconUrl{
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
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.desLbl];
        [self addSubview:self.homeTeamImageView];
        [self addSubview:self.visitorTeamImageView];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat selfW = self.frame.size.width;
    CGFloat selfH = self.frame.size.height;
    _desLbl.frame = CGRectMake(selfW/6, 0, selfW*2/3, selfH);
    CGFloat h = selfH;
    CGFloat imageW = teamImgW;
    CGFloat marginX = 19;
    CGFloat marginY = (h-imageW)*0.5;
    _homeTeamImageView.frame = CGRectMake(marginX, marginY, imageW, imageW);
    _homeTeamImageView.layer.cornerRadius = imageW/2;
    _homeTeamImageView.clipsToBounds = YES;
    _homeTeamImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _visitorTeamImageView.frame = CGRectMake(selfW-imageW-marginX, marginY, imageW, imageW);
    _visitorTeamImageView.layer.cornerRadius = imageW/2;
    _visitorTeamImageView.clipsToBounds = YES;
    _visitorTeamImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
}
@end
