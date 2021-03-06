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



#pragma mark 公用
- (void)setSkillTimer:(int)times
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(skillTimes:) userInfo:@(times) repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)skillTimes:(NSTimer *)timer
{
    int times = [timer.userInfo intValue];
    times --;
    if (times < 0) {
        return;
    }
    if (_skillTimes) {
        _skillTimes(times);
    }
}





@end
