//
//  JYSkillList.m
//  Zombies
//
//  Created by 吴冬 on 2017/6/30.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import "JYSkillList.h"
static JYSkillList *skillList = nil;
@implementation JYSkillList
+ (JYSkillList *)shareList
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (skillList == nil) {
            skillList = [[JYSkillList alloc] init];
        }
    });
    
    return skillList;
}

- (NSDictionary *)skillTimesAndKillZomNumber:(PersonSkillType)type
{
    NSDictionary *dic;
    switch (type) {
        case Speed:
        {
            UIImage *image = [UIImage imageNamed:@"addSpeed.jpg"];
            dic = @{kSkillCD:@(1),kKillZomNumber:@(1),kSkillImage:image};
        }
            break;
            case Attack:
        {
            UIImage *image = [UIImage imageNamed:@"addAttack.jpg"];
            dic = @{kSkillCD:@(5),kKillZomNumber:@(10),kSkillImage:image};
        }
            break;
         case Attack_distance:
        {
            UIImage *image = [UIImage imageNamed:@"addDistance.jpg"];
            dic = @{kSkillCD:@(5),kKillZomNumber:@(7),kSkillImage:image};
        }
            break;
            case blink:
        {
            UIImage *image = [UIImage imageNamed:@"blink.jpg"];
            dic = @{kSkillCD:@(20),kKillZomNumber:@(0),kSkillImage:image};
        }
            break;
            
        default:
            break;
    }
    
    return dic;
    
}


- (void)skill:(PersonSkillType)type
{
    switch (type) {
        case Speed:
        {
            [self changeSpeed:_personNode.speeds + 1];
            NSLog(@"移速主动增加");
        }
            break;
            case Attack:
        {
            [self changeFirePower:2];
            NSLog(@"攻击力主动增加");
        }
            break;
            case Attack_distance:
        {
            [self changeFireDistance:300];
            NSLog(@"攻击距离主动增加");
        }
            break;
            case blink:
        {
            [self blink];
        }
            break;
            
        default:
            break;
    }
}



- (void)rollBackSkill:(PersonSkillType)type
{
    switch (type) {
        case Speed:
        {
            [self changeSpeed:_personNode.speeds - 1];
            NSLog(@"移动速度主动减少");
        }
            break;
        case Attack:
        {
            [self changeFirePower:1];
            NSLog(@"攻击力主动减少");
        }
            break;
        case Attack_distance:
        {
            [self changeFireDistance:170];
            NSLog(@"攻击距离主动减少");
        }
            break;
            
        default:
            break;
    }
}




#pragma mark -主动技能

- (void)blink
{
    
     [_personNode removeAllActions];
     
     _personNode.isContact = NO;
     CGPoint point = [CalculateDistance movePointWithSpeed:200.f direction:_personNode.direction point:_personNode];
     
     SKAction *hide = [SKAction fadeAlphaTo:0 duration:0.1];
     SKAction *moveAction = [SKAction moveTo:point duration:.3];
     SKAction *appear = [SKAction fadeAlphaTo:1 duration:0.1];
     
     SKAction *seq = [SKAction sequence:@[hide,moveAction,appear]];
     
     [_personNode runAction:seq completion:^{
     _personNode.isContact = YES;
     }];
     
}

- (void)changeSpeed:(CGFloat)speed
{
    _personNode.speeds = speed;
}

- (void)changeFirePower:(CGFloat)power
{
    _personNode.attack = power;
}

- (void)changeFireDistance:(CGFloat)distance
{
    _personNode.attack_distance = distance;
}



#pragma mark -被动技能
- (void)passiveChangeSpeed:(CGFloat)speed
{
    if (!_passiveChangeSpeed) {
        _personNode.speeds += speed;
        //10秒CD
        [self performSelector:@selector(returnSpeed:) withObject:@(speed) afterDelay:10];
        _passiveChangeSpeed = YES;
        NSLog(@"移速被动增加");
    }
    
}

- (void)returnSpeed:(id)speed
{
    CGFloat speeds = [speed floatValue];
    NSLog(@"移速被动减少");
    _passiveChangeSpeed = NO;
    _personNode.speeds -= speeds;
}

//25%概率击晕僵尸
- (void)passiveDizzyZom
{
    
}


- (void)passiveBeatOffZom:(int)impact
{
    _personNode.fire_impact = impact;
}




@end
