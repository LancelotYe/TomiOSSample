//
//  RaceStateViewController.m
//  liveSample
//
//  Created by Tom on 2018/3/6.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import "RaceStateViewController.h"
#import "TMCurtainView.h"
@interface RaceStateViewController ()
@property(nonatomic, strong)TMCurtainView *curtainView;
@end
@implementation RaceStateViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    NSLog(@"%f",[UIScreen mainScreen].bounds.size.width);
    self.view.backgroundColor = [UIColor whiteColor];
    _curtainView = [TMCurtainView loadCurtainViewOnBaseView:self.view];
    [self.view addSubview:_curtainView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
