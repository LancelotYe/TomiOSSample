//
//  PlayerStatisticCell.h
//  liveSample
//
//  Created by Tom on 2018/3/7.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RacePlayersStatisticModel;
@interface PlayerStatisticCell : UITableViewCell
+(instancetype)loadCellWithPlayerModel:(RacePlayersStatisticModel *)playersModel reuseID:(NSString *)reuseID isHome:(BOOL)isHome;
@end
