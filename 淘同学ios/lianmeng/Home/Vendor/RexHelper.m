//
//  RexHelper.m
//  mcapp
//
//  Created by zhuchao on 14/11/13.
//  Copyright (c) 2014年 zhuchao. All rights reserved.
//

#import "RexHelper.h"
#import <RegExCategories/RegExCategories.h>
#import <EasyIOS/EasyIOS.h>
@implementation RexHelper
//验证手机号
+(BOOL)isMobilePhone:(NSString *)str{
    return [str isMatch:RX(@"^(13|17|15|18)[0-9]\\d{8}$")];
}

+(NSString *)getFirstImageUrl:(NSString *)str{
    return [str firstMatch:RX(@"(http|https|ftp|rtsp|mms)://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&=]*)?[.]{1}(jpg|png|bmp)")];
}

+(NSString *)removeSpecialChart:(NSString *)str{
    return [[str replace:RX(@"<[^>]*>|&(\\w+);") with:@""] trim];
}

//验证首字母大写
+(BOOL)isFirstLetterCapital:(NSString *)str{
    return [str isMatch:RX(@"\\b[^\\Wa-z0-9_][^\\WA-Z0-9_]*\\b")];
}

//匹配英文字符开头的n-m位字符且只能数字字母或下划线
+(BOOL)isPassword:(NSString *)str limit:(NSString *)numN to:(NSString *)numM{
    NSString *partent = [NSString stringWithFormat:@"^.[a-zA-Z]\\w{%@,%@}$",numN,numM];
    return [str isMatch:RX(partent)];
}

//.验证网址（带?id=中文）
+(BOOL)isUrl:(NSString *)url{
    return [url isMatch:RX(@"^http:\\/\\/([\\w-]+(\\.[\\w-]+)+(\\/[\\w-     .\\/\?%&=\u4e00-\u9fa5]*)?)?$")];
}

+(BOOL)isChinese:(NSString *)str{
    return [str isMatch:RX(@"^[\u4e00-\u9fa5]{0,}$")];
}
//验证QQ号
+(BOOL)isQQ:(NSString *)str{
    return [str isMatch:RX(@"[0-9]{5,9}")];
}

//验证电子邮件（验证MSN号一样）
+(BOOL)isEmail:(NSString *)str{
    return [str isMatch:RX(@"\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*")];
}

@end
