//
//  PersonNode.h
//  Zombies
//
//  Created by 吴冬 on 17/4/14.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import "BaseNode.h"

@interface PersonNode : BaseNode


@property (nonatomic ,strong)SKSpriteNode *fireNode;
@property (nonatomic ,assign)BOOL isStopMove;
@property (nonatomic ,strong)NSMutableArray *bloodArr;
@property (nonatomic ,strong)SKSpriteNode   *bloodNode;
@property (nonatomic ,strong)SKSpriteNode *mapNode;


//设置是否响应碰撞<闪现状态>
@property (nonatomic ,assign)BOOL isContact;

@property (nonatomic ,assign)BOOL isBlink;

- (PersonNode *)initPersonNodeWithBgNode:(SKSpriteNode *)mapNode;




//初始化人物属性
- (void)setBodyAndPosition:(SKSpriteNode *)mapNode;


- (void)changeFireDirection;

//人物死亡
- (void)died;

//被攻击
- (BOOL)beAttackWithZomDirection:(NSString *)direction;

//人物移动
- (void)move:(NSString *)key;


- (void)stopMove;

- (void)weapon1Action:(NSMutableDictionary *)dic;

@end
