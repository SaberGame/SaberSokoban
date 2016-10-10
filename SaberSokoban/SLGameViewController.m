//
//  SLGameViewController.m
//  SaberSokoban
//
//  Created by songlong on 2016/10/9.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import "SLGameViewController.h"
#import "Masonry.h"
#import "SLMap.h"

#define N 8

@interface SLGameViewController ()

@property (nonatomic, strong) NSArray *mapArray;
@property (nonatomic, strong) NSMutableArray *imageViewArray;

@end

@implementation SLGameViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageViewArray = [NSMutableArray array];
    [self setMapArray];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.text = [NSString stringWithFormat:@"第%zd关", _chapter];
    titleLabel.textColor = [UIColor blackColor];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(30);
    }];
    
    UIView *gameView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:gameView];
    [gameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.width);
    }];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width / N;
    for (int i = 0; i < N * N; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i % N * width, i / N *width, width, width)];
        int num = [self.mapArray[i / N][i % N] intValue];
        [self loadImageWithIndex:num andImageView:imageView];
        [gameView addSubview:imageView];
        [self.imageViewArray addObject:imageView];
    }
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.top.equalTo(gameView.mas_bottom);
    }];
    
    UIButton *upButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [upButton setBackgroundImage:[UIImage imageNamed:@"up_normal"] forState:UIControlStateNormal];
    [upButton addTarget:self action:@selector(up) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:upButton];
    [upButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(bottomView.mas_height).multipliedBy(1/3.0);
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
    }];

    UIButton *downButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [downButton setBackgroundImage:[UIImage imageNamed:@"down_normal"] forState:UIControlStateNormal];
    [downButton addTarget:self action:@selector(down) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:downButton];
    [downButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(bottomView.mas_height).multipliedBy(1/3.0);
        make.bottom.mas_equalTo(0);
        make.centerX.equalTo(upButton.mas_centerX);
    }];

    UIButton *leftButton= [[UIButton alloc] initWithFrame:CGRectZero];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"left_normal"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(left) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:leftButton];
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(upButton.mas_width);
        make.right.equalTo(upButton.mas_left);
        make.top.equalTo(upButton.mas_bottom);
    }];

    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"right_normal"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(right) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(upButton.mas_width);
        make.left.equalTo(upButton.mas_right);
        make.top.equalTo(upButton.mas_bottom);
    }];
}

- (void)up {
    int a[N][N];
    
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            a[i][j] = [self.mapArray[i][j] intValue];
        }
    }
    
    int i = 0;
    for (i=0; i<64; i++) {
        if (a[i/N][i%N] == 5 || a[i/N][i%N] == 9) {
            break;
        }
    }
    
    if (a[i/N-1][i%N] == 2) {
        
        a[i/N-1][i%N] = 5;
        if (a[i/N][i%N] == 9) {
            a[i/N][i%N] = 4;
        } else {
            a[i/N][i%N] = 2;
        }
    } else if (a[i/N-1][i%N] == 4) {
        a[i/N-1][i%N] = 9;
        if (a[i/N][i%N] == 9) {
            a[i/N][i%N] = 4;
        } else {
            a[i/N][i%N] = 2;
        }
    } else if (a[i/N-1][i%N] == 3) {
        if (a[i/N-2][i%N] == 2) {
            a[i/N-2][i%N] = 3;
            
            if (a[i/N-1][i%N] == 6) {
                a[i/N-1][i%N] = 9;
            }
            else {
                a[i/N-1][i%N] = 5;
            }
            
            if (a[i/N][i%N] == 9) {
                a[i/N][i%N] = 4;
            } else {
                a[i/N][i%N] = 2;
            }
        }
        
        else if (a[i/N-2][i%N] == 4) {
            
            a[i/N-2][i%N] = 6;
            if (a[i/N-1][i%N] == 6) {
                a[i/N-1][i%N] = 9;
            } else {
                a[i/N-1][i%N] = 5;
            }
            
            if (a[i/N][i%N] == 9) {
                a[i/N][i%N] = 4;
            } else {
                a[i/N][i%N] = 2;
            }
        }
    }
    else if (a[i/N-1][i%N] == 6) {
        if (a[i/N-2][i%N] == 2) {
            a[i/N-2][i%N] = 3;
            a[i/N-1][i%N] = 9;
            
            if (a[i/N][i%N] == 9) {
                a[i/N][i%N] = 4;
            } else {
                a[i/N][i%N] = 2;
            }
            
        }
        if (a[i/N-2][i%N] == 4) {
            a[i/N-2][i%N] = 6;
            a[i/N-1][i%N] = 9;
            
            if (a[i/N][i%N] == 9) {
                a[i/N][i%N] = 4;
            } else {
                a[i/N][i%N] = 2;
            }
        }
    }
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < N; i++) {
        NSMutableArray *smallArray = [NSMutableArray array];
        for (int j = 0; j < N; j++) {
            int n = a[i][j];
            [smallArray addObject:@(n)];
        }
        [arr addObject:smallArray.copy];
    }
    self.mapArray = arr.copy;
    
    [self reload];
    [self checkWin];
}

