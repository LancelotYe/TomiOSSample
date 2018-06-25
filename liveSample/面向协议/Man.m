//
//  Man.m
//  liveSample
//
//  Created by Tom on 2018/6/25.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import "Man.h"
#import "invoke.h"
#import "StartUpMethod.h"
#import "ShutDownMethod.h"

@implementation Man

- (void)function{
    MACMachine *mac = [[MACMachine alloc] init];
    StartUpMethod *st = [[StartUpMethod alloc] initWithMac:mac];
    ShutDownMethod *sd = [[ShutDownMethod alloc] initWithMac:mac];
    invoke *i = [[invoke alloc] initWithStartM:st shutM:sd];
    [i startUp];
    [i shutDown];
}

@end
