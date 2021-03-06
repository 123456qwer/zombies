//
//  Weapon1.m
//  Zombies
//
//  Created by 吴冬 on 2017/6/30.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import "Weapon.h"
#import "FireBtn.h"

@implementation Weapon
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
  
}

- (void)rollBackExecute{
 
    JYSkillList *skill = [JYSkillList shareList];
    [skill rollBackSkill:_skillType];
    
    [_sender gameOver];
}

- (void)setSkillType:(PersonSkillType)type
{
    _skillType = type;
    NSDictionary *dic = [[JYSkillList shareList] skillTimesAndKillZomNumber:type];
    
    [self setSkillTimes:[dic[kSkillCD]intValue]];
    [self setKillZomNumber:[dic[kKillZomNumber]intValue]];
    [self setSkillImage:dic[kSkillImage]];    
}


- (void)diedZomNumber:(int)count
{
    [_sender diedZomNumber:count];
}




- (void)setSkillImage:(UIImage *)image
{
    [_sender setImage:image];
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
