//
//  PasswordControl.h
//  YXB
//
//  Created by jointem on 16/3/17.
//  Copyright © 2016年 ZhangFan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PasswordControl : NSObject

/**
 *  加密密码
 *
 *  @param userAccount 明文账号
 *  @param password  明文密码
 *
 *  @return 加密成功的密码
 */
+(NSString *)encodePasswordWithUserAccount:(NSString *)userAccount
                                  password:(NSString *)password;

/**
 *  修改登录/支付密码时用到，这个是新密码的加密方式
 *
 *  @param string    明文密码
 *  @param userAccountnt 手机号码
 *
 *  @return 加密成功的密码
 */
+ (NSString *)encodePasswordWithString:(NSString *)string
                           UserAccount:(NSString *)userAccount;


/**
 *  修改登录/支付密码时用到，这个是新密码的加密方式
 *
 *  @param password   明文密码
 *
 *  @return 加密成功的密码
 */
+ (NSString *)encodePassword:(NSString *)password;

/**
 *  密码的加密方式-两次MD5
 *
 *  @param password   明文密码
 *
 *  @return 加密成功的密码
 */
+ (NSString *)encodePasswordTwice:(NSString *)password;

@end
