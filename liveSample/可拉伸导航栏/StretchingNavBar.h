//
//  StretchingNavBar.h
//  liveSample
//
//  Created by Tom on 2018/3/6.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol StretchingNavBarlegate<NSObject>
-(void)backClickaction;
@end
@interface StretchingNavBar : UIView

@property(nonatomic, strong)NSString *title;
@property(nonatomic, strong)NSString *leftImg;
@property(nonatomic, strong)NSString *rightImg;
@property(nonatomic, strong)UIColor *tileColor;
@property(nonatomic, weak)id<StretchingNavBarlegate>delegate;
@end
