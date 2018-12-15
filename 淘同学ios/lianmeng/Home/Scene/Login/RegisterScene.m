//  RegisterScene.m
//  lianmeng
//  Created by zhuchao on 2018/5/29.
//  Copyright © 2018年 zhuchao. All rights reserved.
#import "RegisterScene.h"
#import <Masonry/Masonry.h>
#import "Scene+NavBar.h"
#import "NavLeftView.h"
#import "ActionSceneModel.h"
#import "RexHelper.h"
#import "DialogUtil.h"
#import "RegisterRequest.h"
#import "TabBarController.h"
#import "UserCenter.h"

#import "JPUSHService.h"

@interface RegisterScene ()
@property(nonatomic,retain)UITextField *inviteCodeTextField;
@property(nonatomic,retain)UITextField *phoneTextField;
@property(nonatomic,retain)UITextField *verifyCodeTextField;
@property(nonatomic,retain)UIButton *sendVerifyCodeButton;
@property(nonatomic,retain)NSTimer *timer;
@property(nonatomic,assign)NSUInteger delay;
@end

@implementation RegisterScene


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *topImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loginBg"]];
    [self.view addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
    }];
    
    [self.navBar setLeftView:[[NavLeftView alloc]initWithTitle:@"注册"]];
    [self.navBar.leftView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftButtonTouch)]];
    
    _inviteCodeTextField = [[UITextField alloc]init];
    _inviteCodeTextField.font = [UIFont systemFontOfSize:18.0f];
    _inviteCodeTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入邀请码"
                                                                                attributes:@{NSForegroundColorAttributeName:[UIColor colorWithString:@"#AAA"]}];
    [self.view addSubview:_inviteCodeTextField];
    if (self.inviteCode) {
        _inviteCodeTextField.text = self.inviteCode;
        _inviteCodeTextField.enabled = NO;
    }
    [_inviteCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(39.0f);
        make.right.equalTo(self.view).offset(-39.0f);
        make.top.equalTo(topImageView.mas_bottom).offset(42.0f);
    }];
    
    UIView *inviteLineView = [[UIView alloc]init];
    inviteLineView.backgroundColor = [UIColor colorWithString:@"#AAA"];
    [self.view addSubview:inviteLineView];
    [inviteLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5f);
        make.left.right.equalTo(self.inviteCodeTextField);
        make.top.equalTo(self.inviteCodeTextField.mas_bottom).offset(17.0f);
    }];
    
    _phoneTextField = [[UITextField alloc]init];
    _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    _phoneTextField.font = [UIFont systemFontOfSize:18.0f];
    _phoneTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入手机号"
                                                                           attributes:@{NSForegroundColorAttributeName:[UIColor colorWithString:@"#AAA"]}];
    [self.view addSubview:_phoneTextField];
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(39.0f);
        make.right.equalTo(self.view).offset(-39.0f);
        make.top.equalTo(self.inviteCodeTextField.mas_bottom).offset(45.0f);
    }];
    
    UIView *phoneLineView = [[UIView alloc]init];
    phoneLineView.backgroundColor = [UIColor colorWithString:@"#AAA"];
    [self.view addSubview:phoneLineView];
    [phoneLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5f);
        make.left.right.equalTo(self.phoneTextField);
        make.top.equalTo(self.phoneTextField.mas_bottom).offset(17.0f);
    }];
    
    
    _verifyCodeTextField = [[UITextField alloc]init];
    _verifyCodeTextField.font = [UIFont systemFontOfSize:18.0f];
    _verifyCodeTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入验证码"
                                                                                attributes:@{NSForegroundColorAttributeName:[UIColor colorWithString:@"#AAA"]}];
    
    [self.view addSubview:_verifyCodeTextField];
    [_verifyCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(39.0f);
        make.top.equalTo(self.phoneTextField.mas_bottom).offset(45.0f);
    }];
    
    _sendVerifyCodeButton = [[UIButton alloc] init];
    [_sendVerifyCodeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    [_sendVerifyCodeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _sendVerifyCodeButton.titleLabel.font = [UIFont systemFontOfSize:18.0F];
    [_sendVerifyCodeButton addTarget:self action:@selector(sendVerifyCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sendVerifyCodeButton];
    [_sendVerifyCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.verifyCodeTextField.mas_right).offset(20.0f);
        make.centerY.equalTo(self.verifyCodeTextField);
        make.right.equalTo(self.view).offset(-39.0f);
    }];
    
    
    UIView *verifyCodeLineView = [[UIView alloc]init];
    verifyCodeLineView.backgroundColor = [UIColor colorWithString:@"#AAA"];
    [self.view addSubview:verifyCodeLineView];
    [verifyCodeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5f);
        make.left.equalTo(self.verifyCodeTextField);
        make.right.equalTo(self.sendVerifyCodeButton);
        make.top.equalTo(self.verifyCodeTextField.mas_bottom).offset(17.0f);
    }];
    
