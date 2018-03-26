//
//  TMIconImageView.m
//  BesTV
//
//  Created by Tom on 2018/3/21.
//  Copyright © 2018年 Liangfeng Hu. All rights reserved.
//

#import "TMIconImageView.h"
//#import "UIImageView+WebCache.h"
@interface TMIconImageView()
@property(nonatomic, strong)UIImageView *imageView;

@end
@implementation TMIconImageView
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(30, 100, 200, 200)];
//    [view setBackgroundColor:[UIColor greenColor]];
//    [self.view addSubview:view];
//    TMIconImageView *sv = [TMIconImageView loadImegViewWithUrl:@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2544269114,2104066965&fm=27&gp=0.jpg" placeHoldName:@"234"];
//    [view addSubview:sv];
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.imageView];
    }
    return self;
}
+ (instancetype)loadImegViewWithUrl:(NSString *)url placeHoldName:(NSString *)name{
    TMIconImageView *iconImageView = [[TMIconImageView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
//    [iconImageView.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:name]];
    return iconImageView;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.superview.bounds;
    self.frame = bounds;
    self.layer.cornerRadius = bounds.size.width/2;
    self.clipsToBounds = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    
}

@end
