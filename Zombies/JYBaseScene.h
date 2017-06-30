//
//  JYBaseScene.h
//  Zombies
//
//  Created by 吴冬 on 17/4/10.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface JYBaseScene : SKScene

@property (nonatomic ,assign)BOOL isAlreadyCreate;
@property (nonatomic ,copy)NSString *personName;

@property (nonatomic ,copy)void (^gameOver)();
@property (nonatomic ,copy)void (^startGame)();


@property (nonatomic ,copy)void (^diedZomNumber)(int count);

//行走、停止
- (void)moveAction:(NSString *)key speed:(CGFloat )speed;
- (void)stopAction;
- (void)fire;

- (void)weaponWithIndex:(int)index;
@end
