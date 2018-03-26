//
//  TMPlayerConfiguration.m
//  liveSample
//
//  Created by Tom on 2018/3/23.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import "TMPlayerConfiguration.h"

@implementation TMPlayerConfiguration
/**
 初始化 设置缺省值
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        _hideControlsInterval = 5.0f;
    }
    return self;
}
@end
