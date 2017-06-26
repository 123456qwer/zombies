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
    int       _weaponTime;
}

- (void)weaponTimes:(NSTimer *)timer
{
    UILabel *label = timer.userInfo;
    
    self.alpha = 0.1;
    _weaponTime --;
    if (_weaponTime < 0) {
        
        [timer invalidate];
        [label removeFromSuperview];
        
        _weaponTime = 0;
        [self canUse:YES];
        
        return;
    }
    
    label.text = [NSString stringWithFormat:@"%d",_weaponTime];
}

- (void)addTimeLabel
{
    if (_weaponTime != 0) {
        return;
    }
    
    
    [self canUse:NO];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    timeLabel.textColor = [UIColor orangeColor];
    timeLabel.font = [UIFont boldSystemFontOfSize:25];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:timeLabel];
   
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(weaponTimes:) userInfo:timeLabel repeats:YES];
}




- (void)setTimes:(int)time
{
    _weaponTime = time;
}



- (void)canUse:(BOOL)canUse
{
    if (canUse) {
        self.alpha = 0.5;
        self.userInteractionEnabled = YES;
    }else{
        self.alpha = 0.1;
        self.userInteractionEnabled = NO;
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
