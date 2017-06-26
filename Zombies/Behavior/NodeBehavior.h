//
//  NodeBehavior.h
//  Zombies
//
//  Created by 吴冬 on 17/4/20.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NodeBehavior : NSObject

@property (nonatomic ,copy)void (^finishConnonFire)();


- (void)died:(NSDictionary *)dic;
- (void)attack:(NSDictionary *)dic;

- (BOOL)beAttack:(NSDictionary *)dic;
- (void)stopMove:(NSDictionary *)dic;
- (void)move:(NSDictionary *)dic;

- (void)connonFire:(NSDictionary *)dic;

- (CGPoint )setBGPositionWithPersonNode:(CGPoint)point;
- (void)setBGarrWithX:(NSMutableArray *)xArr y:(NSMutableArray *)yArr;

@end
