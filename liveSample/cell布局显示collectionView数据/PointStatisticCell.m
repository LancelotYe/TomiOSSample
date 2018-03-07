//
//  PointStatisticCell.m
//  liveSample
//
//  Created by Tom on 2018/3/7.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import "PointStatisticCell.h"
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
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellId];

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
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _teamAModel.scoreArray.count * 3 + 3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    UILabel *label = [[UILabel alloc] initWithFrame:cell.contentView.bounds];
    label.textAlignment = NSTextAlignmentCenter;
    [cell addSubview:label];
    UILabel *scoreLbl = [[UILabel alloc] initWithFrame:cell.contentView.bounds];
    scoreLbl.textAlignment = NSTextAlignmentCenter;
    [cell addSubview:scoreLbl];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((pointCellW-20)*0.5, 0, 20, 20)];
    [cell addSubview:imageView];
    NSInteger column = floor(indexPath.row/3);
    if (indexPath.row%3==0) {
        if (column == 0) {
            label.text = @"球队";
        }else{
            NSDictionary *columnDictA = _teamAModel.scoreArray[column-1];
            label.text = [columnDictA objectForKey:@"name"];
        }
        label.hidden = NO;
    }else{
        label.hidden = YES;
    }
    
    if(indexPath.row%3==1){
        if (column==0) {
            [imageView setImage:[UIImage imageNamed:@"234"]];
            scoreLbl.hidden = YES;
            imageView.hidden = NO;
        }else{
            NSDictionary *columnDictA = _teamAModel.scoreArray[column-1];
            scoreLbl.text = [columnDictA objectForKey:@"score"];
            scoreLbl.hidden = NO;
            imageView.hidden = YES;
        }
    }else{
        if (column==0) {
            [imageView setImage:[UIImage imageNamed:@"234"]];
            scoreLbl.hidden = YES;
            imageView.hidden = NO;
        }else{
            NSDictionary *columnDictB = _teamBModel.scoreArray[column-1];
            scoreLbl.text = [columnDictB objectForKey:@"score"];
            scoreLbl.hidden = NO;
            imageView.hidden = YES;
        }
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
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return (CGSize){20, 20};
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return (CGSize){20, 20};
}

#pragma mark -- UICollectionViewDelegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}





@end
