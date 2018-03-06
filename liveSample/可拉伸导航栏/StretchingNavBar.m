//
//  StretchingNavBar.m
//  liveSample
//
//  Created by Tom on 2018/3/6.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import "StretchingNavBar.h"
@interface StretchingNavBar()
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UIImageView *leftImgView;
@property(nonatomic, strong)UIImageView *rightImgView;
@end
@implementation StretchingNavBar
CGFloat imgWH = 40;
CGFloat titleW = 200;

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - titleW) * 0.5, 10, titleW, 60)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:20];
    }
    return _titleLabel;
}
- (UIImageView *)leftImgView{
    if (!_leftImgView) {
        _leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (self.bounds.size.height - imgWH)*0.5 + 10, imgWH, imgWH)];
    }
    return _leftImgView;
}
- (UIImageView *)rightImgView{
    if (!_rightImgView) {
        _rightImgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width-imgWH - 10, (self.bounds.size.height - imgWH)*0.5 + 10, imgWH, imgWH)];
    }
    return _rightImgView;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.leftImgView];
        [self addSubview:self.rightImgView];
    }
    return self;
}
- (void)setTitle:(NSString *)title{
    _title = title;
    [self addSubview:self.titleLabel];
    self.titleLabel.text = title;
}
- (void)setLeftImg:(NSString *)leftImg{
    _leftImg = leftImg;
    [self.leftImgView setImage:[UIImage imageNamed:_leftImg]];
}
- (void)setRightImg:(NSString *)rightImg{
    _rightImg = rightImg;
    [self.rightImgView setImage:[UIImage imageNamed:_rightImg]];
}
-(void)setTileColor:(UIColor *)tileColor{
    _tileColor = tileColor;
    self.titleLabel.textColor = tileColor;
}

@end
