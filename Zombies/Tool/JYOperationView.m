//
//  JYOperationView.m
//  Zombies
//
//  Created by 吴冬 on 17/4/11.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import "JYOperationView.h"
#define smallBtn 50 / 750.0 * kScreenWidth
#define bigBtn   150 / 750.0 * kScreenWidth
@implementation JYOperationView
{
    CGPoint _moveLocation;
    CGPoint _startLocation;
    
    BOOL    _isChangeX;
    BOOL    _isChangeY;
    
    UIImageView *_smallCircle;
    UIImageView *_bigCircle;
    NSString    *_keyStr;
    
    NSTimer     *_moveTimer;
    CADisplayLink *_link;
    
    
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
   
        _canUse = YES;
        
        _smallCircle = [UIImageView new];
        _smallCircle.alpha = 0.3;
        _smallCircle.image = [UIImage imageNamed:@"选中"];
        _smallCircle.frame = CGRectMake(-smallBtn, -smallBtn, smallBtn, smallBtn);
        _smallCircle.hidden = YES;
        
      
        _bigCircle   = [UIImageView new];
        _bigCircle.alpha = .3;
        _bigCircle.image = [UIImage imageNamed:@"背景选中"];
        _bigCircle.frame = CGRectMake(0, 0, bigBtn, bigBtn);
        _bigCircle.hidden = YES;
       
        
        [self addSubview:_bigCircle];
        [self addSubview:_smallCircle];

    }
    
    return self;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        
        CGPoint location = [touch locationInView:self];
        
        _smallCircle.center = location;
        _bigCircle.center   = location;
        
        _moveLocation = location;
        _startLocation = location;
        
        _smallCircle.hidden = NO;
        _bigCircle.hidden = NO;
        
    }

}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    if (!_canUse) {
        [_moveTimer invalidate];
        _moveTimer = nil;
        return;
    }
    
    for (UITouch *touch in touches) {
        
        CGPoint location = [touch locationInView:self];
        
        CGFloat BigX = fabs(location.x - _startLocation.x);
        CGFloat BigY = fabs(location.y - _startLocation.y);
        
        CGFloat edge = sqrt(BigX * BigX + BigY * BigY);
        
        CGFloat x_long = 50 / edge * BigX;
        CGFloat y_long = 50 / edge * BigY;
        
        if (edge >= 50) {
            
            if (location.x > _startLocation.x) {
                _moveLocation.x = _startLocation.x + x_long;
            }else{
                _moveLocation.x = _startLocation.x - x_long;
            }
            
            if (location.y > _startLocation.y) {
                _moveLocation.y = _startLocation.y + y_long;
            }else{
                _moveLocation.y = _startLocation.y - y_long;
            }
            
        }else{
            
            _moveLocation.x = location.x;
            _moveLocation.y = location.y;
        }
        
        _smallCircle.center = _moveLocation;
        
        //方向key
        NSString *keyStr = [CalculateDistance directionWithPoint:location point2:_startLocation];
        
        
        if (![_keyStr isEqualToString:keyStr] || !_link) {
            
            _keyStr = keyStr;

            if (!_link) {
                _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(move)];
                [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
            }
        }
             /*
        if (![_keyStr isEqualToString:keyStr] || !_moveTimer) {
            
            _keyStr = keyStr;
            if (!_moveTimer) {
                _moveTimer = [NSTimer scheduledTimerWithTimeInterval:0.016 target:self selector:@selector(move:) userInfo:nil repeats:YES];
            }
        }
         */
         
         
    }
}

- (void)move{
    //传值'
    if (_moveBlock) {
        _moveBlock(_keyStr,1.5f);
    }
}

- (void)move:(NSTimer *)timer
{
    //传值'
    if (_moveBlock) {
        _moveBlock(_keyStr,1.5f);
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!_canUse) {
        return;
    }
    
    _smallCircle.hidden = YES;
    _bigCircle.hidden   = YES;
    
    _link.paused = YES;
    [_link invalidate];
    _link = nil;
    
    [_moveTimer invalidate];
    _moveTimer = nil;
    
    if (_stopBlock) {
        _stopBlock();
    }
}


@end
