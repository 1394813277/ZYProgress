#### ZYProgress

这是一个用于进度条显示的Progress

#####使用

`#import "CircleProgressView.h"`

#####初始化：

`_circleProgressView = [[CircleProgressView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2.0f - 188/2.0f, yPoint, 188, 188)];`

`_circleProgressView.trackColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.4];//底色`

`_circleProgressView.progressColor = [UIColor whiteColor];`//进度条的颜色

`_circleProgressView.progressWidth = 3;`//底色和进度条的宽度
`[_circleProgressView setProgress:0.0f animated:YES];`
        
#####设置进度：

` [self.circleProgressView setProgress:k animated:YES];`