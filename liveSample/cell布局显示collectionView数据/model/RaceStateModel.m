//
//  RaceStateModel.m
//  liveSample
//
//  Created by Tom on 2018/3/7.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import "RaceStateModel.h"

@implementation RaceStateModel

+ (instancetype)loadModelWithTeamData:(NSDictionary *)teamData GameData:(NSDictionary *)gameData{
    RaceStateModel *model = [[RaceStateModel alloc] init];
    model.pointsModel = [RacePointsStatisticModel loadModelWithGameData:gameData];
    model.teamsModel = [RaceTeamsStatisticModel loadModelWithGameData:gameData];
    model.playersModel = [RacePlayersStatisticModel loadModelWithTeamData:teamData gameData:gameData];
    model.homeName = model.pointsModel.homePointModel.Team_name;
    model.visitorName = model.pointsModel.visitorPointModel.Team_name;
    return model;
}
@end

