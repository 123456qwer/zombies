//
//  JYLoginScene.h
//  Zombies
//
//  Created by 吴冬 on 17/4/10.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import "JYBaseScene.h"
@interface JYLoginScene : JYBaseScene

@property (nonatomic ,copy)void (^startWithLevelName)(NSString *mapName ,NSString *personName);

@end
