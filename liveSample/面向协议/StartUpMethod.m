//
//  StartUpMethod.m
//  liveSample
//
//  Created by Tom on 2018/6/25.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import "StartUpMethod.h"
@interface StartUpMethod()
@property (nonatomic, strong)MACMachine *mac;
@end
@implementation StartUpMethod
- (instancetype)initWithMac:(MACMachine *)mac{
    self = [super init];
    if (self) {
        self.mac = mac;
    }
    return self;
}
- (void)excute{
    [self.mac startUp];
}
@end
