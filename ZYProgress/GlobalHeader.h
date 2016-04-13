//
//  GlobalHeader.h
//  Demo
//
//  Created by kf106636 on 15/10/15.
//  Copyright © 2015年 BBK. All rights reserved.
//

#ifndef GlobalHeader_h
#define GlobalHeader_h


#endif /* GlobalHeader_h */

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define kScale ([UIScreen mainScreen].scale)
#define SCREEN_IPHONE4 SCREEN_HEIGHT == 480

#define NAVIGATIONBARHEIGHT ([UIApplication sharedApplication].statusBarFrame.size.height+self.navigationController.navigationBar.frame.size.height)



#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define ANYCOLOR [UIColor colorWithRed:arc4random()%255/255.0f green:arc4random()%255/255.0f blue:arc4random()%255/255.0f alpha:1]
