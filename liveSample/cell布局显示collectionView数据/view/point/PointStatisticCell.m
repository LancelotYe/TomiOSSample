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
#import "PointIconView.h"
#define pointCellMargin 5
#define pointCellW ([UIScreen mainScreen].bounds.size.width-7*pointCellMargin)/6
@interface PointStatisticCell()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong)UICollectionView *pointCollectionView;
@property(nonatomic, strong)UICollectionViewFlowLayout *customLayout;
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)RacePointStatisticModel *vistorPointModel;
@property(nonatomic, strong)RacePointStatisticModel *homePointModel;
@property(nonatomic, strong)PointIconView *iconView;
@end
@implementation PointStatisticCell

static NSString *const cellId = @"collcellId";
-(UICollectionView *)collectionView{
    if (!_pointCollectionView) {
        _customLayout = [[UICollectionViewFlowLayout alloc] init];
        //        _customLayout.itemSize = []
        _customLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _pointCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(70, 0, [UIScreen mainScreen].bounds.size.width-70, 100) collectionViewLayout:_customLayout];
        _pointCollectionView.backgroundColor = [UIColor redColor];
        _pointCollectionView.dataSource = self;
        _pointCollectionView.delegate = self;
        [_pointCollectionView registerClass:[RaceStatisticCCell class] forCellWithReuseIdentifier:cellId];
    }
    return _pointCollectionView;
}
- (PointIconView *)iconView{
    if(!_iconView){
        _iconView = [[PointIconView alloc] initWithFrame:CGRectMake(0, 0, 70, 100)];
    }
    return _iconView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _dataArray = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4", nil];
        [self.contentView addSubview:self.collectionView];
        [self.contentView addSubview:self.iconView];
        _iconView.hostIconUrl = @"234";
        _iconView.customiconUrl = @"123";
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 35, [UIScreen mainScreen].bounds.size.width - 20, 0.5)];
        [line setBackgroundColor:[UIColor grayColor]];
        [self.contentView addSubview:line];
    }
    return self;
}
//构成这个cell需要两支队伍的模型数据
+ (instancetype)loadCellWithTeamModelA:(RacePointStatisticModel *)teamModelA TeamModelB: (RacePointStatisticModel *)teamModelB reuseID:(NSString *)reuseID{
    PointStatisticCell *cell = [[PointStatisticCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
    
//    cell.teamAModel = teamModelA;
//    cell.teamBModel = teamModelB;
    
    return cell;
}
+(instancetype)loadCellWithPointsModel:(RacePointsStatisticModel *)pointsModel reuseID:(NSString *)reuseID{
    PointStatisticCell *cell = [[PointStatisticCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
//    cell.homePointModel =  pointsModel.pointStatisticArray[]
//    cell.pointsModel  = pointsModel;
    
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 4;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RaceStatisticCCell *cell = (RaceStatisticCCell *)[_pointCollectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    NSInteger column = indexPath.section;
    NSInteger row = indexPath.row;
//    if (row==0){
//        NSDictionary *columnDictA = _teamAModel.scoreArray[column];
//        cell.desLabel.text = [columnDictA objectForKey:@"name"];
//        cell.desLabel.hidden = NO;
//        cell.scoreLabel.hidden = YES;
//    }else{
//        NSDictionary *columnDictA = _teamAModel.scoreArray[column];
//        NSDictionary *columnDictB = _teamBModel.scoreArray[column];
//        cell.scoreLabel.text = row==1?[columnDictA objectForKey:@"score"]:[columnDictB objectForKey:@"score"];
//        cell.scoreLabel.hidden = NO;
//        cell.desLabel.hidden = YES;
//    
//    }
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


#pragma mark -- UICollectionViewDelegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}





@end
