//
//  NodeBehavior.m
//  Zombies
//
//  Created by 吴冬 on 17/4/20.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import "NodeBehavior.h"

@implementation NodeBehavior
- (void)died:(NSDictionary *)dic{}
- (void)move:(NSDictionary *)dic{}
- (void)stopMove:(NSDictionary *)dic{}
- (void)attack:(NSDictionary *)dic{}
- (BOOL)beAttack:(NSDictionary *)dic{
    return NO;
}
- (void)connonFire:(NSDictionary *)dic{}

- (CGPoint )setBGPositionWithPersonNode:(CGPoint)point{
    return CGPointMake(0, 0);
}
- (void)setBGarrWithX:(NSMutableArray *)xArr y:(NSMutableArray *)yArr{}

@end
