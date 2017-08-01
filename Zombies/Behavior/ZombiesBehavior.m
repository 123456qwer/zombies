//
//  ZombiesBehavior.m
//  Zombies
//
//  Created by 吴冬 on 17/4/20.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import "ZombiesBehavior.h"

@implementation ZombiesBehavior

- (BOOL)beAttack:(NSDictionary *)dic
{
    JYSkillList *skill = [JYSkillList shareList];

    
    NormalZombies *zomNode = dic[kNode];
    PersonNode    *perNode = dic[kPerNode];
    
    arc4random() % 100 < perNode.beatOff ? [skill passiveBeatOffZom:100] : (0);
    
    
    [zomNode removeAllActions];
    
    zomNode.blood -= perNode.attack;
    
    
    zomNode.direction = [CalculateDistance oppositeDirection:perNode.direction];
    CGPoint point = [CalculateDistance movePointWithSpeed:-perNode.fire_impact direction:zomNode.direction point:zomNode];
    SKAction *moveAction = [SKAction moveTo:point duration:0.2];
    
    zomNode.texture = [_moveDic objectForKey:zomNode.direction][0];
    zomNode.zPosition = 3 * kScreenHeight - point.y * y_Scale;
    
    perNode.fire_impact = 3.0;
    
    [zomNode runAction:moveAction completion:^{
        zomNode.direction = nil;
    }];
    
    return NO;
}

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
            //闪现攻击miss
            if (!perNode.isContact) {
                [zom setLabelText:@"MISS"];
            }else{
                isGameOver = [perNode beAttackWithZomDirection:zom.direction];
            }
        }else{
            [zom setLabelText:@"MISS"];
        }
        
        
        if (block) {
            block(isGameOver);
        }
    }];
}

- (void)died:(NSDictionary *)dic
{
    PersonNode *personNode = [dic objectForKey:kPerNode];

    JYSkillList *skill = [JYSkillList shareList];
    arc4random() % 100 < personNode.passiveSpeeds ? [skill passiveChangeSpeed:0.5] : (0);
    
    
    
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
