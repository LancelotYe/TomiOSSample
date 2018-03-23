//
//  TMPlayerConfiguration.h
//  liveSample
//
//  Created by Tom on 2018/3/23.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 视频拉伸方式 */
typedef NS_ENUM(NSUInteger, TMVideoGravity){
    TMVideoGravityResize,       //非均匀拉伸。两个维度完全填充至整个视图区域
    TMVideoGravityResizeAspect,     //等比例拉伸，直到一个维度到达区域边界
    TMVideoGravityResizeAspectFill, //等比例拉伸，直到填充满整个视图区域，其中一个维度的部分区域会被裁剪
};
@interface TMPlayerConfiguration : NSObject
/** 视频数据源 */
@property(nonatomic, strong)NSURL *sourceUrl;
/** 视频拉伸方式 */
@property (nonatomic, assign) TMVideoGravity videoGravity;
@end
