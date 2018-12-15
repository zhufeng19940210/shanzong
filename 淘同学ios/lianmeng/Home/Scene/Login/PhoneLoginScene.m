//
//  PhoneLoginScene.m
//  lianmeng
//
//  Created by zhuchao on 2018/5/29.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "PhoneLoginScene.h"
#import <Masonry/Masonry.h>
#import "RegisterScene.h"
#import "Scene+NavBar.h"
#import "NavLeftView.h"
#import "TabBarController.h"
#import "ActionSceneModel.h"
#import "LoginRequest.h"
#import "RexHelper.h"
#import "DialogUtil.h"
#import "LoginModel.h"
#import "UserCenter.h"

@interface PhoneLoginScene ()
@property(nonatomic,retain)UITextField *phoneTextField;
@property(nonatomic,retain)UITextField *passwordTextField;

@end

@implementation PhoneLoginScene

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *topImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loginBg"]];
    [self.view addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.left.right.equalTo(self.view);
    }];
    
    
    [self.navBar setLeftView:[[NavLeftView alloc]initWithTitle:@"登陆"]];
    [self.navBar.leftView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftButtonTouch)]];
    
    
    
    _phoneTextField = [[UITextField alloc]init];
    _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    _phoneTextField.font = [UIFont systemFontOfSize:18.0f];
    _phoneTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入手机号"
                                                                           attributes:@{NSForegroundColorAttributeName:[UIColor colorWithString:@"#AAA"]}];
    [self.view addSubview:_phoneTextField];
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.view).offset(39.0f);
        make.right.equalTo(self.view).offset(-39.0f);
        make.top.equalTo(topImageView.mas_bottom).offset(42.0f);
    }];
    
    UIView *phoneLineView = [[UIView alloc]init];
    phoneLineView.backgroundColor = [UIColor colorWithString:@"#AAA"];
    [self.view addSubview:phoneLineView];
    [phoneLineView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.height.equalTo(@0.5f);
       make.left.right.equalTo(self.phoneTextField);
        make.top.equalTo(self.phoneTextField.mas_bottom).offset(17.0f);
    }];
    
    
    
    _passwordTextField = [[UITextField alloc]init];
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.font = [UIFont systemFontOfSize:18.0f];
    _passwordTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入密码"
                                                                              attributes:@{NSForegroundColorAttributeName:[UIColor colorWithString:@"#AAA"]}];
    [self.view addSubview:_passwordTextField];
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(39.0f);
        make.right.equalTo(self.view).offset(-39.0f);
        make.top.equalTo(self.phoneTextField.mas_bottom).offset(45.0f);
    }];
    
    
    UIView *passWordLineView = [[UIView alloc]init];
    passWordLineView.backgroundColor = [UIColor colorWithString:@"#AAA"];
    [self.view addSubview:passWordLineView];
    [passWordLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5f);
        make.left.right.equalTo(self.passwordTextField);
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(17.0f);
    }];
    
    
    
    UIButton *loginButton = [[UIButton alloc]init];
    [loginButton setImage:[UIImage imageNamed:@"loginBtn"] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(doLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerX.equalTo(self.view);
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(70.0f);
    }];
    
    
//    UIButton *registerButton = [[UIButton alloc]init];
//    [registerButton setImage:[UIImage imageNamed:@"registerButton"] forState:UIControlStateNormal];
//    [registerButton addTarget:self action:@selector(openRegisterScene) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:registerButton];
//    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view);
//        make.top.equalTo(loginButton.mas_bottom).offset(30.0f);
//    }];
    
    // Do any additional setup after loading the view.
}

-(void)doLogin{
    if(![RexHelper isMobilePhone:_phoneTextField.text]){
        [[DialogUtil alloc]showDlg:self.view textOnly:@"手机号码不正确"];
    }else if(_passwordTextField.text.length == 0){
        [[DialogUtil alloc]showDlg:self.view textOnly:@"密码不能为空"];
    }else{
        LoginRequest *req = [LoginRequest Request];
        req.username = _phoneTextField.text;
        req.password = _passwordTextField.text;
        [[ActionSceneModel sharedInstance] doRequest:req success:^{
            NSError *error;
            LoginModel *loginModel = [[LoginModel alloc] initWithDictionary:[req.output objectForKey:@"data"] error:&error];
            [[UserCenter sharedInstance] saveUserData:loginModel];
            
            TabBarController *tabBarVc = [[TabBarController alloc]init];
            [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVc;
        } error:^{
            [[DialogUtil alloc]showDlg:self.view textOnly:@"登陆失败"];
        }];
    }
}

-(void)openRegisterScene{
    RegisterScene *scene = [[RegisterScene alloc]init];
    [self.navigationController pushViewController:scene animated:YES];
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
