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
            dic = @{kSkillCD:@(5),kKillZomNumber:@(5)};
        }
            break;
            case Attack:
        {
            dic = @{kSkillCD:@(10),kKillZomNumber:@(10)};
        }
            break;
         case Attack_distance:
        {
            dic = @{kSkillCD:@(7),kKillZomNumber:@(7)};
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
            [self changeSpeed:5];
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
            [self changeSpeed:3];
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


@end
