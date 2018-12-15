//
//  UserCenter.m
//  lianmeng
//
//  Created by zhuchao on 2018/5/29.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "UserCenter.h"
#import "GCDObjC.h"
#import "JPUSHService.h"
@implementation UserCenter
+ (UserCenter *)sharedInstance{
    GCDSharedInstance(^{ return [[self alloc] init]; });
}

-(id)init{
    self = [super init];
    if(self){
        self.loginModel = [self readUserData];
    }
    return self;
}
    
-(void)removeUserData{
    self.loginModel = nil;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userLoginData"];
}
    
-(LoginModel *)readUserData{
    NSData *data =  [[NSUserDefaults standardUserDefaults] objectForKey:@"userLoginData"];
    return (LoginModel *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
}

-(BOOL)checkLogin{
    return self.loginModel !=nil;
}
    
-(void)saveUserData:(LoginModel *)userData{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userData];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"userLoginData"];
    self.loginModel = userData;
}

@end
