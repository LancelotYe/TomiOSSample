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
#import "TeamStatisticCell.h"
#import "PlayerStatisticCell.h"
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
    NSString *path = [[NSBundle mainBundle] pathForResource:@"contentes" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSString *datastr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    datastr = [datastr stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    data = [datastr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@",dict.description);
    
    path = [[NSBundle mainBundle] pathForResource:@"content" ofType:@"json"];
    NSData *dataa = [[NSData alloc] initWithContentsOfFile:path];
    _teamsData = [NSJSONSerialization JSONObjectWithData:dataa options:NSJSONReadingMutableLeaves error:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        return 400;
    }else if ( indexPath.row == 3 || indexPath.row == 4){
        return 600;
    }
    return 200;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *teamADict = _teamsData[0];
    NSDictionary *teamBDict = _teamsData[1];
    if (indexPath == 0) {
        RaceStateCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[RaceStateCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        }
        return cell;
    }else if (indexPath.row ==1){
        
        RacePointStatisticModel *teamAModel = [RacePointStatisticModel loadModelWithDict:teamADict];
        RacePointStatisticModel *teamBModel = [RacePointStatisticModel loadModelWithDict:teamBDict];
        PointStatisticCell *cell = [PointStatisticCell loadCellWithTeamModelA:teamAModel TeamModelB:teamBModel reuseID:cellID];
        return cell;
    }else if (indexPath.row == 2){
        RaceTeamStatisticModel *teamAteamModel = [RaceTeamStatisticModel loadModelWithDict:teamADict];
        RaceTeamStatisticModel *teamBteamModel = [RaceTeamStatisticModel loadModelWithDict:teamBDict];
        TeamStatisticCell *cell = [TeamStatisticCell loadCellWithTeamModelA:teamAteamModel TeamModelB:teamBteamModel reuseID:cellID];
        return cell;
    }else if (indexPath.row == 3 || indexPath.row == 4){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        return cell;
    }
    else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        return cell;
    }
}



@end
