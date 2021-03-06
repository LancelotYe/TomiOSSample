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
@property(nonatomic, copy)NSArray *players;
@property(nonatomic, strong)UIView *bgView;
@property(nonatomic, strong)UIView *line;
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
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableViewW, 600)];
#warning skin
        _bgView.backgroundColor = [UIColor blackColor];
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

- (UICollectionView *)playerListCollectionView{
    if(!_playerListCollectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _playerListCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(20, 0, 130, 600) collectionViewLayout:layout];
        _playerListCollectionView.backgroundColor = [UIColor clearColor];
        _playerListCollectionView.delegate = self;
        _playerListCollectionView.dataSource = self;
        [_playerListCollectionView registerClass:[RaceStatisticCCell class] forCellWithReuseIdentifier:cellId];
    }
    return _playerListCollectionView;
}
-(UICollectionView *)playerCollectionView{
    if (!_playerCollectionView) {
        _playerCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(150, 0, [UIScreen mainScreen].bounds.size.width-150, 600) collectionViewLayout:self.customLayout];
        _playerCollectionView.backgroundColor = [UIColor clearColor];
        _playerCollectionView.dataSource = self;
        _playerCollectionView.delegate = self;
        [_playerCollectionView registerClass:[RaceStatisticCCell class] forCellWithReuseIdentifier:cellId];
    }
    return _playerCollectionView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
#warning skin
        self.contentView.backgroundColor = [UIColor darkGrayColor];
        [self.contentView addSubview:self.bgView];
        [self.bgView addSubview:self.playerListCollectionView];
        [self.bgView addSubview:self.playerCollectionView];
        [self.bgView addSubview:self.line];
    }
    return self;
}
- (void)setPlayers:(NSArray *)players{
    _players = players;
    CGFloat h = self.players.count * playerCellH + playerItemH;
    self.bgView.frame = CGRectMake(0, 0, tableViewW, h);
    self.line.frame = CGRectMake(10, playerItemH, tableViewW - 20, 0.5);
    self.playerListCollectionView.frame = CGRectMake(20, 0, tableViewW/3-20, h);
    self.playerCollectionView.frame = CGRectMake(tableViewW/3, 0, tableViewW*2/3, h);
}
//构成这个cell需要两支队伍的模型数据

+(instancetype)loadCellWithPlayerModel:(RacePlayersStatisticModel *)playersModel reuseID:(NSString *)reuseID isHome:(BOOL)isHome{
    PlayerStatisticCell *cell = [[PlayerStatisticCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
    cell.playersModel = playersModel;
    cell.isHome = isHome;
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
            NSDictionary *tranDict = [StatisticModel loadTransDict];
            NSString *englishItem = self.playersModel.itemArray[column+1];
            
            NSString *chinese = [tranDict objectForKey:englishItem];
            cell.desLabel.text = chinese;
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
        if (indexPath.row == 0) {
            return (CGSize){tableViewW/3, playerItemH};
        }
        return (CGSize){tableViewW/3, playerCellH};
    }else{
        if (indexPath.row == 0) {
            return (CGSize){tableViewW/6, playerItemH};
        }
        return (CGSize){tableViewW/6, playerCellH};
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
