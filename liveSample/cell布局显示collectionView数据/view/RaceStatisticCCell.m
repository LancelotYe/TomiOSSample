//
//  PointStatisticCCell.m
//  liveSample
//
//  Created by Tom on 2018/3/8.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import "RaceStatisticCCell.h"

@implementation RaceStatisticCCell

-(UILabel *)desLabel{
    if (!_desLabel) {
        _desLabel = [[UILabel alloc] init];
        _desLabel.font = [UIFont systemFontOfSize:10];
        _desLabel.textAlignment = NSTextAlignmentCenter;
#warning skin
        [_desLabel setTextColor:[UIColor grayColor]];
        _desLabel.hidden = YES;
    }
    return _desLabel;
}
- (UILabel *)scoreLabel{
    if (!_scoreLabel) {
        _scoreLabel = [[UILabel alloc] init];
        _scoreLabel.font = [UIFont systemFontOfSize:12];
        _scoreLabel.textAlignment = NSTextAlignmentCenter;
#warning skin
        [_scoreLabel setTextColor:[UIColor whiteColor]];
        _scoreLabel.hidden = YES;
        
    }
    return _scoreLabel;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.desLabel];
        [self addSubview:self.scoreLabel];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.desLabel.frame = self.contentView.bounds;
    self.scoreLabel.frame = self.contentView.bounds;
}
@end

#import "TeamStatisticLine.h"
@implementation RaceStatisticGraphCCell
- (UILabel *)itemLbl{
    if (!_itemLbl) {
        CGFloat w = self.bounds.size.width;
//        CGFloat h = self.bounds.size.height;
        _itemLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, w, 10)];
        _itemLbl.textAlignment = NSTextAlignmentCenter;
        _itemLbl.font = [UIFont systemFontOfSize:10];
#warning skin
        [_itemLbl setTextColor:[UIColor lightGrayColor]];
    }
    return _itemLbl;
}
- (TeamStatisticLine *)graphicLine{
    if (!_graphicLine){
        CGFloat w = self.bounds.size.width;
        _graphicLine = [TeamStatisticLine loadTeamStatisticLineWithFrame:CGRectMake(0, 25.5, w, 2)];
    }
    return _graphicLine;
}


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.itemLbl];
        [self addSubview:self.graphicLine];
    }
    return self;
}
- (void)setHomeItemScore:(CGFloat)homeItemScore VisitorItemScore:(CGFloat)visItemScore{
    _homeItemScore = homeItemScore;
    _visitorItemScore = visItemScore;
    [self.graphicLine setHomeItemScore:_homeItemScore VisitorItemScore:_visitorItemScore];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}
@end
