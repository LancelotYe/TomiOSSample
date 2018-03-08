//
//  RaceStatisticCCell.h
//  liveSample
//
//  Created by Tom on 2018/3/8.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RaceStatisticCCell : UICollectionViewCell
@property(nonatomic, strong)UIImageView *teamLogView;
@property(nonatomic, strong)UILabel *desLabel;
@property(nonatomic, strong)UILabel *scoreLabel;
@end
@interface RaceStatisticGraphCCell : UICollectionViewCell
@property(nonatomic, strong)UILabel *itemLbl;
@property(nonatomic, strong)UIView *graphicLine;
@end