- (void)down {
    
    int a[N][N];
    
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            a[i][j] = [self.mapArray[i][j] intValue];
        }
    }
    
    int i = 0;
    for (i=0; i<64; i++) {
        if (a[i/N][i%N] == 5 || a[i/N][i%N] == 9) {
            break;
        }
    }
    
    if (a[i/N+1][i%N] == 2) {
        
        a[i/N+1][i%N] = 5;
        if (a[i/N][i%N] == 9) {
            a[i/N][i%N] = 4;
        } else {
            a[i/N][i%N] = 2;
        }
    } else if (a[i/N+1][i%N] == 4) {
        a[i/N+1][i%N] = 9;
        if (a[i/N][i%N] == 9) {
            a[i/N][i%N] = 4;
        } else {
            a[i/N][i%N] = 2;
        }
    } else if (a[i/N+1][i%N] == 3) {
        if (a[i/N+2][i%N] == 2) {
            a[i/N+2][i%N] = 3;
            
            if (a[i/N+1][i%N] == 6) {
                a[i/N+1][i%N] = 9;
            }
            else {
                a[i/N+1][i%N] = 5;
            }
            
            if (a[i/N][i%N] == 9) {
                a[i/N][i%N] = 4;
            } else {
                a[i/N][i%N] = 2;
            }
        }
        
        else if (a[i/N+2][i%N] == 4) {
            
            a[i/N+2][i%N] = 6;
            if (a[i/N+1][i%N] == 6) {
                a[i/N+1][i%N] = 9;
            } else {
                a[i/N+1][i%N] = 5;
            }
            
            if (a[i/N][i%N] == 9) {
                a[i/N][i%N] = 4;
            } else {
                a[i/N][i%N] = 2;
            }
        }
    }
    else if (a[i/N+1][i%N] == 6) {
        if (a[i/N+2][i%N] == 2) {
            a[i/N+2][i%N] = 3;
            a[i/N+1][i%N] = 9;
            
            if (a[i/N][i%N] == 9) {
                a[i/N][i%N] = 4;
            } else {
                a[i/N][i%N] = 2;
            }
            
        }
        if (a[i/N+2][i%N] == 4) {
            a[i/N+2][i%N] = 6;
            a[i/N+1][i%N] = 9;
            
            if (a[i/N][i%N] == 9) {
                a[i/N][i%N] = 4;
            } else {
                a[i/N][i%N] = 2;
            }
        }
    }
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < N; i++) {
        NSMutableArray *smallArray = [NSMutableArray array];
        for (int j = 0; j < N; j++) {
            int n = a[i][j];
            [smallArray addObject:@(n)];
        }
        [arr addObject:smallArray.copy];
    }
    self.mapArray = arr.copy;
    
    [self reload];
    
    [self checkWin];
}

