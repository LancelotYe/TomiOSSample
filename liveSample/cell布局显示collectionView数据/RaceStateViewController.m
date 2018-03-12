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
@property(nonatomic, strong)NSDictionary *teamsData;
@property(nonatomic, strong)NSDictionary *gameData;
@end
@implementation RaceStateViewController
static NSString *pointID = @"pointID";
static NSString *teamID = @"teamID";
static NSString *playerID = @"playerID";

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
    NSString *path = [[NSBundle mainBundle] pathForResource:@"teamInfo" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    _teamsData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    path = [[NSBundle mainBundle] pathForResource:@"gameInfo" ofType:@"json"];
    NSData *dataa = [[NSData alloc] initWithContentsOfFile:path];
    _gameData = [NSJSONSerialization JSONObjectWithData:dataa options:NSJSONReadingMutableLeaves error:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 10;
    }
    if (indexPath.row == 2) {
        return 800;
    }else if ( indexPath.row == 3 || indexPath.row == 4){
        return 800;
    }
    return 800;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSDictionary *teamADict = _teamsData[0];
//    NSDictionary *teamBDict = _teamsData[1];
    
    
    if (indexPath == 0) {
        RaceStateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
        if (!cell) {
            cell = [[RaceStateCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellID"];
        }
        return cell;
    }else if (indexPath.row ==1){
        
        RacePointsStatisticModel *pointsModel = [RacePointsStatisticModel loadModelWithGameData:_gameData];
        PointStatisticCell *cell = [tableView dequeueReusableCellWithIdentifier:pointID];
        if (!cell) {
            cell = [PointStatisticCell loadCellWithPointsModel:pointsModel reuseID:pointID];
        }
        return cell;
    }else if(indexPath.row == 2){
        RaceTeamsStatisticModel *teamsModel = [RaceTeamsStatisticModel loadModelWithGameData:_gameData];
        TeamStatisticCell *cell = [tableView dequeueReusableCellWithIdentifier:teamID];
        if (!cell) {
            cell = [TeamStatisticCell loadCellWithTeamsModel:teamsModel reuseID:teamID];
        }
        return cell;
    }else if(indexPath.row == 3){
        RacePlayersStatisticModel *model = [RacePlayersStatisticModel loadModelWithTeamData:_teamsData gameData:_gameData];
        PlayerStatisticCell *cell = [tableView dequeueReusableCellWithIdentifier:playerID];
        if (!cell) {
            cell = [PlayerStatisticCell loadCellWithPlayerModel:model reuseID:playerID isHome:YES];
        }
        return cell;
    }else if (indexPath.row == 4){
        RacePlayersStatisticModel *model = [RacePlayersStatisticModel loadModelWithTeamData:_teamsData gameData:_gameData];
        PlayerStatisticCell *cell = [tableView dequeueReusableCellWithIdentifier:playerID];
        if (!cell) {
            cell = [PlayerStatisticCell loadCellWithPlayerModel:model reuseID:playerID isHome:NO];
        }
        return cell;
    }
//    else if (indexPath.row == 2){
////        RaceTeamStatisticModel *teamAteamModel = [RaceTeamStatisticModel loadModelWithDict:teamADict];
////        RaceTeamStatisticModel *teamBteamModel = [RaceTeamStatisticModel loadModelWithDict:teamBDict];
////        TeamStatisticCell *cell = [TeamStatisticCell loadCellWithTeamModelA:teamAteamModel TeamModelB:teamBteamModel reuseID:teamID];
////        return cell;
//        return nil;
//    }else if (indexPath.row == 3 || indexPath.row == 4){
////        RacePlayersStatisticModel *model = [RacePlayersStatisticModel loadModelWithDict:teamADict];
////        PlayerStatisticCell *cell = [PlayerStatisticCell loadCellWithPlayerModel:model reuseID:playerID];
//        return nil;
//    }
    else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        }
        return cell;
    }
}



@end
