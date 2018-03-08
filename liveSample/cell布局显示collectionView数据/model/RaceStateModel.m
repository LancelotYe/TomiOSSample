//
//  RaceStateModel.m
//  liveSample
//
//  Created by Tom on 2018/3/7.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import "RaceStateModel.h"

@implementation RaceStateModel

+ (instancetype)loadModelWithDict:(NSDictionary *)dict{
    RaceStateModel *model = [[RaceStateModel alloc] init];
    model.teamName = [dict objectForKey:@"teamName"];
    return model;
    
}

@end
/**
 point统计
 */
@implementation RacePointStatisticModel
+ (instancetype)loadModelWithDict:(NSDictionary *)dict{
    RacePointStatisticModel *pointModel = [[RacePointStatisticModel alloc] init];
    //    pointModel.kind = raceModelKindPoint;
    //每节分数数组
    pointModel.scoreArray = [dict objectForKey:@"point"];
    return pointModel;
}
@end
/**
 team统计
 */
@implementation RaceTeamStatisticModel
+ (instancetype)loadModelWithDict:(NSDictionary *)dict{
    
    RaceTeamStatisticModel *teamModel = [[RaceTeamStatisticModel alloc] init];
    teamModel.teamStatisticArray = [dict objectForKey:@"point"];

    return teamModel;
}
@end

/**
 player一支队伍的
 */
@implementation RacePlayersStatisticModel
+ (instancetype)loadModelWithDict:(NSDictionary *)dict{
    RacePlayersStatisticModel *playerModel = (RacePlayersStatisticModel *)[super loadModelWithDict:dict];
    playerModel.kind = raceModelKindPlayer;
    NSMutableArray *playerArrayM = [NSMutableArray array];
    NSArray *playerArray = [dict objectForKey:@"players"];
    for (NSDictionary *dict in playerArray) {
        RacePlayerModel *playerModelx = [RacePlayerModel loadModelWithDict:dict];
        [playerArrayM addObject:playerModelx];
    }
    playerModel.players = playerArrayM;
    return playerModel;
}
@end
@implementation RacePlayerModel
+ (instancetype)loadModelWithDict:(NSDictionary *)dict{
    RacePlayerModel *playerModel = [[RacePlayerModel alloc] init];
    //球员
    playerModel.playerName = [dict objectForKey:@"playerName"];
    //得分
    playerModel.point = [dict objectForKey:@"point"];
    //篮板
    playerModel.backboardNum = [dict objectForKey:@"backboardNum"];
    //助攻
    playerModel.assistingNum = [dict objectForKey:@"assistingNum"];
    //投篮
    playerModel.shotNum = [dict objectForKey:@"shotNum"];
    //三分
    playerModel.threePointNum = [dict objectForKey:@"threePointNum"];
    //罚球
    playerModel.penaltyShotNum = [dict objectForKey:@"penaltyShotNum"];
    //抢断
    playerModel.interceptNum = [dict objectForKey:@"interceptNum"];
    //盖帽
    playerModel.blockNum = [dict objectForKey:@"blockNum"];
    //失误
    playerModel.faultNum = [dict objectForKey:@"faultNum"];
    //犯规
    playerModel.foulNum = [dict objectForKey:@"foulNum"];
    return playerModel;
}
@end
