//
//  TeamStatisticCell.m
//  liveSample
//
//  Created by Tom on 2018/3/7.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import "TeamStatisticCell.h"
#import "RaceStateModel.h"
#import "RaceStatisticCCell.h"
#import "TeamIconView.h"

//#define pointCellW ([UIScreen mainScreen].bounds.size.width-7*pointCellMargin)/6
//#define tableViewW ([UIScreen mainScreen].bounds.size.width-26)
@interface TeamStatisticCell()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong)UICollectionViewFlowLayout *customLayout;

@property(nonatomic, strong)RaceTeamsStatisticModel *teamsModel;
@property(nonatomic, strong)TeamIconView *iconView;
@property(nonatomic, strong)UIView *bgView;
@property(nonatomic, strong)UIView *line;
@end
@implementation TeamStatisticCell

static NSString *const cellId = @"collcellId";
static NSString *const cellIdx = @"collcellIdx";
static NSString *const headerId = @"headerId";
static NSString *const footerId = @"footerId";
- (TeamIconView *)iconView{
    if(!_iconView){
        _iconView = [[TeamIconView alloc] initWithFrame:CGRectMake(0, 0, tableViewW, teamIconH)];
        _iconView.homeIconUrl = @"234";
        _iconView.visitorIconUrl = @"123";
    }
    return _iconView;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _customLayout = [[UICollectionViewFlowLayout alloc] init];
        //        _customLayout.itemSize = []
        _customLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, teamIconH, tableViewW, 300) collectionViewLayout:_customLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.scrollEnabled = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[RaceStatisticGraphCCell class] forCellWithReuseIdentifier:cellIdx];
        [_collectionView registerClass:[RaceStatisticCCell class] forCellWithReuseIdentifier:cellId];
        
    }
    return _collectionView;
}
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
#warning skin
        [_bgView setBackgroundColor:[UIColor blackColor]];
    }
    return _bgView;
}
- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
#warning skin
        [_line setBackgroundColor:[UIColor whiteColor]];
    }
    return _line;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor darkGrayColor];
        [self.contentView addSubview:self.bgView];
        [self.bgView addSubview:self.iconView];
        [self.bgView addSubview:self.collectionView];
        [self.bgView addSubview:self.line];
    }
    return self;
}
//构成这个cell需要两支队伍的模型数据

+ (instancetype)loadCellWithTeamsModel:(RaceTeamsStatisticModel *)teamsModel reuseID:(NSString *)reuseID{
    TeamStatisticCell *cell = [[TeamStatisticCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
    cell.teamsModel = teamsModel;
    return cell;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.teamsModel.itemNum;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger column = indexPath.section;
    NSInteger row = indexPath.row;
    if (column!=1) {
        RaceStatisticCCell *cell = (RaceStatisticCCell *)[_collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
        NSString *itemKey = self.teamsModel.itemTypeArray[row];
        RaceTeamStatisticModel *model = column==0?self.teamsModel.homeTeamModel:self.teamsModel.visitorTeamModel;
        cell.scoreLabel.text = [model valueForKey:itemKey];
        cell.scoreLabel.hidden = NO;
        cell.desLabel.hidden = YES;
        return cell;
    }else{
        RaceStatisticGraphCCell *cell = (RaceStatisticGraphCCell *)[_collectionView dequeueReusableCellWithReuseIdentifier:cellIdx forIndexPath:indexPath];
        NSDictionary *transDict = [StatisticModel loadTransDict];
        NSString *englishName = self.teamsModel.itemTypeArray[row];
        NSString *chinese = [transDict objectForKey:englishName];
        cell.itemLbl.text = chinese;
        NSString *itemKey = self.teamsModel.itemTypeArray[row];
        RaceTeamStatisticModel *homeModel = self.teamsModel.homeTeamModel;
        RaceTeamStatisticModel *visitorModel = self.teamsModel.visitorTeamModel;
        CGFloat homeValue = [[homeModel valueForKey:itemKey] floatValue];
        CGFloat visitorValue = [[visitorModel valueForKey:itemKey] floatValue];
        [cell setHomeItemScore:homeValue VisitorItemScore:visitorValue];
        return cell;
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    _bgView.frame = CGRectMake(0, 0, tableViewW, self.teamsModel.cellH);
    _line.frame = CGRectMake(20, teamIconH-1, tableViewW-40, 0.5);
    _iconView.frame = CGRectMake(0, 0, tableViewW, teamIconH);
    _collectionView.frame = CGRectMake(0, teamIconH, tableViewW, self.teamsModel.cellH-teamIconH);
}

-(BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
}
#pragma mark -- UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return (CGSize){tableViewW*2/3,teamCellH};
    }
    return (CGSize){tableViewW/6, teamCellH};
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.f;
}
//section每个row之间最小间距设定
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

#pragma mark -- UICollectionViewDelegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}



@end
