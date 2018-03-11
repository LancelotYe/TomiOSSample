//
//  RaceStateModel.m
//  liveSample
//
//  Created by Tom on 2018/3/7.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import "RaceStateModel.h"

@implementation RaceStateModel


@end
/**
 point统计
 */
@implementation RacePointsStatisticModel
+ (instancetype)loadModelWithGameData:(NSDictionary *)gameData{
    NSDictionary *dict = [gameData objectForKey:@"Score"];
    
    
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (int i = 0; i<2; i++) {
        RacePointStatisticModel *model = nil;
        switch (i) {
            case 0:{
                NSDictionary *oneTeamGameDate = [[dict objectForKey:@"Home"] objectForKey:@"Home_score"];
                model = [RacePointStatisticModel loadModelWithOneTeamGameData:oneTeamGameDate];
                model.isHome = YES;
                break;
            }
            case 1:{
                NSDictionary *oneTeamGameDate = [[dict objectForKey:@"Visitor"] objectForKey:@"Visitor_score"];
                model = [RacePointStatisticModel loadModelWithOneTeamGameData:oneTeamGameDate];
                model.isHome = NO;
                break;
            }
        }
        [arrayM addObject:model];
    }
    RacePointsStatisticModel *modelx = [[RacePointsStatisticModel alloc] init];
    modelx.homePointModel = [RacePointStatisticModel loadModelWithOneTeamGameData:[[dict objectForKey:@"Home"] objectForKey:@"Home_score"]];
    modelx.visitorPointModel = [RacePointStatisticModel loadModelWithOneTeamGameData:[[dict objectForKey:@"Visitor"] objectForKey:@"Visitor_score"]];
    NSInteger OT_Num = [self calOTNumWithPointModelx:modelx];
    modelx.OT_Num = OT_Num;
    modelx.itemNum = 4 + modelx.OT_Num + 1;
    NSMutableArray *itemArray = [NSMutableArray arrayWithObjects:@"Qtr_1_score",@"Qtr_2_score",@"Qtr_3_score",@"Qtr_4_score", nil];
    for (int i = 0; i < OT_Num; i++) {
        NSString *addItem = [NSString stringWithFormat:@"OT_%d_score",i];
        [itemArray addObject:addItem];
    }
    [itemArray addObject:@"总分"];
    return modelx;
}

+ (NSInteger)calOTNumWithPointModelx:(RacePointsStatisticModel *)modelx{
    if (modelx.homePointModel.OT_1_score == 0&&modelx.visitorPointModel.OT_1_score==0) {
        return 0;
    }else if (modelx.homePointModel.OT_2_score == 0&&modelx.visitorPointModel.OT_2_score==0){
        return 1;
    }else if (modelx.homePointModel.OT_3_score == 0&&modelx.visitorPointModel.OT_3_score==0){
        return 2;
    }else if (modelx.homePointModel.OT_4_score == 0&&modelx.visitorPointModel.OT_4_score==0){
        return 3;
    }else if (modelx.homePointModel.OT_5_score == 0&&modelx.visitorPointModel.OT_5_score==0){
        return 4;
    }else if (modelx.homePointModel.OT_6_score == 0&&modelx.visitorPointModel.OT_6_score==0){
        return 5;
    }else if (modelx.homePointModel.OT_7_score == 0&&modelx.visitorPointModel.OT_7_score==0){
        return 6;
    }else if (modelx.homePointModel.OT_8_score == 0&&modelx.visitorPointModel.OT_8_score==0){
        return 7;
    }else if (modelx.homePointModel.OT_9_score == 0&&modelx.visitorPointModel.OT_9_score==0){
        return 8;
    }else if (modelx.homePointModel.OT_10_score == 0&&modelx.visitorPointModel.OT_10_score==0){
        return 9;
    }else{
        return 10;
    }
}
@end

@implementation RacePointStatisticModel
+(instancetype)loadModelWithOneTeamGameData:(NSDictionary *)oneTeamGameData{
    RacePointStatisticModel *pointModel = [[RacePointStatisticModel alloc] init];
    pointModel.Team_id = [oneTeamGameData objectForKey:@"Team_id"];
    pointModel.Team_city = [oneTeamGameData objectForKey:@"Team_city"];
    pointModel.Team_name = [oneTeamGameData objectForKey:@"Team_name"];
    pointModel.Team_abr = [oneTeamGameData objectForKey:@"Team_abr"];
    pointModel.Home_score = [oneTeamGameData objectForKey:@"Home_score"];
    pointModel.Visitor_score = [oneTeamGameData objectForKey:@"Visitor_score"];
    pointModel.Qtr_1_score = [oneTeamGameData objectForKey:@"Qtr_1_score"];
    pointModel.Qtr_2_score = [oneTeamGameData objectForKey:@"Qtr_2_score"];
    pointModel.Qtr_3_score = [oneTeamGameData objectForKey:@"Qtr_3_score"];
    pointModel.Qtr_4_score = [oneTeamGameData objectForKey:@"Qtr_4_score"];
    pointModel.OT_1_score = [oneTeamGameData objectForKey:@"OT_1_score"];
    pointModel.OT_2_score = [oneTeamGameData objectForKey:@"OT_2_score"];
    pointModel.OT_3_score = [oneTeamGameData objectForKey:@"OT_3_score"];
    pointModel.OT_4_score = [oneTeamGameData objectForKey:@"OT_4_score"];
    pointModel.OT_5_score = [oneTeamGameData objectForKey:@"OT_5_score"];
    pointModel.OT_6_score = [oneTeamGameData objectForKey:@"OT_6_score"];
    pointModel.OT_7_score = [oneTeamGameData objectForKey:@"OT_7_score"];
    pointModel.OT_8_score = [oneTeamGameData objectForKey:@"OT_8_score"];
    pointModel.OT_9_score = [oneTeamGameData objectForKey:@"OT_9_score"];
    pointModel.OT_10_score = [oneTeamGameData objectForKey:@"OT_10_score"];
    return pointModel;
}
@end
/**
 team统计
 */
