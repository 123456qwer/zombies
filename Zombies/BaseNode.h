//
//  BaseNode.h
//  Zombies
//
//  Created by 吴冬 on 17/4/14.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "NodeBehavior.h"
#import "ZombiesBehavior.h"
#import "PersonBehavior.h"

@interface BaseNode : SKSpriteNode
@property (nonatomic ,assign)int blood;
@property (nonatomic ,assign)int attack;
@property (nonatomic ,assign)int speeds;
@property (nonatomic ,assign)int stiff;
@property (nonatomic ,assign)int attack_distance;

@property (nonatomic ,assign)BOOL isRedZom;
@property (nonatomic ,assign)BOOL isAttack;

@property (nonatomic ,assign)BOOL isFire;

@property (nonatomic ,strong)NodeBehavior *nodeBehavior;

@property (nonatomic ,copy)NSString *direction;


- (void)died:(NSMutableArray *)dieArr;

@end
