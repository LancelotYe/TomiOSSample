//
//  PointStatisticCell.h
//  liveSample
//
//  Created by Tom on 2018/3/7.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RacePointStatisticModel;
@class RacePointsStatisticModel;
@interface PointStatisticCell : UITableViewCell
+ (instancetype)loadCellWithTeamModelA:(RacePointStatisticModel *)teamModelA TeamModelB: (RacePointStatisticModel *)teamModelB reuseID:(NSString *)reuseID;

+ (instancetype)loadCellWithPointsModel:(RacePointsStatisticModel *)pointsModel reuseID:(NSString *)reuseID;
@end
