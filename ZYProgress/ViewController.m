//
//  ViewController.m
//  ZYProgress
//
//  Created by zhouyang on 16/4/5.
//  Copyright © 2016年 zhouyang. All rights reserved.
//

#import "ViewController.h"
#import "CircleProgressView.h"
#import "GlobalHeader.h"

@interface ViewController (){
    float k;
}
@property(nonatomic,strong) CircleProgressView *circleProgressView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    k = 0.5f;
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:self.circleProgressView];
    [self.circleProgressView setProgress:k animated:YES];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    k += 0.3f;
    
    if (k > 1.0f) {
        k = 0.1f;
    }
    
    if (k < 0.0f) {
        k = 1.0f;
    }
    [self.circleProgressView setProgress:k animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CircleProgressView *)circleProgressView{
    if (!_circleProgressView) {
        
        CGFloat yPoint = 212.0f/kScale;
        if (SCREEN_IPHONE4) {
            yPoint = 118.0f/kScale;
        }
        _circleProgressView = [[CircleProgressView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2.0f - 188/2.0f, yPoint, 188, 188)];
        _circleProgressView.trackColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.4];//底色
        _circleProgressView.progressColor = [UIColor whiteColor];//进度条的颜色
        _circleProgressView.progressWidth = 3;//底色和进度条的宽度
        [_circleProgressView setProgress:0.0f animated:YES];
    }
    
    return _circleProgressView;
}

@end
