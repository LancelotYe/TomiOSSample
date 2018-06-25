//
//  invoke.m
//  liveSample
//
//  Created by Tom on 2018/6/25.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import "invoke.h"

@implementation invoke
- (instancetype)initWithStartM:(id<MethodProtocol>)startup shutM:(id<MethodProtocol>)shut{
    if (self = [super init]) {
        self.startup = startup;
        self.shutdown = shut;
    }
    return self;
}

- (void)startUp{
    [self.startup excute];
}
- (void)shutDown{
    [self.shutdown excute];
}
@end
