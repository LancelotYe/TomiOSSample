//
//  TeamStatisticCell.h
//  liveSample
//
//  Created by Tom on 2018/3/7.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RaceTeamStatisticModel;
@class RaceTeamsStatisticModel;
@interface TeamStatisticCell : UITableViewCell
+ (instancetype)loadCellWithTeamModelA:(RaceTeamStatisticModel *)teamModelA TeamModelB: (RaceTeamStatisticModel *)teamModelB reuseID:(NSString *)reuseID;

+ (instancetype)loadCellWithTeamsModel:(RaceTeamsStatisticModel *)teamsModel reuseID:(NSString *)reuseID;
@end
