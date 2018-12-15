//
//  TakeProfitScene.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/24.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "TakeProfitScene.h"
#import "NavLeftView.h"
#import "Scene+NavBar.h"
#import <EasyIOS/EasyIOS.h>
#import <Masonry/Masonry.h>
#import "UserCenter.h"
#import "RexHelper.h"
#import "ActionSceneModel.h"
#import "AddCashInfoRequest.h"

@interface TakeProfitScene ()
@property(nonatomic,retain)SceneScrollView *scrollView;
@property(nonatomic,retain)NSTimer *timer;
@property(nonatomic,assign)NSUInteger delay;

@property(nonatomic,retain)UIView *whiteBg;
@property(nonatomic,retain)UILabel *tipLabelName;
@property(nonatomic,retain)UILabel *tipLabelAlipay;
@property(nonatomic,retain)UILabel *tipLabelPhone;
@property(nonatomic,retain)UILabel *tipLabelVerifyCode;
@property(nonatomic,retain)UITextField *textFieldName;
@property(nonatomic,retain)UITextField *textFieldAlipay;
@property(nonatomic,retain)UILabel *textLabelPhone;
@property(nonatomic,retain)UITextField *textFieldVerifyCode;
@property(nonatomic,retain)UIButton *verifyCodeBtn;
@property(nonatomic,retain)UIButton *takeProfitBtn;
@end

@implementation TakeProfitScene

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *titleBgImage = [[UIImageView alloc]init];
    [titleBgImage setImage:[UIImage imageNamed:@"nav-bg"]];
    [self.view addSubview:titleBgImage];
    
    [titleBgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@(kStatusBarAndNavigationBarHeight));
    }];
    
    [self.navBar setLeftView:[[NavLeftView alloc]initWithTitle:@"提现"]];
    [self.navBar.leftView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftButtonTouch)]];
    
    _scrollView = [[SceneScrollView alloc]init];
    _scrollView.backgroundColor = [UIColor colorWithString:@"#f8f8f8"];
    [self.view addSubview:_scrollView];
    [_scrollView addContentView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.navBar.mas_bottom);
    }];
    
    UIView *whiteBg = [[UIView alloc]init];
    whiteBg.backgroundColor = [UIColor whiteColor];
    _whiteBg = whiteBg;
    [_scrollView.contentView addSubview:whiteBg];
    [whiteBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.scrollView.contentView);
        make.top.equalTo(self.scrollView.contentView).offset(10.0f);
    }];
    
    _tipLabelName = [[UILabel alloc]init];
    _tipLabelName.font = [UIFont fontWithName:RegularFont size:15.0f];
    _tipLabelName.textColor = [UIColor colorWithString:@"rgb(51,51,51)"];
    _tipLabelName.text = @"姓名";
    [whiteBg addSubview:_tipLabelName];
    
    _textFieldName = [[UITextField alloc]init];
    _textFieldName.placeholder = @"请输入支付宝认证的真实姓名";

    [whiteBg addSubview:_textFieldName];
    
    _tipLabelAlipay = [[UILabel alloc]init];
    _tipLabelAlipay.font = [UIFont fontWithName:RegularFont size:15.0f];
    _tipLabelAlipay.textColor = [UIColor colorWithString:@"rgb(51,51,51)"];
    _tipLabelAlipay.text = @"支付宝账号";
    [whiteBg addSubview:_tipLabelAlipay];
    
    _textFieldAlipay = [[UITextField alloc]init];
    _textFieldAlipay.placeholder =  @"请输入支付宝账号";
    

    [whiteBg addSubview:_textFieldAlipay];
    
    
    _tipLabelPhone = [[UILabel alloc]init];
    _tipLabelPhone.font = [UIFont fontWithName:RegularFont size:15.0f];
    _tipLabelPhone.textColor = [UIColor colorWithString:@"rgb(51,51,51)"];
    _tipLabelPhone.text = @"手机号码";
    [whiteBg addSubview:_tipLabelPhone];
    
    _textLabelPhone = [[UILabel alloc]init];
    _textLabelPhone.font = [UIFont fontWithName:RegularFont size:15.0f];
    _textLabelPhone.textColor = [UIColor colorWithString:@"rgb(51,51,51)"];

    [whiteBg addSubview:_textLabelPhone];
    
    
    _tipLabelVerifyCode = [[UILabel alloc]init];
    _tipLabelVerifyCode.font = [UIFont fontWithName:RegularFont size:15.0f];
    _tipLabelVerifyCode.textColor = [UIColor colorWithString:@"rgb(51,51,51)"];
    _tipLabelVerifyCode.text = @"验证码";
    [whiteBg addSubview:_tipLabelVerifyCode];
    
    _textFieldVerifyCode = [[UITextField alloc]init];
    _textFieldVerifyCode.placeholder = @"请输入验证码";
    [whiteBg addSubview:_textFieldVerifyCode];
    
    _verifyCodeBtn = [[UIButton alloc]init];
    [_verifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _verifyCodeBtn.titleLabel.font = [UIFont fontWithName:RegularFont size:13.0f];
    [_verifyCodeBtn setTitleColor:[UIColor colorWithString:@"rgb(226,83,61)"] forState:UIControlStateNormal];
    _verifyCodeBtn.layer.cornerRadius = 15.0f;
    _verifyCodeBtn.layer.borderColor = [UIColor colorWithString:@"rgb(226,83,61)"].CGColor;
    _verifyCodeBtn.layer.borderWidth = 1.0f;
    [_verifyCodeBtn addTarget:self action:@selector(sendVerifyCode) forControlEvents:UIControlEventTouchUpInside];
    
    [whiteBg addSubview:_verifyCodeBtn];
    
    _takeProfitBtn = [[UIButton alloc]init];
    [_takeProfitBtn addTarget:self action:@selector(takeProfit) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView.contentView addSubview:_takeProfitBtn];
    [self loadAutoLayout];
    [self loadDataModel];
}

