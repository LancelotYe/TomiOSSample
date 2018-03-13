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
@property(nonatomic, strong)UIView *testView;
@property(nonatomic, strong)TMCurtainView *curtainView;
@end
@implementation RaceStateViewController
- (UIView *)testView{
    if (!_testView) {
        _testView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 400)];
        _testView.backgroundColor = [UIColor yellowColor];
    }
    return _testView;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview:self.testView];
    self.view.backgroundColor = [UIColor whiteColor];
    _curtainView = [TMCurtainView loadCurtainViewOnBaseView:self.testView];
    [self.view addSubview:_curtainView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
