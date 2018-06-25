//
//  StartUpMethod.h
//  liveSample
//
//  Created by Tom on 2018/6/25.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MethodProtocol.h"
#import "MACMachine.h"

@interface StartUpMethod : NSObject<MethodProtocol>
- (instancetype)initWithMac:(MACMachine *)mac;
@end