-(void)loadDataModel{
    LoginModel *model = [UserCenter sharedInstance].loginModel;
    if(model.realName){
        _textFieldName.text = model.realName;
    }
    if(model.aliAccount){
        _textFieldAlipay.text = model.aliAccount;
    }
    _textLabelPhone.text = model.username;
    if (model.aliAccount) {
        [_takeProfitBtn setImage:[UIImage imageNamed:@"takeProfitBtn"] forState:UIControlStateNormal];
    }else{
        [_takeProfitBtn setImage:[UIImage imageNamed:@"bindAliBtn"] forState:UIControlStateNormal];
    }
}

-(void)takeProfit{
    if([_textFieldVerifyCode.text isEqualToString:@""]){
        [[DialogUtil alloc]showDlg:self.view textOnly:@"请填写验证码!"];
        return;
    }
    if([_textFieldName.text isEqualToString:@""]){
        [[DialogUtil alloc]showDlg:self.view textOnly:@"请填写真是姓名!"];
        return;
    }
    if([_textFieldAlipay.text isEqualToString:@""]){
        [[DialogUtil alloc]showDlg:self.view textOnly:@"请填写支付宝账号!"];
        return;
    }
    AddCashInfoRequest *request = [AddCashInfoRequest Request];
    request.phone = _textLabelPhone.text;
    request.name = _textFieldName.text;
    request.smsCode = _textFieldVerifyCode.text;
    request.aliPayCount = _textFieldAlipay.text;
    [[ActionSceneModel sharedInstance] doRequest:request success:^{
        [[DialogUtil alloc]showDlg:self.view textOnly:@"提现申请提交成功!"];
        [self.navigationController popViewControllerAnimated:YES];
    } error:^{
        [[DialogUtil alloc]showDlg:self.view textOnly:request.message];
    }];
}

-(void)sendVerifyCode{
    if([_verifyCodeBtn.titleLabel.text isEqualToString:@"获取验证码"]){
        @weakify(self);
        [[ActionSceneModel sharedInstance] sendCashSms:_textLabelPhone.text success:^{
            @strongify(self);
            [self fireTimer];
        } error:^{
            [[DialogUtil alloc]showDlg:self.view textOnly:@"验证码发送失败！"];
            [self stopTimer];
        }];
    }
}

-(void)fireTimer{
    _delay = 30;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    [_timer fire];
}

-(void)stopTimer{
    [_verifyCodeBtn setTitle:@"获取验证码"
                           forState:UIControlStateNormal];
    [_timer invalidate];
}

-(void)countDown{
    if(_delay == 0){
        [self stopTimer];
    }else{
        [_verifyCodeBtn setTitle:[NSString stringWithFormat:@"已发送(%ld)",(long)_delay]
                               forState:UIControlStateNormal];
        _delay--;
    }
}

-(void)loadAutoLayout{
    [_tipLabelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteBg).offset(17.0f);
        make.top.equalTo(self.whiteBg).offset(16.0f);
        make.width.equalTo(@75.0f);
    }];
    
    [_textFieldName mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.tipLabelName.mas_right).offset(10.0f);
        make.centerY.equalTo(self.tipLabelName);
        make.right.equalTo(self.whiteBg).offset(-15.0f);
    }];
    
    [_tipLabelAlipay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteBg).offset(17.0f);
        make.top.equalTo(self.tipLabelName.mas_bottom).offset(31.0f);
        make.width.equalTo(@75.0f);
    }];
    
    [_textFieldAlipay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tipLabelAlipay.mas_right).offset(10.0f);
        make.centerY.equalTo(self.tipLabelAlipay);
        make.right.equalTo(self.whiteBg).offset(-15.0f);
    }];
    
    
    [_tipLabelPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteBg).offset(17.0f);
        make.top.equalTo(self.tipLabelAlipay.mas_bottom).offset(31.0f);
        make.width.equalTo(@75.0f);
    }];
    
    [_textLabelPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tipLabelPhone.mas_right).offset(10.0f);
        make.centerY.equalTo(self.tipLabelPhone);
        make.right.equalTo(self.whiteBg).offset(-15.0f);
    }];
    
    
    [_tipLabelVerifyCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteBg).offset(17.0f);
        make.top.equalTo(self.tipLabelPhone.mas_bottom).offset(31.0f);
        make.width.equalTo(@75.0f);
    }];
    
    [_textFieldVerifyCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tipLabelVerifyCode.mas_right).offset(10.0f);
        make.centerY.equalTo(self.tipLabelVerifyCode);
    }];
    
    [_verifyCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@100.0f);
        make.height.equalTo(@30.0f);
        make.centerY.equalTo(self.tipLabelVerifyCode);
        make.left.equalTo(self.textFieldVerifyCode.mas_right).offset(15.0f);
        make.right.equalTo(self.whiteBg).offset(-15.0f);
        make.bottom.equalTo(self.whiteBg).offset(-15.0f);
    }];
    
    
    [_takeProfitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerX.equalTo(self.scrollView.contentView);
        make.top.equalTo(self.whiteBg.mas_bottom).offset(15.0f);
        make.bottom.equalTo(self.scrollView.contentView);
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
