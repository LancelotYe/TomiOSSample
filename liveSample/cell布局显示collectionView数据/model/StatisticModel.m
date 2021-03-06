//
//  StatisticModel.m
//  liveSample
//
//  Created by Tom on 2018/3/13.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import "StatisticModel.h"

@implementation StatisticModel
+ (NSDictionary *)loadTransDict{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"transNBA" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSDictionary *tranDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    return tranDict;
}
@end
/**
 point统计
 */
@implementation RacePointsStatisticModel
+ (instancetype)loadModelWithGameData:(NSDictionary *)gameData{
    NSDictionary *dict = [[gameData objectForKey:@"data"] objectForKey:@"Score"];
    RacePointsStatisticModel *modelx = [[RacePointsStatisticModel alloc] init];
    modelx.homePointModel = [RacePointStatisticModel loadModelWithOneTeamGameData:[[dict objectForKey:@"Home"] objectForKey:@"Home_score"] isHome:YES];
    modelx.visitorPointModel = [RacePointStatisticModel loadModelWithOneTeamGameData:[[dict objectForKey:@"Visitor"] objectForKey:@"Visitor_score"] isHome:NO];
    NSInteger OT_Num = [self calOTNumWithPointModelx:modelx];
    modelx.OT_Num = OT_Num;
    modelx.itemNum = 4 + modelx.OT_Num + 1;
    NSMutableArray *itemArray = [NSMutableArray arrayWithObjects:@"Qtr_1_score",@"Qtr_2_score",@"Qtr_3_score",@"Qtr_4_score", nil];
    if (OT_Num!=0) {
        for (int i = 1; i <= OT_Num; i++) {
            NSString *addItem = [NSString stringWithFormat:@"OT_%d_score",i];
            [itemArray addObject:addItem];
        }
    }
    [itemArray addObject:@"总分"];
    modelx.itemTypeAray = [itemArray copy];
    modelx.cellH = pointCellH * 2 + pointItemH;
    return modelx;
}

+ (NSInteger)calOTNumWithPointModelx:(RacePointsStatisticModel *)modelx{
    if ([modelx.homePointModel.OT_1_score isEqualToString:@"0"]
        &&[modelx.visitorPointModel.OT_1_score isEqualToString:@"0"]) {
        return 0;
    }else if ([modelx.homePointModel.OT_2_score isEqualToString:@"0"]
              &&[modelx.visitorPointModel.OT_2_score isEqualToString:@"0"]){
        return 1;
    }else if ([modelx.homePointModel.OT_3_score isEqualToString:@"0"]
              &&[modelx.visitorPointModel.OT_3_score isEqualToString:@"0"]){
        return 2;
    }else if ([modelx.homePointModel.OT_4_score isEqualToString:@"0"]
              &&[modelx.visitorPointModel.OT_4_score isEqualToString:@"0"]){
        return 3;
    }else if ([modelx.homePointModel.OT_5_score isEqualToString:@"0"]
              &&[modelx.visitorPointModel.OT_5_score isEqualToString:@"0"]){
        return 4;
    }else if ([modelx.homePointModel.OT_6_score isEqualToString:@"0"]
              &&[modelx.visitorPointModel.OT_6_score isEqualToString:@"0"]){
        return 5;
    }else if ([modelx.homePointModel.OT_7_score isEqualToString:@"0"]
              &&[modelx.visitorPointModel.OT_7_score isEqualToString:@"0"]){
        return 6;
    }else if ([modelx.homePointModel.OT_8_score isEqualToString:@"0"]
              &&[modelx.visitorPointModel.OT_8_score isEqualToString:@"0"]){
        return 7;
    }else if ([modelx.homePointModel.OT_9_score isEqualToString:@"0"]
              &&[modelx.visitorPointModel.OT_9_score isEqualToString:@"0"]){
        return 8;
    }else if ([modelx.homePointModel.OT_10_score isEqualToString:@"0"]
              &&[modelx.visitorPointModel.OT_10_score isEqualToString:@"0"]){
        return 9;
    }else{
        return 10;
    }
}

+ (NSString *)getHomeTeamIdWithGameData:(NSDictionary *)gameData{
    RacePointsStatisticModel *pointModel = [RacePointsStatisticModel loadModelWithGameData:gameData];
    return pointModel.homePointModel.Team_id;
}
+ (NSString *)getHomeIconURLWithGameData:(NSDictionary *)gameData{
    return [NSString stringWithFormat:@"https://bestvapp.bestv.cn/qa/yehui/nba/%@.jpg",[self getHomeTeamIdWithGameData:gameData]];
}
+ (NSString *)getVisitorTeamIdWithGameData:(NSDictionary *)gameData{
    RacePointsStatisticModel *pointModel = [RacePointsStatisticModel loadModelWithGameData:gameData];
    return pointModel.visitorPointModel.Team_id;
}
+ (NSString *)getVisitorIconURLWithGameData:(NSDictionary *)gameData{
    return [NSString stringWithFormat:@"https://bestvapp.bestv.cn/qa/yehui/nba/%@.jpg",[self getVisitorTeamIdWithGameData:gameData]];
}
@end

