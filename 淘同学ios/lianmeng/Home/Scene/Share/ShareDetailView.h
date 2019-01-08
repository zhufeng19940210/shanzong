
#import <UIKit/UIKit.h>
#import <EasyIOS/EasyIOS.h>
#import "GoodsListModel.h"
#import "CircleListModel.h"
@interface ShareDetailView : UIView
-(void)reloadData:(GoodsModel *)model;
-(void)reloadDataCircle:(CircleModel *)model;
@end
