//
//  RaceStateModel.h
//  liveSample
//
//  Created by Tom on 2018/3/7.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, raceModelKind) {
    raceModelKindPoint = 1,
    raceModelKindTeam,
    raceModelKindPlayer,
};
@interface RaceStateModel : NSObject



@end
@class RacePointStatisticModel;
@interface RacePointsStatisticModel: RaceStateModel
//每节分数数组
@property(nonatomic, strong)NSArray *pointStatisticArray;
@property(nonatomic, strong)RacePointStatisticModel *homePointModel;
@property(nonatomic, strong)RacePointStatisticModel *visitorPointModel;
@property(nonatomic, assign)NSInteger itemNum;
@property(nonatomic, assign)NSInteger OT_Num;
@property(nonatomic, assign)NSArray *itemTypeAray;
+ (instancetype)loadModelWithGameData:(NSDictionary *)gameData;
@end

@interface RacePointStatisticModel: RaceStateModel
//每节分数数组
@property(nonatomic, assign)BOOL isHome;
@property(nonatomic, strong)NSString *Team_id;
@property(nonatomic, strong)NSString *Team_city;
@property(nonatomic, strong)NSString *Team_name;
@property(nonatomic, strong)NSString *Team_abr;
@property(nonatomic, strong)NSString *Home_score;
@property(nonatomic, strong)NSString *Visitor_score;
@property(nonatomic, strong)NSString *Qtr_1_score;
@property(nonatomic, strong)NSString *Qtr_2_score;
@property(nonatomic, strong)NSString *Qtr_3_score;
@property(nonatomic, strong)NSString *Qtr_4_score;
@property(nonatomic, strong)NSString *OT_1_score;
@property(nonatomic, strong)NSString *OT_2_score;
@property(nonatomic, strong)NSString *OT_3_score;
@property(nonatomic, strong)NSString *OT_4_score;
@property(nonatomic, strong)NSString *OT_5_score;
@property(nonatomic, strong)NSString *OT_6_score;
@property(nonatomic, strong)NSString *OT_7_score;
@property(nonatomic, strong)NSString *OT_8_score;
@property(nonatomic, strong)NSString *OT_9_score;
@property(nonatomic, strong)NSString *OT_10_score;

+ (instancetype)loadModelWithOneTeamGameData:(NSDictionary *)oneTeamGameData;
@end



@interface RaceTeamsStatisticModel : RaceStateModel
@property(nonatomic, strong)NSArray *teamStatisticArray;
+ (instancetype)loadModelWithGameData:(NSDictionary *)gameData;
@end
@interface RaceTeamStatisticModel : RaceStateModel
@property(nonatomic, strong)NSString *Team_id;
@property(nonatomic, strong)NSString *Offensive_rebounds;
@property(nonatomic, strong)NSString *Defensive_rebounds;
@property(nonatomic, strong)NSString *Assists;
@property(nonatomic, strong)NSString *Steals;
@property(nonatomic, strong)NSString *Blocks;
@property(nonatomic, strong)NSString *Turnovers;
@property(nonatomic, strong)NSString *Three_made;
@property(nonatomic, strong)NSString *Fouls;
+ (instancetype)loadModelWithOneTeamGameData:(NSDictionary *)oneTeamGameData;
@end




@interface RacePlayersStatisticModel :RaceStateModel
@property(nonatomic, copy)NSArray *players;
+ (instancetype)loadModelWithTeamData:(NSDictionary *)teamData gameData:(NSDictionary*)gameData;

@end
@interface RacePlayerModel : NSObject
@property(nonatomic, strong)NSString *teamId;
@property(nonatomic, strong)NSString *playerId;

@property(nonatomic, strong)NSString *name;
@property(nonatomic, strong)NSString *minues;
@property(nonatomic, strong)NSString *points;
@property(nonatomic, strong)NSString *total_rebounds;
@property(nonatomic, strong)NSString *assists;
@property(nonatomic, strong)NSString *fg_ma;
@property(nonatomic, strong)NSString *three_ma;
@property(nonatomic, strong)NSString *ft_ma;
@property(nonatomic, strong)NSString *offensive_rebounds;
@property(nonatomic, strong)NSString *defensive_rebounds;
@property(nonatomic, strong)NSString *steals;
@property(nonatomic, strong)NSString *blocks;
@property(nonatomic, strong)NSString *turnovers;
@property(nonatomic, strong)NSString *blocks_against;
@property(nonatomic, strong)NSString *fouls;
@property(nonatomic, strong)NSString *plus_minus;
@property(nonatomic, strong)NSString *on_crt;

+ (instancetype)loadModelWithPersonTeamData:(NSDictionary *)personTeamData gameData:(NSDictionary *)gameData;
@end
