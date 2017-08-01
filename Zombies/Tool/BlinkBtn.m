//
//  BlinkBtn.m
//  Zombies
//
//  Created by 吴冬 on 2017/7/5.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import "BlinkBtn.h"

@implementation BlinkBtn
{
    int _changeTime;
    int _cdTime;
    NSTimer *_timer;
    UILabel *_timeLabel;
}


- (void)gameOver
{
    [_timer invalidate];
    _timer = nil;
    
    [_timeLabel removeFromSuperview];
    _changeTime = _cdTime;
    
    [self canUse];
};

- (void)setTimes:(int)time
{
    _changeTime = time;
    _cdTime     = time;
}

- (void)addTimeLabel
{
    [self canNotUse];
    
    UIColor *textColor = [UIColor yellowColor];

    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _timeLabel.textColor = textColor;
    _timeLabel.font = [UIFont boldSystemFontOfSize:25];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_timeLabel];
    _timeLabel.text = [NSString stringWithFormat:@"%d",_changeTime];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(weaponTimes:) userInfo:_timeLabel repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];

}

- (void)weaponTimes:(NSTimer *)timer
{
    _changeTime --;
    if (_changeTime < 0) {
        
        [self gameOver];
        
        return;
    }
    
    _timeLabel.text = [NSString stringWithFormat:@"%d",_changeTime];
    
}

@end
