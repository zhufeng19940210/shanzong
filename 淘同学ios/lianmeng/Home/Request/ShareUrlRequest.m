//
//  ShareUrlRequest.m
//  lianmeng
//
//  Created by zhuchao on 2018/8/2.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "ShareUrlRequest.h"
#import "UserCenter.h"
#import "ActionSceneModel.h"
#import "GoodsListModel.h"
#import "ShareInfo.h"
#import "ShareDataModel.h"

@implementation ShareUrlRequest
-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/mobile/wechat/shareUrl";
    self.METHOD = @"POST";
    self.userId = @([UserCenter sharedInstance].loginModel.userId);
}


+(void)getShareInfo:(NSArray *)dataList callBack:(void (^)(NSArray* imageList))callBack{
    NSArray *requestList = [dataList map:^ShareInfo *(GoodsModel *obj) {
        NSLog(@"GoodsModel.objec:%@",obj);
        return [self getUrl:obj];
    }];
    [[RACSignal combineLatest:[requestList map:^id(ShareInfo * req) {
        return [[RACObserve(req, output) filter:^BOOL(id value) {
            if(value == nil){
                return false;
            }else if([value isKindOfClass:[NSDictionary class]]){
                NSDictionary *d = (NSDictionary *)value;
                if([d[@"status"] integerValue] != 200){
                    return false;
                }
            }
            return true;
        }] map:^id(NSDictionary* value) {
            NSLog(@"getShareInfo.value:%@",value);
            return value[@"data"];
        }];
    }]] subscribeNext:^(RACTuple* list) {
        NSMutableArray *urlList = [NSMutableArray array];
        for (NSString *obj in list) {
            [urlList addObject:obj];
        }
        [self getShareUrl:urlList dataList:dataList callBack:callBack];
    }];
    
    for (ShareInfo *req in requestList) {
        [[ActionSceneModel sharedInstance] SEND_NO_CACHE_ACTION:req];
    }
}

+(void)getShareUrl:(NSArray *)list dataList:(NSArray *)dataList callBack:(void (^)(NSArray* imageList))callBack{
    NSLog(@"getShareUrl过来了吗?");
    NSArray *requestList = [list mapWithIndex:^id(NSString * url, NSUInteger idx) {
        GoodsModel *model = dataList[idx];
        NSLog(@"model.:%@",model);
        if(model.platformId == 1){
            return [self getShareUrl:url itemId:model.itemId];
        }else{
            return url;
        }
    }];
    [[RACSignal combineLatest:[requestList map:^id(id obj) {
        NSLog(@"999999");
        if([obj isKindOfClass:[TBShareUrlRequest class]]){
            TBShareUrlRequest *req = (TBShareUrlRequest *)obj;
            return [[RACObserve(req, output) filter:^BOOL(id value) {
                if(value == nil){
                    return false;
                }else if([value isKindOfClass:[NSDictionary class]]){
                    NSDictionary *d = (NSDictionary *)value;
                    if([d[@"status"] integerValue] != 200){
                        return false;
                    }
                }
                return true;
            }] map:^id(NSDictionary* value) {
                NSLog(@"getShareUrl.value:%@",value);
                return value[@"data"];
            }];
        }else{
            NSLog(@"objc:%@",obj);
            return [RACSignal return:obj];
        }
    }]] subscribeNext:^(RACTuple* list) {
        NSMutableArray *urlList = [NSMutableArray array];
        for (NSString *obj in list) {
            NSLog(@"list.object:%@",obj);
            [urlList addObject:obj];
        }
        NSArray *imageList = [dataList mapWithIndex:^UIImage *(GoodsModel *obj, NSUInteger idx) {
            ShareDataItemModel *model = [[ShareDataItemModel alloc]init];
            model.itmeInfo = obj;
            model.shareUrl = urlList[idx];
            return [model genImage];
        }];
        callBack(imageList);
        
    }];
    
    for (id req in requestList) {
        if([req isKindOfClass:[TBShareUrlRequest class]]){
            [[ActionSceneModel sharedInstance] SEND_NO_CACHE_ACTION:req];
        }
    }
}

+(ShareInfo *)getUrl:(GoodsModel *)model{
    ShareInfo *request = [ShareInfo Request];
    request.itemId = model.itemId;
    if(model.platformId == 1){
        request.PATH =@"/mobile/taobao/clickUrl";
    }else{
        request.PATH =@"/mobile/jd/ios/shareInfo";
        request.activityid = model.activityid;
    }
    return request;
}


+(TBShareUrlRequest *)getShareUrl:(NSString *)url itemId:(NSNumber *)itemId{
    TBShareUrlRequest *request = [TBShareUrlRequest Request];
    request.itemId = itemId;
    request.clickUrl = url;
    return request;
}

@end

@implementation TBShareUrlRequest
-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/mobile/taobao/shareUrl";
    self.METHOD = @"GET";
}
@end


