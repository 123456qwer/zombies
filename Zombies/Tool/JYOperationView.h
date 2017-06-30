//
//  JYOperationView.h
//  Zombies
//
//  Created by 吴冬 on 17/4/11.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYOperationView : UIView

@property (nonatomic ,copy)void (^moveBlock)(NSString *direction , CGFloat speed);
@property (nonatomic ,copy)void (^stopBlock)();
@property (nonatomic ,assign)BOOL canUse;


@end
