//
//  WechatLoginScene.m
//  lianmeng
//
//  Created by zhuchao on 2018/5/29.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "WechatLoginScene.h"
#import <Masonry/Masonry.h>
#import <UMShare/UMShare.h>
#import "PhoneLoginScene.h"
#import "TabBarController.h"
#import "LinkWebScene.h"
#import "LoginRequest.h"
#import "ActionSceneModel.h"
#import "UserCenter.h"
#import <EasyIOS/EasyIOS.h>
#import "RegisterScene.h"
#import "JPUSHService.h"

#import "Scene+NavBar.h"
#import "NavLeftView.h"

@interface WechatLoginScene ()
@property(nonatomic,retain)UIButton *wechatLoginButton;
@property(nonatomic,retain)UIButton *phoneLoginButton;

@property(nonatomic,retain)UIImageView *bgImage;
@property(nonatomic,retain)UIButton *back;
@end


@implementation WechatLoginScene


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _bgImage = [[UIImageView alloc]init];
    [_bgImage setImage:[UIImage imageNamed:@"loginImage"]];
    [self.view addSubview:_bgImage];
    
    [_bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(kStatusBarAndNavigationBarHeight + 50.0f);
    }];
    
    
    UIImageView *topImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loginBg"]];
    topImageView.contentMode = UIViewContentModeScaleAspectFill;
    topImageView.clipsToBounds = YES;
    [self.view addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@kStatusBarAndNavigationBarHeight);
    }];
    
    [self.navBar setLeftView:[[NavLeftView alloc]initWithTitle:@"返回"]];
    [self.navBar.leftView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftButtonTouch)]];
    
    
    UIButton *agreeMentButton = [[UIButton alloc]init];
    
    
    agreeMentButton.titleLabel.font = [UIFont systemFontOfSize:10.0f];
    [agreeMentButton setTitleColor:[UIColor colorWithString:@"#AAA"] forState:UIControlStateNormal];
    [agreeMentButton setTitle:@"我已阅读并同意《淘同学用户协议》" forState:UIControlStateNormal];
    [agreeMentButton addTarget:self action:@selector(agreeMentHandle) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:agreeMentButton];
    
    [agreeMentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).offset(10.0f);
        make.bottom.equalTo(self.view).offset(-9.0f);
    }];

    
    UIImageView *checkImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loginChecked"]];
    [self.view addSubview:checkImage];
    [checkImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(agreeMentButton.mas_left).offset(-5.0f);
        make.centerY.equalTo(agreeMentButton);
    }];
    
    
    
    _wechatLoginButton = [[UIButton alloc]init];
    [_wechatLoginButton addTarget:self action:@selector(getAuthWithUserInfoFromWechat) forControlEvents:UIControlEventTouchUpInside];
    [_wechatLoginButton setImage:[UIImage imageNamed:@"wechatLoginBtn"] forState:UIControlStateNormal];
    [self.view addSubview:_wechatLoginButton];
    
    [_wechatLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-150);
    }];
    
    _phoneLoginButton = [[UIButton alloc]init];
    [_phoneLoginButton addTarget:self action:@selector(phoneLogin) forControlEvents:UIControlEventTouchUpInside];
    [_phoneLoginButton setImage:[UIImage imageNamed:@"phoneLogin"] forState:UIControlStateNormal];
    [self.view addSubview:_phoneLoginButton];
    
    [_phoneLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.wechatLoginButton.mas_bottom).offset(20.0f);
    }];
    
    
    // Do any additional setup after loading the view.
}

-(void)leftButtonTouch{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)phoneLogin{
    PhoneLoginScene *scene = [[PhoneLoginScene alloc]init];
    [self.navigationController pushViewController:scene animated:YES];
}


-(void)agreeMentHandle{
    LinkWebScene *web = [[LinkWebScene alloc]init];
    web.url = [NSString stringWithFormat:@"%@/mobile/h5/toProtocol",URLHOST];
    web.title = @"协议";
    [self.navigationController pushViewController:web animated:YES];
}

- (void)getAuthWithUserInfoFromWechat
{
//    WechatLoginRequest *req = [WechatLoginRequest Request];
//    req.unionid = @"oI2eT0jdWsFQzbn6Bwxb_VZ3TAfI";
//    [[ActionSceneModel sharedInstance] doRequest:req success:^{
//        NSError *error;
//        
//        LoginModel *loginModel = [[LoginModel alloc] initWithDictionary:[req.output objectForKey:@"data"] error:&error];
//        
//        [JPUSHService setAlias:[NSString stringWithFormat:@"%ld",(long)loginModel.userId] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
//            
//        } seq:0];
//        
//        [[UserCenter sharedInstance] saveUserData:loginModel];
//        
//        TabBarController *tabBarVc = [[TabBarController alloc]init];
//        [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVc;
//    } error:^{
//    }];
//    return;
    
    
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
//            NSLog(@"Wechat uid: %@", resp.uid);
//            NSLog(@"Wechat openid: %@", resp.openid);
//            NSLog(@"Wechat unionid: %@", resp.unionId);
//            NSLog(@"Wechat accessToken: %@", resp.accessToken);
//            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
//            NSLog(@"Wechat expiration: %@", resp.expiration);
//
//            // 用户信息
//            NSLog(@"Wechat name: %@", resp.name);
//            NSLog(@"Wechat iconurl: %@", resp.iconurl);
//            NSLog(@"Wechat gender: %@", resp.unionGender);
//
//            // 第三方平台SDK源数据
//            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
//
            WechatLoginRequest *req = [WechatLoginRequest Request];
            req.unionid = resp.unionId;
            [[ActionSceneModel sharedInstance] doRequest:req success:^{
                NSError *error;
                
                LoginModel *loginModel = [[LoginModel alloc] initWithDictionary:[req.output objectForKey:@"data"] error:&error];
                
                [JPUSHService setAlias:[NSString stringWithFormat:@"%ld",(long)loginModel.userId] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                    
                } seq:0];
                
                [[UserCenter sharedInstance] saveUserData:loginModel];
                
                TabBarController *tabBarVc = [[TabBarController alloc]init];
                [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVc;
            } error:^{
                if (req.codeKey.integerValue == 400) {
                    RegisterScene *registerScene = [[RegisterScene alloc] init];
                    registerScene.nickName = resp.name;
                    registerScene.headimgUrl = resp.iconurl;
                    registerScene.unionid = resp.unionId;
                    if(req.output[@"data"] && req.output[@"data"][@"inviteCode"]){
                        registerScene.inviteCode = req.output[@"data"][@"inviteCode"];
                    }
                    
                    [self.navigationController pushViewController:registerScene animated:YES];
                }else{
                    [[DialogUtil alloc]showDlg:self.view textOnly:req.message];
                }
            }];
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
