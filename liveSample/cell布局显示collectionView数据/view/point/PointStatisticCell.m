//
//  PointStatisticCell.m
//  liveSample
//
//  Created by Tom on 2018/3/7.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import "PointStatisticCell.h"
#import "RaceStatisticCCell.h"
#import "RaceStateModel.h"
#define pointCellMargin 5
#define pointCellW ([UIScreen mainScreen].bounds.size.width-7*pointCellMargin)/6
@interface PointStatisticCell()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong)UICollectionViewFlowLayout *customLayout;
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)RacePointStatisticModel *teamAModel;
@property(nonatomic, strong)RacePointStatisticModel *teamBModel;
@end
@implementation PointStatisticCell

static NSString *const cellId = @"collcellId";
static NSString *const headerId = @"headerId";
static NSString *const footerId = @"footerId";
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _customLayout = [[UICollectionViewFlowLayout alloc] init];
        //        _customLayout.itemSize = []
        _customLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100) collectionViewLayout:_customLayout];
        _collectionView.backgroundColor = [UIColor redColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[RaceStatisticCCell class] forCellWithReuseIdentifier:cellId];

    }
    return _collectionView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _dataArray = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4", nil];
        [self.contentView addSubview:self.collectionView];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 35, [UIScreen mainScreen].bounds.size.width - 20, 0.5)];
        [line setBackgroundColor:[UIColor grayColor]];
        [self.contentView addSubview:line];
    }
    return self;
}
//构成这个cell需要两支队伍的模型数据
+ (instancetype)loadCellWithTeamModelA:(RacePointStatisticModel *)teamModelA TeamModelB: (RacePointStatisticModel *)teamModelB reuseID:(NSString *)reuseID{
    PointStatisticCell *cell = [[PointStatisticCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
    cell.teamAModel = teamModelA;
    cell.teamBModel = teamModelB;
    return cell;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _teamAModel.scoreArray.count + 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RaceStatisticCCell *cell = (RaceStatisticCCell *)[_collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
//    UILabel *label = [[UILabel alloc] initWithFrame:cell.contentView.bounds];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.hidden = YES;
//    [cell addSubview:label];
//    UILabel *scoreLbl = [[UILabel alloc] initWithFrame:cell.contentView.bounds];
//    scoreLbl.textAlignment = NSTextAlignmentCenter;
//    scoreLbl.hidden = YES;
//    [cell addSubview:scoreLbl];
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((pointCellW-20)*0.5, 0, 20, 20)];
//    imageView.hidden = YES;
//    [cell addSubview:imageView];
    NSInteger column = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (row==0 && column==0) {
        cell.desLabel.text = @"球队";
        cell.desLabel.hidden = NO;
        cell.teamLogView.hidden = YES;
        cell.scoreLabel.hidden = YES;
    }else if (row==0 && column>0){
        NSDictionary *columnDictA = _teamAModel.scoreArray[column-1];
        cell.desLabel.text = [columnDictA objectForKey:@"name"];
        cell.desLabel.hidden = NO;
        cell.teamLogView.hidden = YES;
        cell.scoreLabel.hidden = YES;
    }else if (row>0 && column==0){
        if (row == 1) {
            [cell.teamLogView setImage:[UIImage imageNamed:@"234"]];
        }else if (row ==2){
            [cell.teamLogView setImage:[UIImage imageNamed:@"234"]];
        }
        cell.teamLogView.hidden = NO;
        cell.desLabel.hidden = YES;
        cell.scoreLabel.hidden = YES;
    }else{
        NSDictionary *columnDictA = _teamAModel.scoreArray[column-1];
        NSDictionary *columnDictB = _teamBModel.scoreArray[column-1];
        cell.scoreLabel.text = row==1?[columnDictA objectForKey:@"score"]:[columnDictB objectForKey:@"score"];
        cell.scoreLabel.hidden = NO;
        cell.teamLogView.hidden = YES;
        cell.desLabel.hidden = YES;
    
    }
    return cell;
}


-(BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
}
#pragma mark -- UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return (CGSize){pointCellW, 20};
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(pointCellMargin, pointCellMargin, pointCellMargin, pointCellMargin);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5.f;
}
//每个section之间最小间距设定
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5.f;
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
