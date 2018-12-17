//
//  NetWorkTool.h
//  lianmeng
//
//  Created by zhufeng on 2018/12/17.
//  Copyright © 2018 zhuchao. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  网络请求类型
 */
typedef NS_ENUM(NSUInteger,HttpRequestType) {
    /**
     *  get请求
     */
    HttpRequestTypeGet = 0,
    /**
     *  post请求
     */
    HttpRequestTypePost
};

@interface NetWorkTool : NSObject

/**
 单例方法
 @return 单例方法
 */
+(instancetype)shareInstacne;
/**
 *  发送get请求
 *
 *  @param url  请求的网址字符串
 *  @param soapStr 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
- (void)getWithURLString:(NSString *)url
              parameters:(NSDictionary *)soapStr
                 success:(void (^)(id responseObject))success
                 failure:(void (^)(NSError *error))failure;
/**
 *  发送post请求
 *
 *  @param url  请求的网址字符串
 *  @param soapStr 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
- (void)postWithURLString:(NSString *)url
               parameters:(NSDictionary *)soapStr
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure;
@end
