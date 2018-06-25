//
//  invoke.h
//  liveSample
//
//  Created by Tom on 2018/6/25.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MethodProtocol.h"
#import "MACMachine.h"
@interface invoke : NSObject
@property (nonatomic, strong)id<MethodProtocol> startup;
@property (nonatomic, strong)id<MethodProtocol> shutdown;
- (instancetype)initWithStartM:(id<MethodProtocol>)startup shutM:(id<MethodProtocol>)shut;
- (void)startUp;
- (void)shutDown;
@end
