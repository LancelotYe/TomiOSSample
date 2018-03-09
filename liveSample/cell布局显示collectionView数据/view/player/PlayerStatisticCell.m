//
//  PlayerStatisticCell.m
//  liveSample
//
//  Created by Tom on 2018/3/7.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import "PlayerStatisticCell.h"
#import "RaceStateModel.h"
#import "RaceStatisticCCell.h"
@interface PlayerStatisticCell()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong)UICollectionView *playerCollectionView;
@property(nonatomic, strong)UICollectionView *playerListCollectionView;
@property(nonatomic, strong)UICollectionViewFlowLayout *customLayout;
@property(nonatomic, strong)RacePlayersStatisticModel *playersModel;
@property(nonatomic, strong)NSArray *itemArray;
@end
@implementation PlayerStatisticCell

static NSString *const cellId = @"playcellId";
static NSString *const listCellId = @"playListCellId";
-(NSArray *)itemArray{
    return [NSArray arrayWithObjects:@"首发",@"得分",@"篮板",@"助攻",@"投篮",@"三分",@"罚球",@"抢断",@"盖帽",@"失误",@"犯规",nil];
}
- (UICollectionViewFlowLayout *)customLayout{
    if(!_customLayout){
        _customLayout = [[UICollectionViewFlowLayout alloc] init];
        //        _customLayout.itemSize = []
        _customLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _customLayout;
}
- (UICollectionView *)playerListCollectionView{
    if(!_playerListCollectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _playerListCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 70, 600) collectionViewLayout:layout];
        _playerListCollectionView.backgroundColor = [UIColor greenColor];
        _playerListCollectionView.delegate = self;
        _playerListCollectionView.dataSource = self;
        [_playerListCollectionView registerClass:[RaceStatisticCCell class] forCellWithReuseIdentifier:cellId];
    }
    return _playerListCollectionView;
}
-(UICollectionView *)playerCollectionView{
    if (!_playerCollectionView) {
        _playerCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(70, 0, [UIScreen mainScreen].bounds.size.width-70, 600) collectionViewLayout:self.customLayout];
        _playerCollectionView.backgroundColor = [UIColor redColor];
        _playerCollectionView.dataSource = self;
        _playerCollectionView.delegate = self;
        [_playerCollectionView registerClass:[RaceStatisticCCell class] forCellWithReuseIdentifier:cellId];
    }
    return _playerCollectionView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.playerListCollectionView];
        [self.contentView addSubview:self.playerCollectionView];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 35, [UIScreen mainScreen].bounds.size.width - 20, 0.5)];
        [line setBackgroundColor:[UIColor grayColor]];
        [self.contentView addSubview:line];
    }
    return self;
}
//构成这个cell需要两支队伍的模型数据

+(instancetype)loadCellWithPlayerModel:(RacePlayersStatisticModel *)playersModel reuseID:(NSString *)reuseID{
    PlayerStatisticCell *cell = [[PlayerStatisticCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
    cell.playersModel = playersModel;
    return cell;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if(collectionView == _playerListCollectionView){
        return 1;
    }
    return self.itemArray.count;
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _playersModel.players.count + 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RaceStatisticCCell *cell = (RaceStatisticCCell *)[_playerCollectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    NSInteger column = indexPath.section;
    NSInteger row = indexPath.row;
    
    if(collectionView == _playerListCollectionView){
        if(row == 0){
            cell.desLabel.text = @"球员";
            cell.desLabel.hidden = NO;
            cell.scoreLabel.hidden = YES;
        }else{
            RacePlayerModel *player = _playersModel.players[row-1];
            cell.scoreLabel.text = player.playerName;
            cell.scoreLabel.hidden = NO;
            cell.desLabel.hidden = YES;
        }
    }else{
        if(row == 0){
            cell.desLabel.text = self.itemArray[column];
            cell.desLabel.hidden = NO;
            cell.scoreLabel.hidden = YES;
        }else{
            cell.scoreLabel.text = @"123";
            cell.scoreLabel.hidden = NO;
            cell.desLabel.hidden = YES;
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
    return (CGSize){70, 20};
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 0, 0, 0);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5.f;
}
//每个section之间最小间距设定
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 30.f;
}


#pragma mark -- UICollectionViewDelegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}



@end