//    _passwordTextField = [[UITextField alloc]init];
//    _passwordTextField.secureTextEntry = YES;
//    _passwordTextField.font = [UIFont systemFontOfSize:18.0f];
//    _passwordTextField.attributedPlaceholder =[[NSAttributedString alloc]initWithString:@"请输入密码"
//                                                                             attributes:@{NSForegroundColorAttributeName:[UIColor colorWithString:@"#AAA"]}];
//    [self.view addSubview:_passwordTextField];
//    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(39.0f);
//        make.right.equalTo(self.view).offset(-39.0f);
//        make.top.equalTo(self.verifyCodeTextField.mas_bottom).offset(45.0f);
//    }];
//
//
//    UIView *passWordLineView = [[UIView alloc]init];
//    passWordLineView.backgroundColor = [UIColor colorWithString:@"#AAA"];
//    [self.view addSubview:passWordLineView];
//    [passWordLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@0.5f);
//        make.left.right.equalTo(self.passwordTextField);
//        make.top.equalTo(self.passwordTextField.mas_bottom).offset(17.0f);
//    }];
//
//
//    _rePasswordTextField = [[UITextField alloc]init];
//    _rePasswordTextField.secureTextEntry = YES;
//    _rePasswordTextField.font = [UIFont systemFontOfSize:18.0f];
//    _rePasswordTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请再次输入密码"
//                                                                               attributes:@{NSForegroundColorAttributeName:[UIColor colorWithString:@"#AAA"]}];
//    [self.view addSubview:_rePasswordTextField];
//    [_rePasswordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(39.0f);
//        make.right.equalTo(self.view).offset(-39.0f);
//        make.top.equalTo(self.passwordTextField.mas_bottom).offset(45.0f);
//    }];
//
//
//    UIView *rePassWordLineView = [[UIView alloc]init];
//    rePassWordLineView.backgroundColor = [UIColor colorWithString:@"#AAA"];
//    [self.view addSubview:rePassWordLineView];
//    [rePassWordLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@0.5f);
//        make.left.right.equalTo(self.rePasswordTextField);
//        make.top.equalTo(self.rePasswordTextField.mas_bottom).offset(17.0f);
//    }];
    
    
    UIButton *registerButton = [[UIButton alloc]init];
    [registerButton setImage:[UIImage imageNamed:@"registerButton"] forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(doRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.verifyCodeTextField.mas_bottom).offset(70.0f);
    }];
    

    // Do any additional setup after loading the view.
}

-(void)sendVerifyCode{
    if([RexHelper isMobilePhone:_phoneTextField.text] ){
       if([_sendVerifyCodeButton.titleLabel.text isEqualToString:@"发送验证码"]){
            @weakify(self);
            [[ActionSceneModel sharedInstance] sendSms:_phoneTextField.text success:^{
                @strongify(self);
                [self fireTimer];
            } error:^{
                [[DialogUtil alloc]showDlg:self.view textOnly:@"验证码发送失败！"];
                [self stopTimer];
            }];
        }
    }else{
        [[DialogUtil alloc]showDlg:self.view textOnly:@"手机号码不正确！"];
    }
}

-(void)fireTimer{
    _delay = 30;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    [_timer fire];
}

-(void)stopTimer{
    [_sendVerifyCodeButton setTitle:@"发送验证码"
                           forState:UIControlStateNormal];
    [_timer invalidate];
}

-(void)countDown{
    if(_delay == 0){
        [self stopTimer];
    }else{
        [_sendVerifyCodeButton setTitle:[NSString stringWithFormat:@"已发送(%ld)",(long)_delay]
                                   forState:UIControlStateNormal];
        _delay--;
    }
}

-(void)doRegister{
    if(![RexHelper isMobilePhone:_phoneTextField.text]){
        [[DialogUtil alloc]showDlg:self.view textOnly:@"手机号码不正确"];
    }else if(_verifyCodeTextField.text.length == 0){
        [[DialogUtil alloc]showDlg:self.view textOnly:@"验证码不能为空！"];
    }else{
        RegisterRequest * req = [RegisterRequest Request];
        req.username = _phoneTextField.text;
        req.invitecode = _inviteCodeTextField.text;
        req.smsCode = _verifyCodeTextField.text;
        req.nickName = _nickName;
        req.headimgUrl = _headimgUrl;
        req.unionid = _unionid;
        [[ActionSceneModel sharedInstance] doRequest:req success:^{
            NSError *error;
            LoginModel *loginModel = [[LoginModel alloc] initWithDictionary:[req.output objectForKey:@"data"] error:&error];
            
            [JPUSHService setAlias:[NSString stringWithFormat:@"%ld",(long)loginModel.userId] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                
            } seq:0];
            
            [[UserCenter sharedInstance] saveUserData:loginModel];
            
            TabBarController *tabBarVc = [[TabBarController alloc]init];
            [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVc;
        } error:^{
            [[DialogUtil alloc]showDlg:self.view textOnly:@"注册失败！"];
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
