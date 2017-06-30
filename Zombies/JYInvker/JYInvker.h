//
//  JYInvker.h
//  Zombies
//
//  Created by 吴冬 on 2017/6/30.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol InvkerProtocol <NSObject>

//执行任务相关
- (void)execute;
- (void)rollBackExecute;

//初始化玩家选择的技能
- (void)setSkillTimes:(int)times;
- (void)setKillZomNumber:(int)count;
- (void)setSkillType:(PersonSkillType)type;

@end

@interface JYInvker : NSObject
+ (JYInvker *)shareInvker;

- (void)executeWithIndex:(int)index; //执行
- (void)rollBackExecute:(int)index;  //撤销

@property (nonatomic ,strong)NSMutableArray *commandList;

@end
