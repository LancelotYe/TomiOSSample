//
//  SpeechGetViewController.m
//  liveSample
//
//  Created by Tom on 2018/3/16.
//  Copyright © 2018年 Tom. All rights reserved.
//

#import "SpeechGetViewController.h"
#import <Speech/Speech.h>


@interface SpeechGetViewController ()

@end

@implementation SpeechGetViewController

- (void)viewDidLoad {
//    http://blog.csdn.net/luciosui/article/details/52621395
    [super viewDidLoad];
    NSLocale *local = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    SFSpeechRecognizer *sf = [[SFSpeechRecognizer alloc] initWithLocale:local];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"" withExtension:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
