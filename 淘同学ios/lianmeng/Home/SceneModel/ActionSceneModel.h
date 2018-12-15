//
//  ActionSceneModel.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/4.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "SceneModel.h"

typedef void (^Void)(void);

@interface ActionSceneModel : SceneModel
+ (ActionSceneModel *)sharedInstance;

-(void)sendCashSms:(NSString *)phone
           success:(Void)successHandler
             error:(Void)errorHandler;
-(void)sendSms:(NSString *)phone
              success:(Void)successHandler
                error:(Void)errorHandler;
-(void)doRequest:(Request *)req
       success:(Void)successHandler
         error:(Void)errorHandler;
@end