@implementation RaceTeamsStatisticModel
+ (instancetype)loadModelWithGameData:(NSDictionary *)gameData{
    RacePointsStatisticModel *pointModel = [RacePointsStatisticModel loadModelWithGameData:gameData];
    NSArray *pointModels = pointModel.pointStatisticArray;
    NSMutableArray *arrayM = [NSMutableArray array];
    RaceTeamsStatisticModel *teamsModel = [[RaceTeamsStatisticModel alloc] init];
    NSDictionary *dict = [gameData objectForKey:@"TeamData"];
    for (RacePointStatisticModel *pointModelx in pointModels) {
        NSString *teamid = pointModelx.Team_id;
        RaceTeamStatisticModel *teamModel = [RaceTeamStatisticModel loadModelWithOneTeamGameData:[dict objectForKey:teamid]];
        teamModel.Team_id = teamid;
        [arrayM addObject:teamModel];
    }
    teamsModel.teamStatisticArray = [arrayM copy];
    return teamsModel;
}
@end
@implementation RaceTeamStatisticModel
+(instancetype)loadModelWithOneTeamGameData:(NSDictionary *)oneTeamGameData{
    RaceTeamStatisticModel *model = [[RaceTeamStatisticModel alloc] init];
    model.Offensive_rebounds = [oneTeamGameData objectForKey:@"Offensive_rebounds"];
    model.Defensive_rebounds = [oneTeamGameData objectForKey:@"Defensive_rebounds"];
    model.Assists = [oneTeamGameData objectForKey:@"Assists"];
    model.Steals = [oneTeamGameData objectForKey:@"Steals"];
    model.Blocks = [oneTeamGameData objectForKey:@"Blocks"];
    model.Turnovers = [oneTeamGameData objectForKey:@"Turnovers"];
    model.Three_made = [oneTeamGameData objectForKey:@"Three_made"];
    model.Fouls = [oneTeamGameData objectForKey:@"Fouls"];
    return model;
}

@end

/**
 player一支队伍的
 */
@implementation RacePlayersStatisticModel
+ (instancetype)loadModelWithTeamData:(NSDictionary *)teamData gameData:(NSDictionary *)gameData{
    NSArray *array = [teamData objectForKey:@"Players"];
    RacePlayersStatisticModel *playerModel = [[RacePlayersStatisticModel alloc] init];
    NSMutableArray *playerArrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        RacePlayerModel *playerModelx = [RacePlayerModel loadModelWithPersonTeamData:dict gameData:gameData];
        [playerArrayM addObject:playerModelx];
    }
    playerModel.players = playerArrayM;
    return playerModel;
}
@end
@implementation RacePlayerModel
+ (instancetype)loadModelWithPersonTeamData:(NSDictionary *)personTeamData gameData:(NSDictionary *)gameData{
    RacePlayerModel *playerModel = [[RacePlayerModel alloc] init];
    playerModel.playerId = [personTeamData objectForKey:@"Person_id"];
    playerModel.teamId = [personTeamData objectForKey:@"Team_id"];
    NSDictionary *dict = [[gameData objectForKey:@"PlayerData"] objectForKey:playerModel.playerId];
    playerModel.name = [NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"First_name"],[dict objectForKey:@"Last_name"]];
    playerModel.minues = [dict objectForKey:@"Minutes"];
    playerModel.points = [dict objectForKey:@"Points"];
    playerModel.total_rebounds = [dict objectForKey:@"Total_rebounds"];
    playerModel.assists = [dict objectForKey:@"Assists"];
    playerModel.fg_ma = [NSString stringWithFormat:@"%@/%@",[dict objectForKey:@"FG_made"],[dict objectForKey:@"FG_attempted"]];
    playerModel.three_ma = [NSString stringWithFormat:@"%@/%@",[dict objectForKey:@"Three_made"],[dict objectForKey:@"Three_attempted"]];
    playerModel.ft_ma = [NSString stringWithFormat:@"%@/%@",[dict objectForKey:@"FT_made"],[dict objectForKey:@"FT_attempted"]];
    playerModel.offensive_rebounds = [dict objectForKey:@"Offensive_rebounds"];
    playerModel.defensive_rebounds = [dict objectForKey:@"Defensive_rebounds"];
    playerModel.steals = [dict objectForKey:@"Steals"];
    playerModel.blocks = [dict objectForKey:@"Blocks"];
    playerModel.turnovers = [dict objectForKey:@"Turnovers"];
    playerModel.blocks_against = [dict objectForKey:@"BlocksAgainst"];
    playerModel.fouls = [dict objectForKey:@"Fouls"];
    playerModel.plus_minus = [dict objectForKey:@"PlusMinus"];
    playerModel.on_crt = [dict objectForKey:@"OnCrt"];
    return playerModel;
}
@end