- (void)left {
    
    int a[N][N];
    
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            a[i][j] = [self.mapArray[i][j] intValue];
        }
    }
    
    int i = 0;
    for (i=0; i<64; i++) {
        if (a[i/N][i%N] == 5 || a[i/N][i%N] == 9) {
            break;
        }
    }
    
    if (a[i/N][i%N-1] == 2) {
        
        a[i/N][i%N-1] = 5;
        if (a[i/N][i%N] == 9) {
            a[i/N][i%N] = 4;
        } else {
            a[i/N][i%N] = 2;
        }
    } else if (a[i/N][i%N-1] == 4) {
        a[i/N][i%N-1] = 9;
        if (a[i/N][i%N] == 9) {
            a[i/N][i%N] = 4;
        } else {
            a[i/N][i%N] = 2;
        }
    } else if (a[i/N][i%N-1] == 3) {
        if (a[i/N][i%N-2] == 2) {
            a[i/N][i%N-2] = 3;
            
            if (a[i/N][i%N-1] == 6) {
                a[i/N][i%N-1] = 9;
            }
            else {
                a[i/N][i%N-1] = 5;
            }
            
            if (a[i/N][i%N] == 9) {
                a[i/N][i%N] = 4;
            } else {
                a[i/N][i%N] = 2;
            }
        }
        
        else if (a[i/N][i%N-2] == 4) {
            
            a[i/N][i%N-2] = 6;
            if (a[i/N][i%N-1] == 6) {
                a[i/N][i%N-1] = 9;
            } else {
                a[i/N][i%N-1] = 5;
            }
            
            if (a[i/N][i%N] == 9) {
                a[i/N][i%N] = 4;
            } else {
                a[i/N][i%N] = 2;
            }
        }
    }
    else if (a[i/N][i%N-1] == 6) {
        if (a[i/N][i%N-2] == 2) {
            a[i/N][i%N-2] = 3;
            a[i/N][i%N-1] = 9;
            
            if (a[i/N][i%N] == 9) {
                a[i/N][i%N] = 4;
            } else {
                a[i/N][i%N] = 2;
            }
            
        }
        if (a[i/N][i%N-2] == 4) {
            a[i/N][i%N-2] = 6;
            a[i/N][i%N-1] = 9;
            
            if (a[i/N][i%N] == 9) {
                a[i/N][i%N] = 4;
            } else {
                a[i/N][i%N] = 2;
            }
        }
    }
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < N; i++) {
        NSMutableArray *smallArray = [NSMutableArray array];
        for (int j = 0; j < N; j++) {
            int n = a[i][j];
            [smallArray addObject:@(n)];
        }
        [arr addObject:smallArray.copy];
    }
    self.mapArray = arr.copy;
    
    [self reload];
    
    [self checkWin];
}

- (void)right {
    int a[N][N];
    
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            a[i][j] = [self.mapArray[i][j] intValue];
        }
    }
    
    int i = 0;
    for (i=0; i<64; i++) {
        if (a[i/N][i%N] == 5 || a[i/N][i%N] == 9) {
            break;
        }
    }
    
    if (a[i/N][i%N+1] == 2) {
        
        a[i/N][i%N+1] = 5;
        if (a[i/N][i%N] == 9) {
            a[i/N][i%N] = 4;
        } else {
            a[i/N][i%N] = 2;
        }
    } else if (a[i/N][i%N+1] == 4) {
        a[i/N][i%N+1] = 9;
        if (a[i/N][i%N] == 9) {
            a[i/N][i%N] = 4;
        } else {
            a[i/N][i%N] = 2;
        }
    } else if (a[i/N][i%N+1] == 3) {
        if (a[i/N][i%N+2] == 2) {
            a[i/N][i%N+2] = 3;
            
            if (a[i/N][i%N+1] == 6) {
                a[i/N][i%N+1] = 9;
            }
            else {
                a[i/N][i%N+1] = 5;
            }
            
            if (a[i/N][i%N] == 9) {
                a[i/N][i%N] = 4;
            } else {
                a[i/N][i%N] = 2;
            }
        }
        
        else if (a[i/N][i%N+2] == 4) {
            
            a[i/N][i%N+2] = 6;
            if (a[i/N][i%N+1] == 6) {
                a[i/N][i%N+1] = 9;
            } else {
                a[i/N][i%N+1] = 5;
            }
            
            if (a[i/N][i%N] == 9) {
                a[i/N][i%N] = 4;
            } else {
                a[i/N][i%N] = 2;
            }
        }
    }
    else if (a[i/N][i%N+1] == 6) {
        if (a[i/N][i%N+2] == 2) {
            a[i/N][i%N+2] = 3;
            a[i/N][i%N+1] = 9;
            
            if (a[i/N][i%N] == 9) {
                a[i/N][i%N] = 4;
            } else {
                a[i/N][i%N] = 2;
            }
            
        }
        if (a[i/N][i%N+2] == 4) {
            a[i/N][i%N+2] = 6;
            a[i/N][i%N+1] = 9;
            
            if (a[i/N][i%N] == 9) {
                a[i/N][i%N] = 4;
            } else {
                a[i/N][i%N] = 2;
            }
        }
    }
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < N; i++) {
        NSMutableArray *smallArray = [NSMutableArray array];
        for (int j = 0; j < N; j++) {
            int n = a[i][j];
            [smallArray addObject:@(n)];
        }
        [arr addObject:smallArray.copy];
    }
    self.mapArray = arr.copy;
    
    [self reload];
    
    [self checkWin];
}