@implementation RacePointStatisticModel
+(instancetype)loadModelWithOneTeamGameData:(NSDictionary *)oneTeamGameData isHome:(BOOL)isHome{
    RacePointStatisticModel *pointModel = [[RacePointStatisticModel alloc] init];
    pointModel.Team_id = [oneTeamGameData objectForKey:@"Team_id"];
    pointModel.Team_city = [oneTeamGameData objectForKey:@"Team_city"];
    pointModel.Team_name = [oneTeamGameData objectForKey:@"CN_name"];
    pointModel.Team_abr = [oneTeamGameData objectForKey:@"Team_abr"];
    if (isHome) {
        pointModel.Home_score = [oneTeamGameData objectForKey:@"Home_score"];
    }else{
        pointModel.Visitor_score = [oneTeamGameData objectForKey:@"Visitor_score"];
    }
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
    
    RaceTeamsStatisticModel *teamsModel = [[RaceTeamsStatisticModel alloc] init];
    NSDictionary *dict = [[gameData objectForKey:@"data"]objectForKey:@"TeamData"];
    NSString *homeTeamid = [RacePointsStatisticModel getHomeTeamIdWithGameData:gameData];
    RaceTeamStatisticModel *hometeamModel = [RaceTeamStatisticModel loadModelWithOneTeamGameData:[dict objectForKey:homeTeamid]];
    hometeamModel.team_id = homeTeamid;
    teamsModel.homeTeamModel = hometeamModel;
    
    NSString *visitorTeamid = [RacePointsStatisticModel getVisitorTeamIdWithGameData:gameData];
    RaceTeamStatisticModel *visitorteamModel = [RaceTeamStatisticModel loadModelWithOneTeamGameData:[dict objectForKey:visitorTeamid]];
    visitorteamModel.team_id = visitorTeamid;
    teamsModel.visitorTeamModel = visitorteamModel;
    
    teamsModel.itemNum = 8;
    teamsModel.itemTypeArray = @[@"offensive_rebounds",@"defensive_rebounds",@"assists",@"steals",@"blocks",@"turnovers",@"three_made",@"fouls"];
    teamsModel.cellH = (teamsModel.itemNum * teamCellH) + teamIconH;
    return teamsModel;
}
@end
@implementation RaceTeamStatisticModel
+(instancetype)loadModelWithOneTeamGameData:(NSDictionary *)oneTeamGameData{
    RaceTeamStatisticModel *model = [[RaceTeamStatisticModel alloc] init];
    model.offensive_rebounds = [oneTeamGameData objectForKey:@"Offensive_rebounds"];
    model.defensive_rebounds = [oneTeamGameData objectForKey:@"Defensive_rebounds"];
    model.assists = [oneTeamGameData objectForKey:@"Assists"];
    model.steals = [oneTeamGameData objectForKey:@"Steals"];
    model.blocks = [oneTeamGameData objectForKey:@"Blocks"];
    model.turnovers = [oneTeamGameData objectForKey:@"Turnovers"];
    model.three_made = [oneTeamGameData objectForKey:@"Three_made"];
    model.fouls = [oneTeamGameData objectForKey:@"Fouls"];
    return model;
}

@end
/**
 player一支队伍的
 */
