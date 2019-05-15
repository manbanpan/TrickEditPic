//
//  PublicColor.h
//  TrickEditPic
//
//  Created by zzb on 2019/5/6.
//  Copyright © 2019 json. All rights reserved.
//

#ifndef PublicColor_h
#define PublicColor_h

/**
 指定颜色

 @param r 红
 @param g 绿
 @param b 蓝
 @param a 透明度
 @return 颜色
 */
#define rgba(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

/**
 随机颜色

 @param 256 0-255的随机数
 @param 1 透明度
 @return 颜色
 */
#define TCERandomColor    rgba(arc4random() % 256, arc4random() % 256, arc4random() % 256, 1)


/**
 字符串颜色

 @param s 16字符串
 @return 颜色
 
 */
#define UIColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16 )) / 255.0 green:((( s & 0xFF00 ) >> 8 )) / 255.0 blue:(( s & 0xFF )) / 255.0 alpha:1.0]


/*
 * 常用颜色
 */
#define TCEBlack         [UIColor blackColor]
#define TCEDarkGray      [UIColor darkGrayColor]
#define TCELightGray     [UIColor lightGrayColor]
#define TCEWhite         [UIColor whiteColor]
#define TCEGray          [UIColor grayColor]
#define TCERed           [UIColor redColor]
#define TCEGreen         [UIColor greenColor]
#define TCEBlue          [UIColor blueColor]
#define TCECyan          [UIColor cyanColor]
#define TCEYellow        [UIColor yellowColor]
#define TCEMagenta       [UIColor magentaColor]
#define TCEOrange        [UIColor orangeColor]
#define TCEPurple        [UIColor purpleColor]
#define TCEBrown         [UIColor brownColor]
#define TCEClear         [UIColor clearColor]

#endif /* PublicColor_h */
