
//
//  PasswordControl.m
//  YXB
//
//  Created by jointem on 16/3/17.
//  Copyright © 2016年 ZhangFan. All rights reserved.
//

#import "PasswordControl.h"
#import "MD5.h"
#define KEY @"aienbiei22&*#*(@ieizewbxwerq?"

@implementation PasswordControl


+(NSString *)encodePasswordWithUserAccount:(NSString *)userAccount
                                   password:(NSString *)password;
{
    //第一次加密
    NSString *oneEncrypt = [MD5 md5LowercaseString:[NSString stringWithFormat:@"%@%@%@",userAccount,password,KEY]];
    //BPLog(@"第一次加密:%@\n",oneEncrypt);
    
    
    //第二次加密
    NSString *twoEncrypt = [MD5 md5LowercaseString:oneEncrypt];
    
    //第三次加密
    NSString *resultEncrypt =[MD5 md5LowercaseString:twoEncrypt];
    
    NSString *encodePassword = [NSString stringWithFormat:@"%@",resultEncrypt];
    
    return encodePassword;
}


+ (NSString *)encodePasswordWithString:(NSString *)string
                           UserAccount:(NSString *)userAccount;
{
    NSLog(@"%lu",(unsigned long)string.length);
    NSString *encode = [NSString stringWithFormat:@"%@%@%@",userAccount,string,KEY];
    NSString *encode_newpassword = [MD5 md5LowercaseString:[MD5 md5LowercaseString:encode]];
    return encode_newpassword;
}


+ (NSString *)encodePassword:(NSString *)password;
{
    return [MD5 md5LowercaseString:password];
}

+ (NSString *)encodePasswordTwice:(NSString *)password
{
    //第一次加密
    NSString *oneEncrypt = [MD5 md5LowercaseString:password];
    //第二次加密
    NSString *twoEncrypt = [MD5 md5LowercaseString:oneEncrypt];
    
    return twoEncrypt;
}

@end
