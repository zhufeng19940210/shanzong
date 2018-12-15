
#import "SearchNavBar.h"
#import <Masonry/Masonry.h>

@interface SearchNavBar()
@property(nonatomic,strong)UIImageView *bgView;
@property(nonatomic,strong)UIImageView *searchBg;
@property(nonatomic,strong)UIImageView *searchIcon;
@end
@implementation SearchNavBar

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _bgView = [[UIImageView alloc]init];
        [self addSubview:_bgView];
        _bgView.image = [UIImage imageNamed:@"nav-bg"];

        _leftButton = [[UIButton alloc]init];
        [self addSubview:_leftButton];
        [_leftButton setImage:[UIImage imageNamed:@"search-back"] forState:UIControlStateNormal];

        _searchBg = [[UIImageView alloc]init];
        [self addSubview:_searchBg];
        _searchBg.image = [UIImage imageNamed:@"searchBg"];

        _dropDownButton = [[UIButton alloc]init];
        [self addSubview:_dropDownButton];
        [_dropDownButton setTitle:@"淘宝" forState:UIControlStateNormal];
        _dropDownButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:14.0f];
        [_dropDownButton setTitleColor:[UIColor colorWithString:@"rgb(180,41,44)"] forState:UIControlStateNormal];

        _pinkArrow = [[UIImageView alloc]init];
        [self addSubview:_pinkArrow];
        _pinkArrow.image = [UIImage imageNamed:@"pinkArrow"];

        _textField = [[UITextField alloc]init];
        _textField.placeholder = @"搜索关键词或粘贴标题";
        _textField.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:14.0f];
        _textField.textColor = [UIColor colorWithString:@"rgb(79,79,79)"];
        [self addSubview:_textField];

        _searchIcon = [[UIImageView alloc]init];
        [self addSubview:_searchIcon];
        _searchIcon.image = [UIImage imageNamed:@"search"];

        [self loadAutoLayout];
    }
    return self;
}

-(void)loadAutoLayout{
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0.0f);
        make.left.equalTo(self).offset(0.0f);
        make.right.equalTo(self).offset(0.0f);
        make.bottom.equalTo(self).offset(0.0f);
	    }];

    [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-7.0f);
        make.left.equalTo(self).offset(15.0f);
        make.width.equalTo(@30.0f);
        make.height.equalTo(@30.0f);
	    }];

    [_searchBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftButton).offset(0.0f);
        make.left.equalTo(self.leftButton.mas_right).offset(15.0f);
        make.right.equalTo(self).offset(-15.0f);
	    }];

    [_dropDownButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchBg).offset(0.0f);
        make.left.equalTo(self.searchBg).offset(0.0f);
        make.bottom.equalTo(self.searchBg).offset(0.0f);
        make.width.equalTo(@50.0f);
	    }];

    [_pinkArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.dropDownButton).offset(0.0f);
        make.left.equalTo(self.dropDownButton.mas_right).offset(-4.0f);
	    }];

    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pinkArrow.mas_right).offset(10.0f);
        make.top.equalTo(self.searchBg).offset(0.0f);
        make.bottom.equalTo(self.searchBg).offset(0.0f);
        make.width.greaterThanOrEqualTo(@150.0f);
	    }];

    [_searchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.searchBg).offset(-8.0f);
        make.centerY.equalTo(self.searchBg).offset(0.0f);
        make.left.equalTo(self.textField.mas_right).offset(8.0f);
	    }];
}
@end
	
