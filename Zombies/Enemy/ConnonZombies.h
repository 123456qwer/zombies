//
//  ConnonZombies.h
//  Zombies
//
//  Created by 吴冬 on 2017/6/22.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import "BaseZombiesNode.h"

@interface ConnonZombies : BaseZombiesNode

- (ConnonZombies *)initConnonNodeWithPersonNode:(PersonNode *)personNode;

- (void)reloadFireAction;

@end