- (void)checkWin {
    int a[N][N];
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            a[i][j] = [self.mapArray[i][j] intValue];
        }
    }
    
    int b=0;
    for (int i=0; i<64; i++) {
        if (a[i/N][i%N]== 4 || a[i/N][i%N]== 9) {
            b++;
        }
    }
    
    if (b==0) {
        UILabel *lblMsg = [[UILabel alloc] init];
        lblMsg.text = [NSString stringWithFormat:@"恭喜胜利"];
        lblMsg.backgroundColor = [UIColor grayColor];
        lblMsg.alpha = 0;
        lblMsg.textColor = [UIColor redColor];
        lblMsg.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:lblMsg];
        CGFloat msgW = 200;
        CGFloat msgH = 50;
        CGFloat msgX = (self.view.frame.size.width - msgW) * 0.5;
        CGFloat msgY = 100;
        lblMsg.frame = CGRectMake(msgX, msgY, msgW, msgH);
        lblMsg.layer.cornerRadius = 15;
        lblMsg.clipsToBounds = YES;
        [UIView animateWithDuration:0.8 animations:^{
            lblMsg.alpha = 0.8;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1.0 delay:5 options:UIViewAnimationOptionCurveLinear animations:^{
                lblMsg.alpha = 0;
            } completion:^(BOOL finished) {
                [lblMsg removeFromSuperview];
            }];
        }];
        
    }
}


- (void)reload {
    for (int i = 0; i < N * N; i++) {
        int num = [self.mapArray[i / N][i % N] intValue];
        UIImageView *imageView = self.imageViewArray[i];
        [self loadImageWithIndex:num andImageView:imageView];
    }
}

- (void)loadImageWithIndex:(int)index andImageView:(UIImageView *)imageView {
    switch (index) {
        case 0:
            imageView.image = [UIImage imageNamed:@"Crate_Black"];
            break;
            
        case 1:
            imageView.image = [UIImage imageNamed:@"Wall_Brown"];
            break;
            
        case 2:
            imageView.image = nil;
            break;
            
        case 3:
            imageView.image = [UIImage imageNamed:@"Crate_Red"];
            break;
            
        case 4:
            imageView.image = [UIImage imageNamed:@"EndPoint_Yellow"];
            break;
            
        case 5:
            imageView.image = [UIImage imageNamed:@"Character4"];
            break;
            
        case 6:
            imageView.image = [UIImage imageNamed:@"Crate_Yellow"];
            break;
            
        case 9:
            imageView.image = [UIImage imageNamed:@"Character4"];
            break;
            
        default:
            break;
    }

}

- (void)setMapArray {
    NSMutableArray *arr = [NSMutableArray array];

    for (int i = 0; i < N; i++) {
        NSMutableArray *smallArray = [NSMutableArray array];
        for (int j = 0; j < N; j++) {
            int n;
            switch (_chapter) {
                case 1:
                    n = c1[i][j];
                    break;
                    
                case 2:
                    n = c2[i][j];
                    break;
                    
                default:
                    break;
            }
            [smallArray addObject:@(n)];
        }
        [arr addObject:smallArray.copy];
    }
    self.mapArray = arr.copy;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
