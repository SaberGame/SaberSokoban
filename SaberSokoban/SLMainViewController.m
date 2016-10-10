//
//  SLMainViewController.m
//  SaberSokoban
//
//  Created by songlong on 16/6/16.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import "SLMainViewController.h"
#import "SLSelectViewController.h"
#import "SLChallengeViewController.h"
#import "Masonry.h"

#define kHeight [UIScreen mainScreen].bounds.size.height
#define kWidth  [UIScreen mainScreen].bounds.size.width

@interface SLMainViewController ()

@end

@implementation SLMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self setupUI];
    
}

- (void)setupUI {

    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectZero];
    [button1 setTitle:@"选关模式" forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont systemFontOfSize:20];
    button1.layer.cornerRadius = 10;
    button1.backgroundColor = [UIColor blueColor];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(clickButton1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_centerY).offset(-50);
        make.width.mas_equalTo(kWidth / 2);
        make.height.mas_equalTo(kWidth / 4);
        make.centerX.mas_equalTo(0);
    }];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectZero];
    button2.layer.cornerRadius = 10;
    button2.titleLabel.font = [UIFont systemFontOfSize:20];
    [button2 setTitle:@"闯关模式" forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor blueColor];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(clickButton2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_centerY).offset(50);
        make.width.mas_equalTo(kWidth / 2);
        make.height.mas_equalTo(kWidth / 4);
        make.centerX.mas_equalTo(0);
    }];
    
}

- (void)clickButton1 {
    SLSelectViewController *vc = [[SLSelectViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)clickButton2 {
    SLChallengeViewController *vc = [[SLChallengeViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}



- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
