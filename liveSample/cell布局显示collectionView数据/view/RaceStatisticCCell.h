//
//  RaceStatisticCCell.h
//  liveSample
//
//  Created by Tom on 2018/3/8.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RaceStatisticCCell : UICollectionViewCell
@property(nonatomic, strong)UILabel *desLabel;
@property(nonatomic, strong)UILabel *scoreLabel;
@end
@class TeamStatisticLine;
@interface RaceStatisticGraphCCell : UICollectionViewCell
@property(nonatomic,assign)CGFloat homeItemScore;
@property(nonatomic,assign)CGFloat visitorItemScore;
- (void)setHomeItemScore:(CGFloat)homeItemScore VisitorItemScore:(CGFloat)visItemScore;
@property(nonatomic, strong)UILabel *itemLbl;
@property(nonatomic, strong)TeamStatisticLine *graphicLine;
@end
