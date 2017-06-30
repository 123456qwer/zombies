//
//  JYWeaponCommand.m
//  Zombies
//
//  Created by 吴冬 on 2017/6/30.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import "JYWeaponCommand.h"
@implementation JYWeaponCommand

- (instancetype)initWithSender:(FireBtn *)sender
{   
    return self;
}

- (void)execute{}
- (void)rollBackExecute{}
- (void)setSkillTimes:(int)times{}
- (void)setKillZomNumber:(int)count{}
- (void)setSkillType:(PersonSkillType)type{}

@end
