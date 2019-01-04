//
//  ProductLikeCell.h
//  lianmeng
//
//  Created by zhufeng on 2019/1/3.
//  Copyright © 2019 zhuchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductLikeCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon_img;
@property (weak, nonatomic) IBOutlet UILabel *name_lab;
@property (weak, nonatomic) IBOutlet UILabel *subtitle_lab;
@property (weak, nonatomic) IBOutlet UILabel *maijia_lab;
@property (weak, nonatomic) IBOutlet UILabel *wuliu_lab;
@property (weak, nonatomic) IBOutlet UILabel *baobei_lab;
@end
