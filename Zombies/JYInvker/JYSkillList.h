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

//主动技能
//闪现
- (void)blink;



//改变人物移动速度
- (void)changeSpeed:(CGFloat)speed;

//改变攻击力
- (void)changeFirePower:(CGFloat)power;

//改变攻击距离
- (void)changeFireDistance:(CGFloat)distance;





//被动技能
//10概率增加移速 1
- (void)passiveChangeSpeed:(CGFloat)speed;
@property (nonatomic ,assign)BOOL passiveChangeSpeed;

//10%概率击晕僵尸
- (void)passiveDizzyZom;

//10%概率击退僵尸
- (void)passiveBeatOffZom:(int)impact;

@end
