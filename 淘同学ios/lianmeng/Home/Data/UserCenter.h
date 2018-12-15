//  UserCenter.h
//  lianmeng
//  Created by zhuchao on 2018/5/29.
//  Copyright © 2018年 zhuchao. All rights reserved.
#import <Foundation/Foundation.h>
#import "LoginModel.h"
@interface UserCenter : NSObject
@property(nonatomic,retain)LoginModel *loginModel;
+ (UserCenter *)sharedInstance;
-(BOOL)checkLogin;
-(void)removeUserData;
-(void)saveUserData:(LoginModel *)userData;
@end
