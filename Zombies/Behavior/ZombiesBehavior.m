//
//  ZombiesBehavior.m
//  Zombies
//
//  Created by 吴冬 on 17/4/20.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import "ZombiesBehavior.h"

@implementation ZombiesBehavior

- (void)attack:(NSDictionary *)dic
{
    void (^block)() = dic[@"block"];
    NormalZombies *zom = dic[kNode];
    PersonNode    *perNode = dic[@"perNode"];
    
    CGFloat attackTime = 0.2;
    if (zom.isRedZom) {
        attackTime = 0.1;
    }
    if (!zom.direction) {
        zom.direction =[CalculateDistance directionWithPointForZom:zom.position point2:perNode.position];
    }
    
    SKAction *action = [SKAction animateWithTextures:[_attackDic objectForKey:zom.direction] timePerFrame:attackTime];
    zom.isAttack = YES;
    [zom runAction:action completion:^{
        
        CGFloat attackDistance = [CalculateDistance zomAndPersonDistance:zom.position personPoint:perNode.position];
        zom.isAttack = NO;
        BOOL isGameOver = NO;
        if (attackDistance < 30.f) {
            isGameOver = [perNode beAttackWithZomDirection:zom.direction];
        }
        
        if (block) {
            block(isGameOver);
        }
    }];
}

- (void)died:(NSDictionary *)dic
{
    BaseNode *node = [dic objectForKey:kNode];
    
    [node removeAllActions];
    node.isAttack = YES;
    node.physicsBody.dynamic = NO;
   
    
    SKAction *diedAction = [SKAction animateWithTextures:_diedArr timePerFrame:0.2];
    [node runAction:diedAction completion:^{
        [node removeFromParent];
    }];

}

- (void)move:(NSDictionary *)dic
{
    BaseNode *node = [dic objectForKey:kNode];
    PersonNode *perNode = [dic objectForKey:kPerNode];

    
    if (node.isAttack) {
        return;
    }
    
    
    CGFloat animation = 0.4;
    if (node.isRedZom) {
        animation = 0.2;
    }
   
    CGFloat x = perNode.position.x;
    CGFloat y = perNode.position.y;
    CGPoint personPosition = CGPointMake(x, y);
    NSString *keyStr = [CalculateDistance directionWithPointForZom:node.position point2:personPosition];
    
    
  
    if (![node.direction isEqualToString:keyStr]) {
        
        [node removeAllActions];
        node.direction = keyStr;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:2];
        
        for (int i = 1; i < 3; i++) {
            [arr addObject:[_moveDic objectForKey:keyStr][i]];
        }
        
       
        SKAction *moveA = [SKAction animateWithTextures:arr timePerFrame:animation];
        SKAction *rep = [SKAction repeatActionForever:moveA];
        
        [node runAction:rep];
        
    }
    
    node.position = [CalculateDistance movePointWithSpeed:node.speeds direction:keyStr point:node];
    node.zPosition = 3 * kScreenHeight - node.position.y * y_Scale;
}




@end
