//
//  RaceStateModel.h
//  liveSample
//
//  Created by Tom on 2018/3/7.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatisticModel.h"
@interface RaceStateModel : NSObject
@property(nonatomic, strong)RacePointsStatisticModel *pointsModel;
@property(nonatomic, strong)RaceTeamsStatisticModel *teamsModel;
@property(nonatomic, strong)RacePlayersStatisticModel *playersModel;
@property(nonatomic, strong)NSString *homeName;
@property(nonatomic, strong)NSString *visitorName;
+(instancetype)loadModelWithTeamData:(NSDictionary *)teamData GameData:(NSDictionary *)gameData;

@end


