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
//球队名称
@property(nonatomic, strong)NSString *teamName;
//model类型
@property(nonatomic, assign)raceModelKind kind;
+ (instancetype)loadModelWithDict:(NSDictionary *)dict;

@end



@interface RacePointStatisticModel: RaceStateModel
//每节分数数组
@property(nonatomic, strong)NSArray *scoreArray;
+ (instancetype)loadModelWithDict:(NSDictionary *)dict;
@end



@interface RaceTeamStatisticModel : RaceStateModel
@property(nonatomic, strong)NSArray *teamStatisticArray;
////篮板
//@property(nonatomic, strong)NSString *backboardNum;
////助攻
//@property(nonatomic, strong)NSString *assistingNum;
////抢断
//@property(nonatomic, strong)NSString *interceptNum;
////盖帽
//@property(nonatomic, strong)NSString *blockNum;
////失误
//@property(nonatomic, strong)NSString *faultNum;
////罚球
//@property(nonatomic, strong)NSString *penaltyShotNum;
////三分
//@property(nonatomic, strong)NSString *threePointNum;
////犯规
//@property(nonatomic, strong)NSString *foulNum;
////参数数量
//@property(nonatomic, assign)NSInteger paramNum;

+ (instancetype)loadModelWithDict:(NSDictionary *)dict;
@end




@interface RacePlayersStatisticModel :RaceStateModel
@property(nonatomic, strong)NSArray *players;
+ (instancetype)loadModelWithDict:(NSDictionary *)dict;

@end
@interface RacePlayerModel : NSObject
//球员
@property(nonatomic, strong)NSString *playerName;
//得分
@property(nonatomic, strong)NSString *point;
//篮板
@property(nonatomic, strong)NSString *backboardNum;
//助攻
@property(nonatomic, strong)NSString *assistingNum;
//投篮
@property(nonatomic, strong)NSString *shotNum;
//三分
@property(nonatomic, strong)NSString *threePointNum;
//罚球
@property(nonatomic, strong)NSString *penaltyShotNum;
//抢断
@property(nonatomic, strong)NSString *interceptNum;
//盖帽
@property(nonatomic, strong)NSString *blockNum;
//失误
@property(nonatomic, strong)NSString *faultNum;
//犯规
@property(nonatomic, strong)NSString *foulNum;
+ (instancetype)loadModelWithDict:(NSDictionary *)dict;
@end
