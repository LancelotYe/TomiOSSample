//
//  TeamStatisticLine.h
//  liveSample
//
//  Created by Tom on 2018/3/14.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamStatisticLine : UIView
@property(nonatomic,assign)CGFloat homeItemScore;
@property(nonatomic,assign)CGFloat visitorItemScore;
+ (instancetype)loadTeamStatisticLineWithFrame:(CGRect)frame;
- (void)setHomeItemScore:(CGFloat)homeItemScore VisitorItemScore:(CGFloat)visItemScore;
@end
