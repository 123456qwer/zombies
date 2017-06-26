//
//  FireBtn.h
//  Zombies
//
//  Created by 吴冬 on 17/4/18.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, SkillType) {
    RockSkill = 1,
};


@interface FireBtn : UIButton

@property (nonatomic ,copy)void (^selectBlock)(UIButton *);
@property (nonatomic ,copy)void (^endBlock)(UIButton *);

@property (nonatomic ,copy)void (^endSkillBlock)();
@property (nonatomic ,assign)SkillType skillType;

- (void)canUse:(BOOL)canUse;
- (void)addTimeLabel;
- (void)setTimes:(int)time;

@end