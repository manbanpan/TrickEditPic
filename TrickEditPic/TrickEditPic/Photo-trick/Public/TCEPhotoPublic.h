//
//  TCEPhotoPublic.h
//  TrickEditPic
//
//  Created by zzb on 2019/5/7.
//  Copyright © 2019 json. All rights reserved.
//
//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖保佑             永无BUG
//---------------------------------------------------------------------------*/

#ifndef TCEPhotoPublic_h
#define TCEPhotoPublic_h

typedef NS_ENUM(NSInteger,PhotoType) {
    PhotoSingleType,
    PhotoMoreType
};

#define TCE_kScreenWidth [UIScreen mainScreen].bounds.size.width
#define TCE_kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kTCERX(x) (TCE_kScreenWidth / 375.0 * (x))
#define kTCERY(y) (TCE_kScreenHeight / 667.0 * (y))
#define kTCELabRC_y (TCE_kScreenHeight / 667.0)
#define kTCELabRC_x (TCE_kScreenWidth / 375.0)
#define kIs_5 (TCE_kScreenHeight == 568.0 && TCE_kScreenWidth == 320.0)
#define kIs_S (TCE_kScreenHeight == 667.0 && TCE_kScreenWidth == 375.0)
#define kIs_P (TCE_kScreenHeight == 736.0f && TCE_kScreenWidth == 414.0f)

#define kIs_X \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#define kTCEBarH (kIs_X ? 34 : 0)
#define kTCEStauH (kIs_X ? 44 : 20)
#define kTCENavH (kIs_X ? 88 : 64)

#define kTCERGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>

#endif /* TCEPhotoPublic_h */
