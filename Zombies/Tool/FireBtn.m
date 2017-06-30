//
//  FireBtn.m
//  Zombies
//
//  Created by 吴冬 on 17/4/18.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import "FireBtn.h"

@implementation FireBtn

{
    NSTimer  *_weaponTimer;
    int       _animationTime;
    int       _changeTimes;
    int       _cdTime;
    int       _zomNumber;
    BOOL      _timeChange;
}

- (void)gameOver
{
    self.userInteractionEnabled = NO;
    self.alpha = 0.1;
    
    _timeChange = NO;
    _changeTimes = _cdTime;
}

- (void)weaponTimes:(NSTimer *)timer
{
    UILabel *label = timer.userInfo;
    
    //避免gameOver还在走timer
    if (!_timeChange) {
        [timer invalidate];
        timer = nil;
        [label removeFromSuperview];
        _changeTimes = _cdTime;
        return;
    }
    
    _changeTimes --;
    if (_changeTimes < 0) {
        
        [timer invalidate];
        timer = nil;
        [label removeFromSuperview];
        
        _changeTimes = _cdTime;

        JYInvker *invker = [JYInvker shareInvker];
        [invker rollBackExecute:_index];
        
        _timeChange = NO;
        return;
    }
    
    label.text = [NSString stringWithFormat:@"%d",_changeTimes];
}

- (void)addTimeLabel
{
    UIColor *textColor ;
    if (_index == 2) {
        textColor = [UIColor redColor];
    }else if(_index == 1){
        textColor = [UIColor blackColor];
    }else{
        textColor = [UIColor yellowColor];
    }
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    timeLabel.textColor = textColor;
    timeLabel.font = [UIFont boldSystemFontOfSize:25];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:timeLabel];
   
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(weaponTimes:) userInfo:timeLabel repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

}

- (void)setTimes:(int)time
{
    _changeTimes = time;
    _cdTime      = time;
}


- (void)setZomsNumber:(int)number
{
    _zomNumber = number;
}



- (void)diedZomNumber:(int)diedZomNumber
{
    //可用状态不计数
    if (self.userInteractionEnabled || _timeChange) {
        return;
    }
    
    
    
    int number = diedZomNumber % _zomNumber;
    
    NSLog(@"%d",number);
   
    
    if (number == 0) {
            self.userInteractionEnabled = YES;
            self.alpha = 0.5;
        _timeChange = YES;
    }else{
            self.userInteractionEnabled = NO;
        _timeChange = NO;
    }
    
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.alpha = 0.5;
    
    if (_endBlock) {
        _endBlock(self);
    }
    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.alpha = 0.1;
    
    if (_selectBlock) {
        _selectBlock(self);
    }
}

@end
