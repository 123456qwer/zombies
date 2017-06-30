//
//  SkillAnimationTime.h
//  Zombies
//
//  Created by 吴冬 on 17/5/11.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonNode.h"
#import "FireBtn.h"




@interface SkillAnimationTime : NSObject

+ (SkillAnimationTime *)share;
- (void)createAnimationTime;



@property (nonatomic ,assign)CGFloat rocketAnimationTime;
@property (nonatomic ,assign)CGFloat rocketWaitTime;

@property (nonatomic ,strong)UIButton *weaponBtn;



#pragma mark 释放技能
- (void)weaponAction:(FireBtn *)fireBtn;


#pragma mark 技能动画
- (void )rocketAction:(PersonNode *)node
                  dic:(NSMutableDictionary *)perDic
          finishBlock:(void (^)(int skillCount))finishAnimation;

@end
