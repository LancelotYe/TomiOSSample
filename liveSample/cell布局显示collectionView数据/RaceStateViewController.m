//
//  RaceStateViewController.m
//  liveSample
//
//  Created by Tom on 2018/3/6.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import "RaceStateViewController.h"
#import "RaceStateCell.h"
#import "PointStatisticCell.h"
@interface RaceStateViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSArray *teamsData;
@end
@implementation RaceStateViewController
static NSString *cellID = @"cellID";
- (UITableView *)tableView{
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
    NSString *path = [[NSBundle mainBundle] pathForResource:@"content" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    _teamsData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath == 0) {
        RaceStateCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[RaceStateCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        }
        return cell;
    }else if (indexPath.row ==1){
        NSDictionary *teamADict = _teamsData[0];
        NSDictionary *teamBDict = _teamsData[1];
        RacePointStatisticModel *teamAModel = [RacePointStatisticModel loadModelWithDict:teamADict];
        RacePointStatisticModel *teamBModel = [RacePointStatisticModel loadModelWithDict:teamBDict];
        PointStatisticCell *cell = [PointStatisticCell loadCellWithTeamModelA:teamAModel TeamModelB:teamBModel reuseID:cellID];
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        return cell;
    }
}



@end
