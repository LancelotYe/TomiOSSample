//
//  StretchingableNavViewController.m
//  liveSample
//
//  Created by Tom on 2018/3/6.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import "StretchingableNavViewController.h"
#import "StretchingNavBar.h"
#define screenW [UIScreen mainScreen].bounds.size.width
@interface StretchingableNavViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)UIImageView *bgView;
@property(nonatomic, strong)StretchingNavBar *navbar;
@property(nonatomic, assign)CGFloat headHeight;
@property(nonatomic, assign)CGRect originalBgFrame;
@end

@implementation StretchingableNavViewController
@synthesize headHeight;
static NSString *cellID = @"cellID";

- (CGRect)originalBgFrame{
    return CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width / 1.6);
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.contentInset = UIEdgeInsetsMake(headHeight, 0, 0, 0);
        
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    headHeight = screenW/1.6-64;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    _bgView = [[UIImageView alloc] initWithFrame:self.originalBgFrame];
    [_bgView setImage:[UIImage imageNamed:@"123"]];
    [self.view addSubview:_bgView];
    [self.view addSubview:self.tableView];
    
    //导航栏
    _navbar = [[StretchingNavBar alloc] init];
    _navbar.title = @"拉伸";
    _navbar.leftImg = @"234";
    _navbar.rightImg = @"234";
    _navbar.tileColor = [UIColor greenColor];
    
    [self.view addSubview:_navbar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.textLabel.text = @"Tom super Tom";
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.y;
    if (offset > -headHeight) {
        CGFloat colorAlpha = (offset+headHeight)/headHeight;
        _navbar.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:colorAlpha];
    }
    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    CGRect frame = self.originalBgFrame;
    if (offset > -headHeight) {
        frame.origin.y = self.originalBgFrame.origin.y-offset-headHeight;
    }else{
        frame.size.height = self.originalBgFrame.size.height - offset - headHeight;
        frame.size.width = frame.size.height * 1.6;
        frame.origin.x = self.originalBgFrame.origin.x - (frame.size.width - self.originalBgFrame.size.width) * 0.5;
    }
    _bgView.frame = frame;
    
}

@end
