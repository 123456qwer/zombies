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
            dic = @{kSkillCD:@(5),kKillZomNumber:@(5),kSkillImage:image};
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
            [self changeSpeed:_personNode.speeds + 2];
        }
            break;
            case Attack:
        {
            [self changeFirePower:2];
        }
            break;
            case Attack_distance:
        {
            [self changeFireDistance:300];
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
            [self changeSpeed:_personNode.speeds - 2];
        }
            break;
        case Attack:
        {
            [self changeFirePower:1];
        }
            break;
        case Attack_distance:
        {
            [self changeFireDistance:170];
        }
            break;
            
        default:
            break;
    }
}




#pragma mark -主动技能

- (void)changeSpeed:(int)speed
{
    _personNode.speeds = speed;
}

- (void)changeFirePower:(int)power
{
    _personNode.attack = power;
}

- (void)changeFireDistance:(int)distance
{
    _personNode.attack_distance = distance;
}

#pragma mark -被动技能
- (void)passiveChangeSpeed:(int)speed
{
    if (!_passiveChangeSpeed) {
        _personNode.speeds += speed;
        //10秒CD
        [self performSelector:@selector(returnSpeed:) withObject:@(speed) afterDelay:10];
        _passiveChangeSpeed = NO;
    }
    
}

- (void)returnSpeed:(id)speed
{
    
    int speeds = [speed floatValue];
    NSLog(@"%d",speeds);
    
//    NSLog(@"%@",[NSThread currentThread]);
//    NSLog(@"%@",_personNode);
    
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
