//
//  NormalZombies.h
//  Zombies
//
//  Created by 吴冬 on 17/4/13.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import "BaseZombiesNode.h"
#import "PersonNode.h"
@interface NormalZombies : BaseZombiesNode

//初始化僵尸
- (NormalZombies *)initZombiesNodeWithPerson:(PersonNode *)personNode
                                       level:(zomLevel)level;


- (void)setBodyAndPosition:(NSMutableArray *)bornArr;


//僵尸攻击
- (void)attackActionWithPerson:(PersonNode *)person
                    Completion:(void (^)(BOOL))block;


//僵尸移动
- (void)zomMoveWithPerson:(PersonNode *)person;
@end
