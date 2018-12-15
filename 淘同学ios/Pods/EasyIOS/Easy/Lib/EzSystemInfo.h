//  Created by EasyIOS on 14-4-10.
//  Copyright (c) 2014年 zhuchao. All rights reserved.
//

#define baseScrean 375
#define rem(...)  [EzSystemInfo rem:__VA_ARGS__]

#import "EzSingleton.h"

extern const BOOL IOS12_OR_LATER;
extern const BOOL IOS11_OR_LATER;
extern const BOOL IOS10_OR_LATER;
extern const BOOL IOS9_OR_LATER;
extern const BOOL IOS8_OR_LATER;
extern const BOOL IOS7_OR_LATER;
extern const BOOL IOS6_OR_LATER;
extern const BOOL IOS5_OR_LATER;
extern const BOOL IOS4_OR_LATER;
extern const BOOL IOS3_OR_LATER;

extern const BOOL IOS11_OR_EARLIER;
extern const BOOL IOS10_OR_EARLIER;
extern const BOOL IOS9_OR_EARLIER;
extern const BOOL IOS8_OR_EARLIER;
extern const BOOL IOS7_OR_EARLIER;
extern const BOOL IOS6_OR_EARLIER;
extern const BOOL IOS5_OR_EARLIER;
extern const BOOL IOS4_OR_EARLIER;
extern const BOOL IOS3_OR_EARLIER;

extern const BOOL IS_SCREEN_4_INCH;
extern const BOOL IS_SCREEN_35_INCH;
extern const BOOL IS_SCREEN_47_INCH;
extern const BOOL IS_SCREEN_55_INCH;
@interface EzSystemInfo : NSObject

AS_SINGLETON( EzSystemInfo )

+ (NSString *)OSVersion;
+ (NSString *)appVersion;
+ (NSString *)appIdentifier;
+ (NSString *)appSchema;
+ (NSString *)appSchema:(NSString *)name;
+ (NSString *)deviceModel;

+ (BOOL)isDevicePhone;
+ (BOOL)isDevicePad;

+ (BOOL)requiresPhoneOS;

+ (BOOL)isPhone;
+ (BOOL)isPhone35;
+ (BOOL)isPhoneRetina35;
+ (BOOL)isPhoneRetina4;
+ (BOOL)isPad;
+ (BOOL)isPadRetina;
+ (BOOL)isScreenSize:(CGSize)size;
+ (CGFloat)rem:(CGFloat)rem;

@end
