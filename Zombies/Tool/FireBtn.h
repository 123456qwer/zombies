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

@property (nonatomic ,assign)int index;

@property (nonatomic ,copy)void (^selectBlock)(UIButton *);
@property (nonatomic ,copy)void (^endBlock)(UIButton *);

@property (nonatomic ,copy)void (^endSkillBlock)();
@property (nonatomic ,assign)SkillType skillType;
@property (nonatomic ,strong)UIImageView *skillImage;

- (void)gameOver;

- (void)addTimeLabel;
- (void)setTimes:(int)time;
- (void)setZomsNumber:(int)number;
- (void)setImage:(UIImage *)image;

- (void)diedZomNumber:(int)diedZomNumber;

@end
