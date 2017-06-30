//
//  PersonBehavior.m
//  Zombies
//
//  Created by 吴冬 on 17/4/20.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import "PersonBehavior.h"

@implementation PersonBehavior

- (void)weapon1{}



- (BOOL)beAttack:(NSDictionary *)dic
{
    PersonNode *node = dic[kNode];
    NSString *direction = dic[@"direction"];
    int subractBlood = [dic[@"blood"]intValue];
    
    node.blood -= subractBlood;
    if (node.blood <= 0) {
        [node removeFromParent];
        return YES;
    }
    
    //击飞
    node.direction = [CalculateDistance oppositeDirection:direction];
    
    CGPoint point = [CalculateDistance movePointWithSpeed:-30.f direction:node.direction point:node];
    SKAction *moveAction = [SKAction moveTo:point duration:0.2];
    
    node.texture = [_moveDic objectForKey:node.direction][0];
    node.zPosition = 3 * kScreenHeight - point.y * y_Scale;

    [node runAction:moveAction];
    

    
    
    
    int index = fabs(node.blood - 10);
    node.bloodNode.texture = node.bloodArr[index];
    [node changeFireDirection];
    
    return NO;
}

- (void)died:(NSDictionary *)dic
{
}

- (void)move:(NSDictionary *)dic
{
    PersonNode *node = dic[kNode];
    NSString *key = dic[@"key"];
 
   
    //人物移动
    node.position = [CalculateDistance movePointWithSpeed:node.speeds direction:key point:node];
    NSLog(@"x:%lf  y:%lf",node.position.x,node.position.y);

    
    node.texture = [_moveDic objectForKey:key][0];
    node.zPosition = 3 * kScreenHeight - node.position.y * y_Scale;
    
    node.fireNode.zPosition = node.zPosition - 1;

    if (![node.direction isEqualToString:key] || node.isStopMove) {
        
        node.direction = key;
        [node changeFireDirection];
        [node removeAllActions];
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:2];
        
        for (int i = 1; i < 3; i++) {
            [arr addObject:[_moveDic objectForKey:key][i]];
        }
        
        SKAction *moveA = [SKAction animateWithTextures:arr timePerFrame:0.2];
        SKAction *rep = [SKAction repeatActionForever:moveA];
        
        [node runAction:rep];
    }
    
    node.isStopMove = NO;
}

- (void)stopMove:(NSDictionary *)dic
{
    PersonNode *node = dic[kNode];
  
    node.isStopMove = YES;
    [node removeAllActions];
    node.texture = [_moveDic objectForKey:node.direction][0];
}

- (CGPoint )setBGPositionWithPersonNode:(CGPoint)point
{
    int x = (int)point.x;
    int y = (int)point.y;
    
    CGFloat bg_X = [_bg_xArr[x] floatValue];
    CGFloat bg_Y = [_bg_yArr[y] floatValue];
   
    return CGPointMake(bg_X, bg_Y);
}

- (void)setBGarrWithX:(NSMutableArray *)xArr y:(NSMutableArray *)yArr
{
    _bg_xArr = xArr;
    _bg_yArr = yArr;
}



@end
