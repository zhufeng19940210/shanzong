//  RexHelper.h
//  mcapp
//  Created by zhuchao on 14/11/13.
//  Copyright (c) 2014年 zhuchao. All rights reserved.
#import <Foundation/Foundation.h>

@interface RexHelper : NSString
//验证手机号
+(BOOL)isMobilePhone:(NSString *)str;
+(NSString *)getFirstImageUrl:(NSString *)str;
+(NSString *)removeSpecialChart:(NSString *)str;
//验证首字母大写
+(BOOL)isFirstLetterCapital:(NSString *)str;
//匹配英文字符开头的n-m位字符且只能数字字母或下划线
+(BOOL)isPassword:(NSString *)str limit:(NSString *)numN to:(NSString *)numM;
//.验证网址（带?id=中文）
+(BOOL)isUrl:(NSString *)url;
+(BOOL)isChinese:(NSString *)str;
//验证QQ号
+(BOOL)isQQ:(NSString *)str;
//验证电子邮件（验证MSN号一样）
+(BOOL)isEmail:(NSString *)str;
@end
