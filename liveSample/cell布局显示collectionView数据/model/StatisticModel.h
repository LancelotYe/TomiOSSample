//
//  StatisticModel.h
//  liveSample
//
//  Created by Tom on 2018/3/13.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define curtainSwitchW 26
#define curtainSwitchH 100
#define curtainW [UIScreen mainScreen].bounds.size.width
#define tableViewW ([UIScreen mainScreen].bounds.size.width-curtainSwitchW)

#define teamImgW 24
#define teamIconH 30
#define teamCellH 44

#define pointIconW tableViewW/6
#define pointCellH 44
#define pointItemH 20
#define pointIconImgW 24

#define playerCellH 30
#define playerItemH 20

@interface StatisticModel : NSObject
+ (NSDictionary *)loadTransDict;
@end
@class RacePointStatisticModel;
@interface RacePointsStatisticModel: NSObject
@property(nonatomic, assign)CGFloat cellH;
//每节分数数组
@property(nonatomic, strong)RacePointStatisticModel *homePointModel;
@property(nonatomic, strong)RacePointStatisticModel *visitorPointModel;
@property(nonatomic, assign)NSInteger itemNum;
@property(nonatomic, assign)NSInteger OT_Num;
@property(nonatomic, strong)NSArray *itemTypeAray;
+ (instancetype)loadModelWithGameData:(NSDictionary *)gameData;
@end

@interface RacePointStatisticModel: NSObject
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

+ (instancetype)loadModelWithOneTeamGameData:(NSDictionary *)oneTeamGameData isHome:(BOOL)isHome;
@end

@class RaceTeamStatisticModel;

@interface RaceTeamsStatisticModel : NSObject
@property(nonatomic, assign)CGFloat cellH;
@property(nonatomic, assign)NSInteger itemNum;
@property(nonatomic, strong)NSArray *itemTypeArray;
@property(nonatomic, strong)RaceTeamStatisticModel *homeTeamModel;
@property(nonatomic, strong)RaceTeamStatisticModel *visitorTeamModel;
+ (instancetype)loadModelWithGameData:(NSDictionary *)gameData;
@end
@interface RaceTeamStatisticModel : NSObject
@property(nonatomic, strong)NSString *team_id;
@property(nonatomic, strong)NSString *offensive_rebounds;
@property(nonatomic, strong)NSString *defensive_rebounds;
@property(nonatomic, strong)NSString *assists;
@property(nonatomic, strong)NSString *steals;
@property(nonatomic, strong)NSString *blocks;
@property(nonatomic, strong)NSString *turnovers;
@property(nonatomic, strong)NSString *three_made;
@property(nonatomic, strong)NSString *fouls;
+ (instancetype)loadModelWithOneTeamGameData:(NSDictionary *)oneTeamGameData;
@end




@interface RacePlayersStatisticModel :NSObject
@property(nonatomic, copy)NSArray *homePlayers;
@property(nonatomic, copy)NSArray *visitorPlayers;
@property(nonatomic, assign)NSInteger itemNum;
@property(nonatomic, copy)NSArray *itemArray;
+ (instancetype)loadModelWithTeamData:(NSDictionary *)teamData gameData:(NSDictionary*)gameData;

@end
@interface RacePlayerModel : NSObject

@property(nonatomic, strong)NSString *teamId;
@property(nonatomic, strong)NSString *playerId;

@property(nonatomic, strong)NSString *name;
@property(nonatomic, strong)NSString *minutes;
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