@implementation RacePlayersStatisticModel
+ (NSArray*)getHomePeriodPlayersWithLineups:(NSDictionary *)lineups{
    NSString *hf1_id = [lineups objectForKey:@"Home_forward_1_id"];
    NSString *hf2_id = [lineups objectForKey:@"Home_forward_2_id"];
    NSString *hc_id = [lineups objectForKey:@"Home_center_id"];
    NSString *hg1_id = [lineups objectForKey:@"Home_guard_1_id"];
    NSString *hg2_id = [lineups objectForKey:@"Home_guard_2_id"];
    return @[hf1_id,hf2_id,hc_id,hg1_id,hg2_id];
}
+ (NSArray*)getVisitorPeriodPlayersWithLineups:(NSDictionary *)lineups{
    NSString *vf1_id = [lineups objectForKey:@"Visitor_forward_1_id"];
    NSString *vf2_id = [lineups objectForKey:@"Visitor_forward_2_id"];
    NSString *vc_id = [lineups objectForKey:@"Visitor_center_id"];
    NSString *vg1_id = [lineups objectForKey:@"Visitor_guard_1_id"];
    NSString *vg2_id = [lineups objectForKey:@"Visitor_guard_2_id"];
    
    return  @[vf1_id,vf2_id,vc_id,vg1_id,vg2_id];
}
+ (instancetype)loadModelWithTeamData:(NSDictionary *)teamData gameData:(NSDictionary *)gameData{
    NSDictionary *data = [teamData objectForKey:@"data"];
    NSDictionary *lineups = [data objectForKey:@"Lineups"];
    //获取首发球员数组
    NSArray *homePeriodPlayers = [self getHomePeriodPlayersWithLineups:lineups];
    NSArray *visitorPeriodPlayers = [self getVisitorPeriodPlayersWithLineups:lineups];
    
    NSArray *array = [data objectForKey:@"Players"];
    
    NSMutableArray *homePlayerArrayM = [NSMutableArray array];
    NSMutableArray *visitorPlayerArrayM = [NSMutableArray array];
    
    NSString *homeTeamId = [RacePointsStatisticModel getHomeTeamIdWithGameData:gameData];
    NSString *visitorTeamId = [RacePointsStatisticModel getVisitorTeamIdWithGameData:gameData];
    //拆分主队和客队球员
    for (NSDictionary *dict in array) {
        RacePlayerModel *playerModelx = [RacePlayerModel loadModelWithPersonTeamData:dict gameData:gameData];
        if ([playerModelx.teamId isEqualToString:homeTeamId]) {
            [homePlayerArrayM addObject:playerModelx];
        }else if ([playerModelx.teamId isEqualToString:visitorTeamId]){
            [visitorPlayerArrayM addObject:playerModelx];
        }
    }
    //排序主队
    NSArray *homeCopy = [homePlayerArrayM copy];
    for (NSString *playID in homePeriodPlayers) {
        NSInteger targetIndex = [homePeriodPlayers indexOfObject:playID];
        for (RacePlayerModel *playerModel in homeCopy) {
            if ([playID isEqualToString:playerModel.playerId]) {
                NSInteger originIndex = [homePlayerArrayM indexOfObject:playerModel];
                [homePlayerArrayM exchangeObjectAtIndex:targetIndex withObjectAtIndex:originIndex];
            }
        }
    }
    for (RacePlayerModel *playerModel in homePlayerArrayM) {
        NSInteger index = [homePlayerArrayM indexOfObject:playerModel];
        if(index<5){
            playerModel.period = @"是";
        }else{
            playerModel.period = @"否";
        }
    }
    
    //排序客队
    NSArray *visitorCopy = [visitorPlayerArrayM copy];
    for (NSString *playID in [visitorPeriodPlayers mutableCopy]) {
        NSInteger targetIndex = [visitorPeriodPlayers indexOfObject:playID];
        for (RacePlayerModel *playerModel in visitorCopy) {
            if ([playID isEqualToString:playerModel.playerId]) {
                NSInteger originIndex = [visitorPlayerArrayM indexOfObject:playerModel];
                [visitorPlayerArrayM exchangeObjectAtIndex:targetIndex withObjectAtIndex:originIndex];
            }
        }
    }
    for (RacePlayerModel *playerModel in visitorPlayerArrayM) {
        NSInteger index = [visitorPlayerArrayM indexOfObject:playerModel];
        if(index<5){
            playerModel.period = @"是";
        }else{
            playerModel.period = @"否";
        }
    }
    
    RacePlayersStatisticModel *playerModel = [[RacePlayersStatisticModel alloc] init];
    playerModel.homePlayers = [homePlayerArrayM copy];
    playerModel.visitorPlayers = [visitorPlayerArrayM copy];
    playerModel.itemNum = 18;
    playerModel.itemArray = @[@"name",@"period",@"minutes",@"points",@"total_rebounds",@"assists",@"fg_ma",@"three_ma",@"ft_ma",@"offensive_rebounds",@"defensive_rebounds",@"steals",@"blocks",@"turnovers",@"blocks_against",@"fouls",@"plus_minus",@"on_crt"];
    return playerModel;
}
@end
@implementation RacePlayerModel
+ (instancetype)loadModelWithPersonTeamData:(NSDictionary *)personTeamData gameData:(NSDictionary *)gameData{
    RacePlayerModel *playerModel = [[RacePlayerModel alloc] init];
    playerModel.playerId = [personTeamData objectForKey:@"Person_id"];
/**
图片地址
https://bestvapp.bestv.cn/qa/yehui/nba/1610612742.jpg
 */

    
    playerModel.teamId = [personTeamData objectForKey:@"Team_id"];
    NSDictionary *dict = [[[gameData objectForKey:@"data"] objectForKey:@"PlayerData"] objectForKey:playerModel.playerId];
//    playerModel.name = [NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"First_name"],[dict objectForKey:@"Last_name"]];
    playerModel.name = [dict objectForKey:@"CN_name"];
    playerModel.minutes = [dict objectForKey:@"Minutes"];
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
    playerModel.on_crt = [[dict objectForKey:@"OnCrt"]isEqualToString:@"1"]?@"是":@"否";
    return playerModel;
}
@end
