//
//  TMCurtainView.h
//  liveSample
//
//  Created by Tom on 2018/3/13.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMCurtainView : UIView
@property(nonatomic, strong)UIButton *curtainSwitch;
+ (instancetype)loadCurtainViewOnBaseView:(UIView *)baseView;
@end
