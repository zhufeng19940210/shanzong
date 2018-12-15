//
//  ActionSceneModel.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/4.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "ActionSceneModel.h"
#import <GCDObjC/GCDObjC.h>
#import "SmsRequest.h"

@implementation ActionSceneModel
+ (ActionSceneModel *)sharedInstance{
    GCDSharedInstance(^{ return [self SceneModel]; });
}

-(void)sendCashSms:(NSString *)phone
       success:(Void)successHandler
         error:(Void)errorHandler{
    CashSmsRequest *req = [CashSmsRequest Request];
    req.phone = phone;
    
    [RACObserve(req, state) //监控 网络请求的状态
     subscribeNext:^(NSNumber *state) {
         if(req.succeed && successHandler){
             successHandler();
         }else if (req.failed && errorHandler){
             errorHandler();
         }
     }];
    [self SEND_NO_CACHE_ACTION:req];
}

-(void)sendSms:(NSString *)phone
       success:(Void)successHandler
         error:(Void)errorHandler{
    SmsRequest *req = [SmsRequest Request];
    req.phone = phone;
    
    [RACObserve(req, state) //监控 网络请求的状态
     subscribeNext:^(NSNumber *state) {
         if(req.succeed && successHandler){
             successHandler();
         }else if (req.failed && errorHandler){
             errorHandler();
         }
     }];
    [self SEND_NO_CACHE_ACTION:req];
}

-(void)doRequest:(Request *)req
          success:(Void)successHandler
            error:(Void)errorHandler{
    
    [RACObserve(req, state) //监控 网络请求的状态
     subscribeNext:^(NSNumber *state) {
         if(req.succeed && successHandler){
             successHandler();
         }else if (req.failed && errorHandler){
             errorHandler();
         }
     }];
    [self SEND_NO_CACHE_ACTION:req];
}
@end
