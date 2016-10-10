//
//  SLSelectViewController.m
//  SaberSokoban
//
//  Created by songlong on 2016/10/9.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import "SLSelectViewController.h"
#import "Masonry.h"
#import "SLGameViewController.h"


@interface SLSelectViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, assign) NSInteger index;

@end

@implementation SLSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _index = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [self.view addSubview:_pickerView];
    [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.5);
    }];
    
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:tempView];
    [tempView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.bottom.equalTo(_pickerView.mas_top);
    }];
    
    UIView *tempView2 = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:tempView2];
    [tempView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.top.equalTo(_pickerView.mas_bottom);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.text = @"请选择关卡";
    titleLabel.font = [UIFont systemFontOfSize:30];
    titleLabel.textColor = [UIColor blackColor];
    [tempView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
    }];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
    button.layer.cornerRadius = 10;
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [tempView2 addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
    }];
}

- (void)click {
    SLGameViewController *vc = [[SLGameViewController alloc] init];
    vc.chapter = _index;
    [self presentViewController:vc animated:YES completion:nil];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 50;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%zd", row + 1];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 50;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _index = row + 1;
}

@end
