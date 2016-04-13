//
//  CircleProgressView.h
//  CAShapeLayerDemo
//
//  Created by 周洋 on 16/2/26.
//  Copyright © 2016年 周洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleProgressView : UIView{
    
}

@property (nonatomic, strong) UIColor *trackColor;
@property (nonatomic, strong) UIColor *progressColor;

@property (nonatomic) float progressWidth;

- (void)setProgress:(float)progress animated:(BOOL)animated;

@end
