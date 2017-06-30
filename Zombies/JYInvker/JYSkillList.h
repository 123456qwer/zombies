//
//  JYSkillList.h
//  Zombies
//
//  Created by 吴冬 on 2017/6/30.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface JYSkillList : NSObject

+ (JYSkillList *)shareList;

@property (nonatomic ,strong)PersonNode *personNode;


- (void)skill:(PersonSkillType)type;
- (void)rollBackSkill:(PersonSkillType)type;


//技能触发所需条件、CD
- (NSDictionary *)skillTimesAndKillZomNumber:(PersonSkillType)type;


//改变人物移动速度
- (void)changeSpeed:(int)speed;

//改变攻击力
- (void)changeFirePower:(int)power;

//改变攻击距离
- (void)changeFireDistance:(int)distance;

@end
