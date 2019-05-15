//
//  NSString+DSP.m
//  GeniCam
//
//  Created by zzb on 2018/9/17.
//  Copyright © 2018年 zb. All rights reserved.
//

#import "NSString+Json.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Json)
- (NSDictionary*)tceGetDataWithAES
{
    NSData *cipherData = [[NSData alloc] initWithBase64EncodedString:self options:0];
    unsigned char buffer[1024 * 100];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          [[self getDSPtong] UTF8String],
                                          kCCKeySizeAES128,
                                          [@"1234567890123456" UTF8String],
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
//RTTSXP68JDYBJO88
- (NSString*)getDSPtong{
    
    NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@",[self deskPater11], [self deskPater22],[self deskPater33],[self deskPater44],[self deskPater55]];
    return str;
}
- (NSString*)deskPater11{
    
    return @"CSCO";
}
- (NSString*)deskPater22{
    
    return @"09QW";
}
- (NSString*)deskPater33{
    
    return @"DAOL";
}
- (NSString*)deskPater44{
    
    return @"C";
}

- (NSString*)deskPater55{
    
    return @"O00";
}
//C
@end
