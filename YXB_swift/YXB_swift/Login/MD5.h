//
//  MD5.h
//  YXB
//
//  Created by jointem on 16/3/17.
//  Copyright © 2016年 ZhangFan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MD5 : NSObject

// MD5正常加密，返回MD5加密后的字符串
+ (NSString *)md5:(NSString *)text;
// MD5加密之后，把加密后后的字符串中的字母全小写
+ (NSString *)md5LowercaseString:(NSString *)text;
// MD5加密之后，把加密后后的字符串中的字母全大写
+ (NSString *)md5UppercaseString:(NSString *)text;
// 文件MD5
+ (NSString *)getFileMD5WithPath:(NSString *)path;

@end
