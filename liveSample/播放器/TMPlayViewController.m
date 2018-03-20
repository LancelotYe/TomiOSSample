//
//  TMPlayViewController.m
//  liveSample
//
//  Created by Tom on 2018/3/20.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import "TMPlayViewController.h"
#import <AVKit/AVKit.h>

@interface TMPlayViewController ()

@end

@implementation TMPlayViewController
- (NSDictionary *)loadData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"playerURL" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    return dict;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    NSDictionary *movieDict = [self loadData];
    NSString *url = [movieDict objectForKey:@"url"];
    NSLog(@"%@",url);
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:url]];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
    layer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view.layer addSublayer:layer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
