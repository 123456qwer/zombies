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

//人物属性
@property (nonatomic ,assign)int blood;   //血量
@property (nonatomic ,assign)int attack;  //攻击力
@property (nonatomic ,assign)int speeds;  //移速
@property (nonatomic ,assign)int attack_distance; //攻击距离
@property (nonatomic ,assign)int fire_impact;  //子弹冲击力
@property (nonatomic ,assign)BOOL isFire;


//被动天赋
@property (nonatomic ,assign)int beatOff;  //击退
@property (nonatomic ,assign)int dizzy;    //击晕
@property (nonatomic ,assign)int passiveSpeeds; //杀死僵尸加速



//僵尸属性
@property (nonatomic ,assign)BOOL isRedZom;  //红头僵尸
@property (nonatomic ,assign)BOOL isAttack;  //是否正在攻击
@property (nonatomic ,assign)int stiff;   //硬直


//人类、僵尸行为
@property (nonatomic ,strong)NodeBehavior *nodeBehavior;
//移动方向(朝向)
@property (nonatomic ,copy)NSString *direction;


- (void)died:(id)personNode;

@end
