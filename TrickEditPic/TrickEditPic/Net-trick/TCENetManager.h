//
//  TCENetManager.h
//  TrickEditPic
//
//  Created by zzb on 2019/5/10.
//  Copyright © 2019 json. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TCENetManager : NSObject
@property (nonatomic, strong)AFHTTPSessionManager *netManager ;

+(instancetype)manager;
+ (NSDictionary *)tceGetDataWithDES:(NSString*)str;
@end

NS_ASSUME_NONNULL_END
