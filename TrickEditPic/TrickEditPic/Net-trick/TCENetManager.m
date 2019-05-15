//
//  TCENetManager.m
//  TrickEditPic
//
//  Created by zzb on 2019/5/10.
//  Copyright © 2019 json. All rights reserved.
//

#import "TCENetManager.h"
#import "GTMBase64.h"
static TCENetManager *_tceNet = nil;

@implementation TCENetManager
+(instancetype)manager;
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tceNet = [[TCENetManager alloc] init];
    });
    return _tceNet;
}

- (instancetype)init
{
    if (self = [super init]) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        _netManager = manager;
    }
    return self;
}

+ (NSDictionary *)tceGetDataWithDES:(NSString*)str
{
    NSData* cipherData = [GTMBase64 decodeString:str];
    unsigned char buffer[1024 * 100];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    const void *iv = (const void *)[@"12345678" UTF8String];
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [@"UIYDXP68JDTBJO55" UTF8String],
                                          kCCKeySizeDES,
                                          iv,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          1024 * 100,
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    NSData *jsonData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    return dic;
}

@end
