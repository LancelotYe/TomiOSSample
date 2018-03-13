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
#define tableViewW ([UIScreen mainScreen].bounds.size.width-17)
@interface PlayerStatisticCell()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong)UICollectionView *playerCollectionView;
@property(nonatomic, strong)UICollectionView *playerListCollectionView;
@property(nonatomic, strong)UICollectionViewFlowLayout *customLayout;
@property(nonatomic, strong)RacePlayersStatisticModel *playersModel;
@property(nonatomic, copy)NSArray *players;
//@property(nonatomic, strong)NSArray *itemArray;
@property(nonatomic, assign)BOOL isHome;
@end
@implementation PlayerStatisticCell

static NSString *const cellId = @"playcellId";

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
        _playerListCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 150, 600) collectionViewLayout:layout];
        _playerListCollectionView.backgroundColor = [UIColor greenColor];
        _playerListCollectionView.delegate = self;
        _playerListCollectionView.dataSource = self;
        [_playerListCollectionView registerClass:[RaceStatisticCCell class] forCellWithReuseIdentifier:cellId];
    }
    return _playerListCollectionView;
}
-(UICollectionView *)playerCollectionView{
    if (!_playerCollectionView) {
        _playerCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(150, 0, [UIScreen mainScreen].bounds.size.width-150, 600) collectionViewLayout:self.customLayout];
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
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 25, [UIScreen mainScreen].bounds.size.width - 20, 0.5)];
        [line setBackgroundColor:[UIColor grayColor]];
        [self.contentView addSubview:line];
    }
    return self;
}
- (void)setPlayers:(NSArray *)players{
    _players = players;
    CGFloat h = (self.players.count+1) * 20;
    self.playerListCollectionView.frame = CGRectMake(0, 0, tableViewW/3, h);
    self.playerCollectionView.frame = CGRectMake(tableViewW/3, 0, tableViewW*2/3, h);
}
//构成这个cell需要两支队伍的模型数据

+(instancetype)loadCellWithPlayerModel:(RacePlayersStatisticModel *)playersModel reuseID:(NSString *)reuseID isHome:(BOOL)isHome{
    PlayerStatisticCell *cell = [[PlayerStatisticCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
    cell.playersModel = playersModel;
    cell.isHome = isHome;
    
    for (RacePlayerModel *dic in playersModel.visitorPlayers) {
        NSLog(@"%@",dic.name);
    }
    if (isHome) {
        cell.players = playersModel.homePlayers;
        
    }else{
        cell.players = playersModel.visitorPlayers;
    }
    return cell;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if(collectionView == _playerListCollectionView){
        return 1;
    }
    return self.playersModel.itemNum-1;
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_isHome) {
        return _playersModel.homePlayers.count+1;
    }else{
        return _playersModel.visitorPlayers.count+1;
    }
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger column = indexPath.section;
    NSInteger row = indexPath.row;
    RaceStatisticCCell *cell = nil;
    if (collectionView == _playerListCollectionView) {
        cell = (RaceStatisticCCell *)[_playerListCollectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
        cell.desLabel.textAlignment = NSTextAlignmentLeft;
        cell.scoreLabel.textAlignment = NSTextAlignmentLeft;
    }else{
        cell = (RaceStatisticCCell *)[_playerCollectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    }
    if(collectionView == _playerListCollectionView){
        if(row == 0){
            cell.desLabel.text = @"球员";
            cell.desLabel.hidden = NO;
            cell.scoreLabel.hidden = YES;
        }else{
            RacePlayerModel *player = self.players[row-1];
            cell.scoreLabel.text = [player valueForKey:self.playersModel.itemArray[0]];
            cell.scoreLabel.hidden = NO;
            cell.desLabel.hidden = YES;
        }
    }else{
        if(row == 0){
            cell.desLabel.text = self.playersModel.itemArray[column+1];
            cell.desLabel.hidden = NO;
            cell.scoreLabel.hidden = YES;
        }else{
            RacePlayerModel *player = self.players[row-1];
            NSString *playerKey = self.playersModel.itemArray[column+1];
            cell.scoreLabel.text = [player valueForKey:playerKey];
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
    if (collectionView == _playerListCollectionView) {
        return (CGSize){150, 20};
    }else{
        return (CGSize){70, 20};
    }
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
