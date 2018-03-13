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
        _desLabel.hidden = YES;
    }
    return _desLabel;
}
- (UILabel *)scoreLabel{
    if (!_scoreLabel) {
        _scoreLabel = [[UILabel alloc] init];
        _scoreLabel.textAlignment = NSTextAlignmentCenter;
        _scoreLabel.hidden = YES;
    }
    return _scoreLabel;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
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


@implementation RaceStatisticGraphCCell
- (UILabel *)itemLbl{
    if (!_itemLbl) {
        CGFloat w = self.bounds.size.width;
        CGFloat h = self.bounds.size.height;
        _itemLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, w, h*0.7)];
        _itemLbl.textAlignment = NSTextAlignmentCenter;
    }
    return _itemLbl;
}
- (UIView *)graphicLine{
    if (!_graphicLine) {
        CGFloat w = self.bounds.size.width;
        CGFloat h = self.bounds.size.height;
        _graphicLine = [[UIView alloc] initWithFrame:CGRectMake(0, h*0.8, w, 10)];
        [_graphicLine setBackgroundColor:[UIColor blueColor]];
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

@end
