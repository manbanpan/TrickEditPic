//
//  PublicVar.h
//  TrickEditPic
//
//  Created by zzb on 2019/5/6.
//  Copyright © 2019 json. All rights reserved.
//

#ifndef PublicVar_h
#define PublicVar_h

#define tceCenter [NSNotificationCenter defaultCenter]
#define tceDefaults   [NSUserDefaults standardUserDefaults]

#define tceSW [UIScreen mainScreen].bounds.size.width
#define tceSH [UIScreen mainScreen].bounds.size.height
#define tceRX(x) (tceSW / 375.0 * (x))
#define tceRY(y) (tceSH / 667.0 * (y))
#define tceLabRC_y (tceSH / 667.0)
#define tceLabRC_x (tceSW / 375.0)
#define Is_5 (tceSH == 568.0 && tceSW == 320.0)
#define Is_S (tceSH == 667.0 && tceSW == 375.0)
#define Is_P (tceSH == 736.0f && tceSW == 414.0f)

#define Is_X \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#define tceBarH (Is_X ? 34 : 0)
#define tceStauH (Is_X ? 44 : 20)
#define tceNavH (Is_X ? 88 : 64)

#define tceImaged(name) [UIImage imageNamed:[NSString stringWithFormat:@"%@",name]]
#define tceWeak(var) __weak typeof(var) weakSelf = var
#define tceStrong(type) __strong __typeof__(type) strongSelf = type


#define AppleLanguage [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"][0]
#define isChines ([AppleLanguage isEqualToString:@"zh-Hans-CN"] ? YES : NO)

/* 弧度转角度 */
#define RADIANS_TO_DEGREES(radian) \
((radian) * (180.0 / M_PI))
///角度转弧度
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

#endif /* PublicVar_h */
