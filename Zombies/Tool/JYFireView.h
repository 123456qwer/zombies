//
//  JYFireView.h
//  Zombies
//
//  Created by 吴冬 on 17/4/17.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYFireView : UIView

@property (nonatomic ,copy)void (^fireBlock)();

@property (nonatomic ,copy)void (^weaponBlockWithIndex)(int index);



- (void)setWeapon1ZomNumber:(int)number;
- (void)setWeapon1CDTimes:(int)times;


- (void)diedZomNumber:(int)number;


- (void)weapon1AnimationEnd;

- (void)setFireType:(int)fireType;

@end
