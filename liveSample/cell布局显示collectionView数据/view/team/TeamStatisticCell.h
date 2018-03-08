//
//  TeamStatisticCell.h
//  liveSample
//
//  Created by Tom on 2018/3/7.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RaceTeamStatisticModel;
@interface TeamStatisticCell : UITableViewCell
+ (instancetype)loadCellWithTeamModelA:(RaceTeamStatisticModel *)teamModelA TeamModelB: (RaceTeamStatisticModel *)teamModelB reuseID:(NSString *)reuseID;
@end
