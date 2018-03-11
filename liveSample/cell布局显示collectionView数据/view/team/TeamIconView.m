//
//  TeamIconView.m
//  liveSample
//
//  Created by Tom on 2018/3/9.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import "TeamIconView.h"
@interface TeamIconView()
@property(nonatomic, strong)UILabel *desLbl;
@property(nonatomic, strong)UIImageView *hostTeamImageView;
@property(nonatomic, strong)UIImageView *customTeamImageView;
@end
@implementation TeamIconView
- (UIImageView *)hostTeamImageView{
    CGFloat selfW = self.frame.size.width;
    CGFloat selfH = self.frame.size.height;
    if(!_hostTeamImageView){
        _hostTeamImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, selfW/3, selfH)];
    }
    return _hostTeamImageView;
}
- (UILabel *)desLbl{
    if(!_desLbl){
        CGFloat selfW = self.frame.size.width;
        CGFloat selfH = self.frame.size.height;
        _desLbl = [[UILabel alloc] initWithFrame:CGRectMake(selfW/3, 0, selfW/3, selfH)];
        _desLbl.textAlignment = NSTextAlignmentCenter;
        _desLbl.text =@"VS";
    }
    return _desLbl;
}
- (UIImageView *)customTeamImageView{
    CGFloat selfW = self.frame.size.width;
    CGFloat selfH = self.frame.size.height;
    if(!_customTeamImageView){
        _customTeamImageView = [[UIImageView alloc] initWithFrame:CGRectMake(selfW*2/3, 0, selfW/3, selfH)];
    }
    return _customTeamImageView;
}
- (void)setHostIconUrl:(NSString *)hostIconUrl{
    _hostIconUrl = hostIconUrl;
    _hostTeamImageView.image = [UIImage imageNamed:_hostIconUrl];
}
-(void)setCustomiconUrl:(NSString *)customiconUrl{
    _customiconUrl = customiconUrl;
    _customTeamImageView.image = [UIImage imageNamed:_customiconUrl];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:self.desLbl];
        [self addSubview:self.hostTeamImageView];
        [self addSubview:self.customTeamImageView];
    }
    return self;
}

@end
