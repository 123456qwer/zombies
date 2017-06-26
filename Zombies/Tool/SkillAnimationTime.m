//
//  SkillAnimationTime.m
//  Zombies
//
//  Created by 吴冬 on 17/5/11.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import "SkillAnimationTime.h"
static SkillAnimationTime *manager = nil;
@implementation SkillAnimationTime
{
    CGFloat _rocketTime;
}

+ (SkillAnimationTime *)share
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[SkillAnimationTime alloc] init];
        }
    });
    
    return manager;
}

- (void)createAnimationTime
{
    _rocketTime = 1.2;
    _rocketWaitTime = 0.0;
}

- (void)weaponAction:(FireBtn *)fireBtn
{
   
    //技能列表
    switch (fireBtn.skillType) {
        case RockSkill:
        {
            [fireBtn addTimeLabel];
            [fireBtn setTimes:_rocketWaitTime];
        }
            break;
            
        default:
            break;
    }
    
  
}


- (void )rocketAction:(PersonNode *)node
                  dic:(NSMutableDictionary *)perDic
          finishBlock:(void (^)(int skillCount))finishAnimation
{
    NSMutableArray *arraa = [CutPictureTool cutImage:[UIImage imageNamed:@"blink_l"] size:CGSizeMake(960, 2320 / 12.0) line:12 arrange:1];
    
    
    SKAction *ac = [SKAction animateWithTextures:arraa timePerFrame:0.1];
    
    NSDictionary *dic = [CalculateDistance blinkZrotation:node.direction speed:100 personPoint:node.position];
    
    CGPoint p = CGPointMake([dic[@"x"]floatValue], [dic[@"y"]floatValue]);
    
   
    
//    CGPoint g_p = [node.nodeBehavior setBGPositionWithPersonNode:p];
//    SKAction *g_move = [SKAction moveTo:g_p duration:5 * 0.1];
//    SKAction *g_wait = [SKAction waitForDuration:7 * 0.1];
//    SKAction *g_seq  = [SKAction sequence:@[g_wait,g_move]];
//    [node.mapNode runAction:g_seq];
    
    CGFloat zRotation = [dic[@"r"]floatValue];
    SKAction *move = [SKAction moveTo:p duration:5 * 0.1];
    SKAction *wait = [SKAction waitForDuration:7 * 0.1];
    SKAction *seqAction = [SKAction sequence:@[wait,move]];
    SKAction *grp = [SKAction group:@[ac,seqAction]];
    node.isBlink = YES;
    node.zRotation = zRotation;
    node.xScale = 8.0;
    node.yScale = 3.0;
    node.bloodNode.hidden = YES;
    
    
    [node runAction:grp completion:^{
        
        [node.nodeBehavior setBGPositionWithPersonNode:node.position];
        NSMutableDictionary *perDic = [node.nodeBehavior valueForKey:@"moveDic"];
        node.texture = perDic[node.direction][0];
        [node removeAllActions];
        node.isBlink = NO;
        node.xScale = 1.0;
        node.yScale = 1.0;
        node.zRotation = 0;
        node.bloodNode.hidden = NO;
        
        finishAnimation(-1);
    }];

    
}

@end
