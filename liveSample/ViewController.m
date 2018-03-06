//
//  ViewController.m
//  liveSample
//
//  Created by Tom on 2018/3/5.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import "ViewController.h"
#import "RaceStateViewController.h"
#import "StretchingableNavViewController.h"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@end

@implementation ViewController
static NSString *cellID = @"cellID";
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.navigationItem.title = @"首页";
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"cell布局collectionView用于直播数据";
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"可拉伸导航栏";
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    testVCViewController *tctr = [[testVCViewController alloc] init];
//    [self.navigationController pushViewController:tctr animated:YES];
    if (indexPath.row == 0) {
        RaceStateViewController *race = [[RaceStateViewController alloc] init];
        [self.navigationController pushViewController:race animated:YES];
    }else if(indexPath.row == 1){
        StretchingableNavViewController *stretch = [[StretchingableNavViewController alloc] init];
        [self.navigationController pushViewController:stretch animated:YES];
    }
}
@end
