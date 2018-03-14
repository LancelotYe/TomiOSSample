//
//  PointIconView.h
//  liveSample
//
//  Created by Tom on 2018/3/9.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PointIconView : UIView
+ (instancetype)loadPointIconView;
@property(nonatomic, strong)NSString *homeIconUrl;
@property(nonatomic, strong)NSString *visitorIconUrl;
@end
