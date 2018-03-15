//
//  TMCurtainView.m
//  liveSample
//
//  Created by Tom on 2018/3/13.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import "TMCurtainView.h"
#import "RaceStateCell.h"
#import "PointStatisticCell.h"
#import "TeamStatisticCell.h"
#import "PlayerStatisticCell.h"
//#define curtainSwitchW 26
//#define curtainSwitchH 100
//#define curtainW [UIScreen mainScreen].bounds.size.width
@interface TMCurtainView()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)UIView *contentView;
@property(nonatomic, strong)RaceStateModel *stateModel;
@end
@implementation TMCurtainView
static NSString *pointID = @"pointID";
static NSString *teamID = @"teamID";
static NSString *homePlayerID = @"homePlayerID";
static NSString *visitorPlayerID = @"visitorPlayerID";
- (void)loadData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"teamInfo" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSDictionary *teamsData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    path = [[NSBundle mainBundle] pathForResource:@"gameInfo" ofType:@"json"];
    NSData *dataa = [[NSData alloc] initWithContentsOfFile:path];
    NSDictionary *gameData = [NSJSONSerialization JSONObjectWithData:dataa options:NSJSONReadingMutableLeaves error:nil];
    self.stateModel = [RaceStateModel loadModelWithTeamData:teamsData GameData:gameData];
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.contentView.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}
-(UIButton *)curtainSwitch{
    if (!_curtainSwitch) {
        _curtainSwitch = [[UIButton alloc] init];
        [_curtainSwitch setBackgroundImage:[UIImage imageNamed:@"moreData.png"] forState:UIControlStateNormal];
        [_curtainSwitch addTarget:self action:@selector(curtainSwitchClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _curtainSwitch;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadData];
        [self addSubview:self.contentView];
        [self addSubview:self.curtainSwitch];
        [self.contentView addSubview:self.tableView];
    }
    return self;
}
+ (instancetype)loadCurtainViewOnBaseView:(UIView *)baseView{
    CGRect frame = baseView.frame;
    CGFloat curtainY = frame.origin.y;
    CGFloat curtainX = curtainW - curtainSwitchW;
    CGFloat curtainH = frame.size.height;
    TMCurtainView *curtainView = [[TMCurtainView alloc] initWithFrame:CGRectMake(curtainX, curtainY, curtainW, curtainH)];
    return curtainView;
}
- (void)curtainSwitchClick:(UIButton *)sender{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.frame;
        if (frame.origin.x == 0) {
            frame.origin.x = curtainW - curtainSwitchW;
        }else{
            frame.origin.x = 0;
        }
        self.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 50)];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 18, self.tableView.bounds.size.width, 12)];
    label.font = [UIFont systemFontOfSize:15];
#warning skin
    view.backgroundColor = [UIColor blackColor];
    [label setTextColor:[UIColor whiteColor]];
    [view addSubview:label];
    switch (section) {
        case 0:{
            label.text = @"赛况";
            break;
        }
        case 1:{
            label.text = @"球队统计";
            break;
        }
        case 2:{
            label.text = [NSString stringWithFormat:@"球员统计-%@",self.stateModel.homeName];
            break;
        }
        case 3:{
            label.text = [NSString stringWithFormat:@"球员统计-%@",self.stateModel.visitorName];
            break;
        }
        default:
            break;
    }
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return self.stateModel.pointsModel.cellH+8;
    }else if (indexPath.section == 1){
        return self.stateModel.teamsModel.cellH+8;
    }else if(indexPath.section == 2){
        return self.stateModel.playersModel.homePlayers.count * playerCellH + playerItemH + 8;
    }else if(indexPath.section == 3){
        return self.stateModel.playersModel.visitorPlayers.count * playerCellH + playerItemH + 8;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0){
        PointStatisticCell *cell = [tableView dequeueReusableCellWithIdentifier:pointID];
        if (!cell) {
            cell = [PointStatisticCell loadCellWithPointsModel:self.stateModel.pointsModel reuseID:pointID];
        }
        return cell;
    }else if(indexPath.section == 1){
        TeamStatisticCell *cell = [tableView dequeueReusableCellWithIdentifier:teamID];
        if (!cell) {
            cell = [TeamStatisticCell loadCellWithTeamsModel:self.stateModel.teamsModel reuseID:teamID];
        }
        return cell;
    }else if(indexPath.section == 2){
        PlayerStatisticCell *cell = [tableView dequeueReusableCellWithIdentifier:homePlayerID];
        if (!cell) {
            cell = [PlayerStatisticCell loadCellWithPlayerModel:self.stateModel.playersModel reuseID:homePlayerID isHome:YES];
        }
        return cell;
    }else if (indexPath.section == 3){
        PlayerStatisticCell *cell = [tableView dequeueReusableCellWithIdentifier:visitorPlayerID];
        if (!cell) {
            cell = [PlayerStatisticCell loadCellWithPlayerModel:self.stateModel.playersModel reuseID:visitorPlayerID isHome:NO];
        }
        return cell;
    }
    else{
        return nil;
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect frame = self.bounds;
    self.curtainSwitch.frame = CGRectMake(0, 100, curtainSwitchW, curtainSwitchH);
    self.contentView.frame = CGRectMake(curtainSwitchW, 0, frame.size.width-curtainSwitchW, frame.size.height);
    self.tableView.frame = self.contentView.bounds;
}
@end
