
#import <UIKit/UIKit.h>
#import <EasyIOS/EasyIOS.h>
#import "GoodsListModel.h"

@protocol DetailHeaderViewDelegate
-(void)buyAction;
@end
@interface DetailHeaderView : UIView

@property(nonatomic,retain)GoodsModel *model;
@property(nonatomic,assign)id<DetailHeaderViewDelegate> delegate;

@end
	
