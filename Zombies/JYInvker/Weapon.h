//
//  Weapon1.h
//  Zombies
//
//  Created by 吴冬 on 2017/6/30.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import "JYWeaponCommand.h"

@interface Weapon : JYWeaponCommand

//僵尸死亡数目与地图同步
- (void)diedZomNumber:(int)count;

@end
