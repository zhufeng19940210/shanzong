
#import <UIKit/UIKit.h>
#import <EasyIOS/EasyIOS.h>
#import "GoodsListModel.h"

@protocol DetailDelegate
-(void)buyAction;
-(void)shareAction;
@end

@interface DetailBottomView : UIView
@property(nonatomic,retain)GoodsModel *model;
@property(nonatomic,weak)id<DetailDelegate> delegate;
@end
	
