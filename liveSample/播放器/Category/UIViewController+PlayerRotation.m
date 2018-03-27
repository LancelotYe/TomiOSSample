//
//  UIViewController+PlayerRotation.m
//  liveSample
//
//  Created by Tom on 2018/3/25.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import "UIViewController+PlayerRotation.h"
#import <objc/runtime.h>

@implementation UIViewController (PlayerRotation)
/**
 默认所有都不支持转屏，如需个别页面支持除竖屏外的其他方向，请在ViewController重新下边这三个方法
 */
//是否支持自动转屏
//- (BOOL)shouldAutorotate{
//    return NO;
//}
//
////支持哪些屏幕方向
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    return UIInterfaceOrientationMaskPortrait;
//}
//
////默认的屏幕方向 (当前ViewController必须是通过模态出来的UIViewController(模态带导航的无效)方式展现出来的，才会调用这个方法)
//// 一开始的屏幕旋转方向
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
//    return UIInterfaceOrientationPortrait;
//}
//- (UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleDefault;
//}
//- (BOOL)prefersStatusBarHidden{
//    return NO;
//}

@end


@implementation UITabBarController (PlayerRotation)

@end

@implementation UINavigationController (PlayerRotation)

@end

@implementation UIAlertController (PlayerRotation)

@end
