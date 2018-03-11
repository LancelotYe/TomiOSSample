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
#define pointCellMargin 5
#define pointCellW ([UIScreen mainScreen].bounds.size.width-7*pointCellMargin)/6
@interface TeamStatisticCell()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong)UICollectionViewFlowLayout *customLayout;
@property(nonatomic, strong)RaceTeamStatisticModel *teamAModel;
@property(nonatomic, strong)RaceTeamStatisticModel *teamBModel;
@property(nonatomic, strong)TeamIconView *iconView;
@end
@implementation TeamStatisticCell

static NSString *const cellId = @"collcellId";
static NSString *const cellIdx = @"collcellIdx";
static NSString *const headerId = @"headerId";
static NSString *const footerId = @"footerId";
- (TeamIconView *)iconView{
    if(!_iconView){
        _iconView = [[TeamIconView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
        _iconView.hostIconUrl = @"234";
        _iconView.customiconUrl = @"123";
    }
    return _iconView;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _customLayout = [[UICollectionViewFlowLayout alloc] init];
        //        _customLayout.itemSize = []
        _customLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, 400) collectionViewLayout:_customLayout];
        _collectionView.backgroundColor = [UIColor redColor];
        _collectionView.scrollEnabled = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[RaceStatisticGraphCCell class] forCellWithReuseIdentifier:cellIdx];
        [_collectionView registerClass:[RaceStatisticCCell class] forCellWithReuseIdentifier:cellId];
        
    }
    return _collectionView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.collectionView];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 35, [UIScreen mainScreen].bounds.size.width, 0.5)];
        [line setBackgroundColor:[UIColor grayColor]];
        [self.contentView addSubview:line];
    }
    return self;
}
//构成这个cell需要两支队伍的模型数据
+ (instancetype)loadCellWithTeamModelA:(RaceTeamStatisticModel *)teamModelA TeamModelB: (RaceTeamStatisticModel *)teamModelB reuseID:(NSString *)reuseID{
    TeamStatisticCell *cell = [[TeamStatisticCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
    cell.teamAModel = teamModelA;
    cell.teamBModel = teamModelB;
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
//    return  _teamAModel.teamStatisticArray.count;
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger column = indexPath.section;
    NSInteger row = indexPath.row;
    if (column!=1) {
        RaceStatisticCCell *cell = (RaceStatisticCCell *)[_collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
//        if (column == 0) {
//            cell.scoreLabel.text = [_teamAModel.teamStatisticArray[row] objectForKey:@"score"];
//        }else{
//            cell.scoreLabel.text = [_teamBModel.teamStatisticArray[row] objectForKey:@"score"];
//        }
//        cell.teamLogView.hidden = YES;
        cell.scoreLabel.hidden = NO;
        cell.desLabel.hidden = YES;
        return cell;
    }else{
        RaceStatisticGraphCCell *cell = (RaceStatisticGraphCCell *)[_collectionView dequeueReusableCellWithReuseIdentifier:cellIdx forIndexPath:indexPath];
//        cell.itemLbl.text = [_teamAModel.teamStatisticArray[row] objectForKey:@"name"];
        return cell;
    }
}


-(BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
}
#pragma mark -- UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return (CGSize){[UIScreen mainScreen].bounds.size.width*2/3,20};
    }
    return (CGSize){[UIScreen mainScreen].bounds.size.width/6, 20};
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.f;
}
//section每个row之间最小间距设定
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 30.f;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//    return (CGSize){20, 20};
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    return (CGSize){20, 20};
//}

#pragma mark -- UICollectionViewDelegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}



@end
