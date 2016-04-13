//
//  CircleProgressView.m
//  CAShapeLayerDemo
//
//  Created by 周洋 on 16/2/26.
//  Copyright © 2016年 周洋. All rights reserved.
//

#import "CircleProgressView.h"

static const float kWhitePointDiameter = 6.0f;//小白点的直径

@interface CircleProgressView (){
    CAShapeLayer *_trackLayer;
    UIBezierPath *_trackPath;
    CAShapeLayer *_progressLayer;
    UIBezierPath *_progressPath;
    float lastProgress;
    CAShapeLayer *pointLayer1;//开头的小白点，固定不动
    UIBezierPath *pointLayerPath1;
    CAShapeLayer *pointLayer2;//结尾的小白点，随着进度条动
    UIBezierPath *pointLayerPath2;
}
@property (nonatomic) float progress;//0~1之间的数
@end

@implementation CircleProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _trackLayer = [CAShapeLayer layer];
        _trackLayer.frame = self.bounds;
        [self.layer addSublayer:_trackLayer];
        _trackLayer.fillColor = nil;
        
        
        _progressLayer = [CAShapeLayer layer];
        [self.layer addSublayer:_progressLayer];
        _progressLayer.fillColor = nil;
        _progressLayer.lineCap = kCALineCapRound;
        _progressLayer.frame = self.bounds;
        
        pointLayer1 = [CAShapeLayer layer];
        [self.layer addSublayer:pointLayer1];
        pointLayer1.fillColor = [UIColor whiteColor].CGColor;
        pointLayer1.lineCap = kCALineCapRound;
        pointLayer1.frame = self.bounds;
        
        pointLayer2 = [CAShapeLayer layer];
        [self.layer addSublayer:pointLayer2];
//        pointLayer2.fillColor = [UIColor greenColor].CGColor;
        pointLayer2.fillColor = [UIColor whiteColor].CGColor;
        pointLayer2.lineCap = kCALineCapRound;
        pointLayer2.frame = CGRectMake(0, 0, kWhitePointDiameter, kWhitePointDiameter);
        
        
        
        //默认5
        self.progressWidth = 5;
    }
    return self;
}

void MyCGPathApplierFunc (void *info, const CGPathElement *element) {
    NSMutableArray *bezierPoints = (__bridge NSMutableArray *)info;
    CGPoint *points = element->points;
    CGPathElementType type = element->type;
    switch(type) {
        case kCGPathElementMoveToPoint: // contains 1 point
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[0]]];
            break;
        case kCGPathElementAddLineToPoint: // contains 1 point
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[0]]];
            break;
        case kCGPathElementAddQuadCurveToPoint: // contains 2 points
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[0]]];
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[1]]];
            break;
        case kCGPathElementAddCurveToPoint: // contains 3 points
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[0]]];
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[1]]];
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[2]]];
            break;
        case kCGPathElementCloseSubpath: // contains no point
            break;
    }
}

- (void)setProgressAnimated:(BOOL)animated{
    
    NSLog(@"progress = %f",_progress);
    
    
    
    [_progressLayer removeAllAnimations];
    [pointLayer2 removeAllAnimations];
    [_progressLayer setStrokeEnd:_progress];
    
    
    
    if (animated == NO) {
        // todo:删除已有的动画。
    }else{
        
        pointLayerPath2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(kWhitePointDiameter/2.0f, kWhitePointDiameter/2.0f) radius:kWhitePointDiameter startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        NSMutableArray *bezierPoints = [NSMutableArray array];
        CGPathApply(pointLayerPath2.CGPath, (__bridge void * _Nullable)(bezierPoints), MyCGPathApplierFunc);
        
        pointLayer2.position = [[bezierPoints firstObject] CGPointValue];
        pointLayer2.path = pointLayerPath2.CGPath;
        
        if (lastProgress > _progress) {
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.frame)/2.0f,CGRectGetHeight(self.frame)/2.0f) radius:CGRectGetWidth(self.frame)/2.0f - kWhitePointDiameter - _progressLayer.lineWidth/2.0f startAngle:M_PI*((lastProgress * 2)- 1/2.0f) endAngle:M_PI*((_progress * 2)- 1/2.0f) clockwise:NO];
            animation.path = [path CGPath];
            animation.duration = 0.25f;
            NSMutableArray *bezierPoints2 = [NSMutableArray array];
            CGPathApply([path CGPath], (__bridge void * _Nullable)(bezierPoints2), MyCGPathApplierFunc);
            pointLayer2.position = [[bezierPoints2 lastObject] CGPointValue];
            [pointLayer2 addAnimation:animation forKey:@"position"];
        }else{
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.frame)/2.0f,CGRectGetHeight(self.frame)/2.0f) radius:CGRectGetWidth(self.frame)/2.0f - kWhitePointDiameter - _progressLayer.lineWidth/2.0f startAngle:M_PI*((lastProgress * 2)- 1/2.0f) endAngle:M_PI*((_progress * 2)- 1/2.0f) clockwise:YES];
            animation.path = [path CGPath];
            animation.duration=0.25f;
            NSMutableArray *bezierPoints2 = [NSMutableArray array];
            CGPathApply([path CGPath], (__bridge void * _Nullable)(bezierPoints2), MyCGPathApplierFunc);
            pointLayer2.position = [[bezierPoints2 lastObject] CGPointValue];
            [pointLayer2 addAnimation:animation forKey:@"position"];
        }
        
        
    
    }
    
    lastProgress = _progress;
}


- (void)setProgressWidth:(float)progressWidth{
    _progressWidth = progressWidth;

    _trackLayer.lineWidth = _progressWidth * 2;//底色稍微宽
    _progressLayer.lineWidth = _progressWidth;
    
    _trackPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.bounds)/2.0f, CGRectGetHeight(self.bounds)/2.0f) radius:(self.bounds.size.width - _trackLayer.lineWidth)/ 2 -kWhitePointDiameter startAngle:0 endAngle:M_PI * 2 clockwise:YES];;
    _trackLayer.path = _trackPath.CGPath;
    
    _progressPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.bounds)/2.0f, CGRectGetHeight(self.bounds)/2.0f) radius:(self.bounds.size.width - _progressWidth)/ 2 - kWhitePointDiameter startAngle:-M_PI/2.0f endAngle:M_PI*1.5 clockwise:YES];
    
    _progressLayer.path = _progressPath.CGPath;
    
    
    pointLayerPath1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(self.bounds), kWhitePointDiameter + progressWidth/2.0f) radius:kWhitePointDiameter startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    pointLayer1.path = pointLayerPath1.CGPath;
    
    
    
}

- (void)setTrackColor:(UIColor *)trackColor{
    _trackLayer.strokeColor = trackColor.CGColor;
}

- (void)setProgressColor:(UIColor *)progressColor{
    _progressLayer.strokeColor = progressColor.CGColor;
}

- (void)setProgress:(float)progress{
    
    [self setProgress:progress animated:NO];
}

- (void)setProgress:(float)progress animated:(BOOL)animated{
    progress = progress>1?1:progress;
    progress = progress<0?0:progress;
    
    _progress = progress;

    [self setProgressAnimated:animated];
}

-(void)dealloc{
    NSLog(@"%s",__func__);
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
