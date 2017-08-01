//
//  FireBtn.m
//  Zombies
//
//  Created by 吴冬 on 17/4/18.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import "FireBtn.h"
#import <objc/runtime.h>
#import <ImageIO/ImageIO.h>

#define smallBtn 60 / 750.0 * kScreenWidth
#define speed 45 / 750.0 * kScreenWidth



@implementation FireBtn

{
    NSTimer  *_weaponTimer;
    int       _animationTime;
    int       _changeTimes;
    int       _cdTime;
    int       _zomNumber;
    BOOL      _timeChange;
    int       _zomDiedNumber;
   
    NSTimer  *_timer;
    UILabel  *_timeLabel;
    UIImageView *_animationView;
    
}

- (void)gameOver
{
    [self canNotUse];
    
    _timeChange = NO;
    _changeTimes = _cdTime;
    _zomDiedNumber = 0;
    
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    [_animationView removeFromSuperview];
    [_timeLabel removeFromSuperview];

}


- (void)weaponTimes:(NSTimer *)timer
{
    UILabel *label = timer.userInfo;
    
    //避免gameOver还在走timer
    if (!_timeChange) {
        
        [self gameOver];
        return;
    }
    
    _changeTimes --;
    if (_changeTimes < 0) {
        
        JYInvker *invker = [JYInvker shareInvker];
        [invker rollBackExecute:_index];
        
        return;
    }
    
    label.text = [NSString stringWithFormat:@"%d",_changeTimes];
}

- (void)addTimeLabel
{
    
    [self canNotUse];
    
    UIColor *textColor ;
    if (_index == 2) {
        textColor = [UIColor redColor];
    }else if(_index == 1){
        textColor = [UIColor blackColor];
    }else{
        textColor = [UIColor yellowColor];
    }
    
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _timeLabel.textColor = textColor;
    _timeLabel.font = [UIFont boldSystemFontOfSize:25];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_timeLabel];
    
    _timeLabel.text = [NSString stringWithFormat:@"%d",_changeTimes];

    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(weaponTimes:) userInfo:_timeLabel repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
}

- (UIImageView *)skillImage
{
    if (!_skillImage) {
        
        CGFloat page = (smallBtn - speed) / 2.0;

        _skillImage = [[UIImageView alloc] initWithFrame:CGRectMake(page, page, speed, speed)];
        [self addSubview:_skillImage];
    }
    
    return _skillImage;
}

- (void)setImage:(UIImage *)image
{
    self.skillImage.image = image;
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
    
    _zomDiedNumber++;
    if (_zomDiedNumber == _zomNumber) {
        
        [self canUse];
        
        _timeChange = YES;
        _zomDiedNumber = 0;
        
        [self canUseAnimation];
        
    }else{
        
        self.userInteractionEnabled = NO;
        _timeChange = NO;
    }
}

- (void)canUseAnimation
{
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"技能边框" withExtension:@"gif"]; //加载GIF图片
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef) fileUrl, NULL);           //将GIF图片转换成对应的图片源
    size_t frameCout = CGImageSourceGetCount(gifSource);                                         //获取其中图片源个数，即由多少帧图片组成
    NSMutableArray *frames = [[NSMutableArray alloc] init];                                      //定义数组存储拆分出来的图片
    for (size_t i = 0; i < frameCout; i++) {
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, i, NULL); //从GIF图片中取出源图片
        UIImage *imageName = [UIImage imageWithCGImage:imageRef];                  //将图片源转换成UIimageView能使用的图片源
        [frames addObject:imageName];                                              //将图片加入数组中
        CGImageRelease(imageRef);
    }
    
    _animationView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _animationView.animationImages = frames;
    _animationView.animationDuration = 0.3;
    [_animationView startAnimating];
    [self addSubview:_animationView];
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

- (void)canUse
{
    self.userInteractionEnabled = YES;
    self.alpha = 0.7;
}
- (void)canNotUse
{
    self.userInteractionEnabled = NO;
    self.alpha = 0.2;
}

@end
