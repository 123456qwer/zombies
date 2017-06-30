//
//  Weapon1.m
//  Zombies
//
//  Created by 吴冬 on 2017/6/30.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import "Weapon1.h"
#import "FireBtn.h"

@implementation Weapon1
{
    FireBtn *_sender;
    PersonSkillType _skillType;
}

- (instancetype)initWithSender:(FireBtn *)sender 
{
    if (self = [super init]) {
        
        _sender = sender;
    }
    
    return self;
}

- (void)execute{

    [_sender addTimeLabel];
    
    JYSkillList *skill = [JYSkillList shareList];
    [skill skill:_skillType];
    
    
    _sender.userInteractionEnabled = NO;
    _sender.alpha = 0.5;
}

- (void)rollBackExecute{
 
    JYSkillList *skill = [JYSkillList shareList];
    [skill rollBackSkill:_skillType];
    
    
    _sender.userInteractionEnabled = NO;
    _sender.alpha = 0.1;
}

- (void)setSkillType:(PersonSkillType)type
{
    _skillType = type;
    NSDictionary *dic = [[JYSkillList shareList] skillTimesAndKillZomNumber:type];
    
    
    [self setSkillTimes:[dic[kSkillCD]intValue]];
    [self setKillZomNumber:[dic[kKillZomNumber]intValue]];
}

- (void)setSkillTimes:(int)times
{
    [_sender setTimes:times];
}

- (void)setKillZomNumber:(int)count
{
    [_sender setZomsNumber:count];
}

@end
