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
//#define tableViewW ([UIScreen mainScreen].bounds.size.width-26)

#define collectionViewW (tableViewW-pointIconW)
@interface PointStatisticCell()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong)UICollectionView *pointCollectionView;
@property(nonatomic, strong)UICollectionViewFlowLayout *customLayout;
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)RacePointsStatisticModel *pointsModel;
@property(nonatomic, strong)PointIconView *iconView;
@end
@implementation PointStatisticCell

static NSString *const cellId = @"collcellId";
-(UICollectionView *)collectionView{
    if (!_pointCollectionView) {
        _customLayout = [[UICollectionViewFlowLayout alloc] init];
        _customLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _pointCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(pointIconW, 0, collectionViewW, 100) collectionViewLayout:_customLayout];
        _pointCollectionView.backgroundColor = [UIColor redColor];
        _pointCollectionView.dataSource = self;
        _pointCollectionView.delegate = self;
        [_pointCollectionView registerClass:[RaceStatisticCCell class] forCellWithReuseIdentifier:cellId];
    }
    return _pointCollectionView;
}
- (PointIconView *)iconView{
    if(!_iconView){
        _iconView = [PointIconView loadPointIconView];
    }
    return _iconView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor darkGrayColor];
        [self.contentView addSubview:self.collectionView];
        [self.contentView addSubview:self.iconView];
        _iconView.homeIconUrl = @"234";
        _iconView.visitorIconUrl = @"123";
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, pointItemH, tableViewW - 40, 0.5)];
        [line setBackgroundColor:[UIColor grayColor]];
        [self.contentView addSubview:line];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.iconView.frame = CGRectMake(0, 0, pointIconW, self.pointsModel.cellH);
    self.pointCollectionView.frame = CGRectMake(pointIconW, 0, collectionViewW, self.pointsModel.cellH);
}
//构成这个cell需要两支队伍的模型数据
+(instancetype)loadCellWithPointsModel:(RacePointsStatisticModel *)pointsModel reuseID:(NSString *)reuseID{
    PointStatisticCell *cell = [[PointStatisticCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
    cell.pointsModel = pointsModel;
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.pointsModel.itemTypeAray.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RaceStatisticCCell *cell = (RaceStatisticCCell *)[_pointCollectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    NSInteger column = indexPath.section;
    NSInteger row = indexPath.row;
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"transNBA" ofType:@"json"];
//    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSDictionary *tranDict = [StatisticModel loadTransDict];
    RacePointsStatisticModel *model = self.pointsModel;
    if (row == 0) {
        NSString *titleKey = model.itemTypeAray[column];
        cell.desLabel.text = [tranDict objectForKey:titleKey];
        cell.desLabel.hidden = NO;
        cell.scoreLabel.hidden = YES;
    }else{
        //row==1主队
        RacePointStatisticModel *modelX = row==1?model.homePointModel:model.visitorPointModel;
        NSString *pointKey = model.itemTypeAray[column];
        NSString *scoreText = nil;
        if ([pointKey isEqualToString:@"总分"]){
            scoreText = [modelX valueForKey:row==1?@"Home_score":@"Visitor_score"];
        }
        else{
            scoreText = [modelX valueForKey:pointKey];
        }
        cell.scoreLabel.text = scoreText;
        cell.scoreLabel.hidden = NO;
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
    if (indexPath.row == 0) {
        return (CGSize){collectionViewW/5, pointItemH};
    }
    return (CGSize){collectionViewW/5, pointCellH};
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.f;
}
//每个section之间最小间距设定
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.f;
}


#pragma mark -- UICollectionViewDelegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}





@end
