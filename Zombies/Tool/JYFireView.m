//
//  JYFireView.m
//  Zombies
//
//  Created by 吴冬 on 17/4/17.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import "JYFireView.h"
#import "FireBtn.h"
#define bigBtn 150 / 750.0 * kScreenWidth
#define smallBtn 60 / 750.0 * kScreenWidth
#define page1 20 / 750.0 * kScreenWidth

@implementation JYFireView
{
    FireBtn *_fireBtn;
    
    FireBtn *_weaponBtn1;
    FireBtn *_weaponBtn2;
    FireBtn *_weaponBtn3;
    int      _fireType;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    
    
    if (self = [super initWithFrame:frame]) {
        
        //当次属性为0，可以攻击，证明不在释放技能的状态
        _fireType = 0;
        
        _fireBtn = [FireBtn buttonWithType:UIButtonTypeCustom];
        _fireBtn.frame = CGRectMake(self.width - bigBtn, self.height - bigBtn, bigBtn, bigBtn);
        [_fireBtn setImage:[UIImage imageNamed:@"fire"] forState:UIControlStateNormal];
        _fireBtn.alpha = 0.5;
        [self addSubview:_fireBtn];
        
        
        __weak typeof(self)weekSelf = self;
        [_fireBtn setSelectBlock:^(UIButton *fir) {
            [weekSelf fireAction:fir];
            fir.alpha = 0.1;
        }];
        
        [_fireBtn setEndBlock:^(UIButton *fir) {
            fir.alpha = 0.5;
        }];
        
        
        _weaponBtn1 = [FireBtn buttonWithType:UIButtonTypeCustom];
        _weaponBtn1.frame = CGRectMake(0, 0,smallBtn, smallBtn);
        _weaponBtn1.center = CGPointMake(_fireBtn.center.x - bigBtn / 2.0  - smallBtn / 2.0, _fireBtn.center.y + page1);
        [_weaponBtn1 setImage:[UIImage imageNamed:@"weaponBtn"] forState:UIControlStateNormal];
        _weaponBtn1.alpha = 0.5;
        [self addSubview:_weaponBtn1];
        
        
        //设置武器类型
        _weaponBtn1.skillType = 1;
        [_weaponBtn1 setSelectBlock:^(UIButton *fir) {
            [weekSelf weapon1];
        }];
        
        [_weaponBtn1 setEndBlock:^(UIButton *fir) {
    
        }];
        
        [_weaponBtn1 setEndSkillBlock:^{

        }];
        
        CGFloat dis      = smallBtn / 2.0 + bigBtn / 2.0;
        CGFloat distance = sqrt(dis * dis / 2.0);
        CGFloat x = _fireBtn.center.x - distance;
        CGFloat y = _fireBtn.center.y - distance;
        
        _weaponBtn2 = [FireBtn buttonWithType:UIButtonTypeCustom];
        _weaponBtn2.frame = CGRectMake(0, 0,smallBtn, smallBtn);
        _weaponBtn2.center = CGPointMake(x,y);
        [_weaponBtn2 setImage:[UIImage imageNamed:@"weaponBtn"] forState:UIControlStateNormal];
        _weaponBtn2.alpha = 0.5;
        [self addSubview:_weaponBtn2];
        
        
        [_weaponBtn2 setSelectBlock:^(UIButton *fir) {
            NSLog(@"first2");
        }];
        
        [_weaponBtn2 setEndBlock:^(UIButton *fir) {
            NSLog(@"first2");
        }];
        
        
        
        _weaponBtn3 = [FireBtn buttonWithType:UIButtonTypeCustom];
        _weaponBtn3.frame = CGRectMake(0, 0,smallBtn, smallBtn);
        _weaponBtn3.center = CGPointMake(_fireBtn.center.x + page1,_fireBtn.center.y - bigBtn / 2.0 - smallBtn / 2.0);
        [_weaponBtn3 setImage:[UIImage imageNamed:@"weaponBtn"] forState:UIControlStateNormal];
        _weaponBtn3.alpha = 0.5;
        [self addSubview:_weaponBtn3];
        
        
        [_weaponBtn3 setSelectBlock:^(UIButton *fir) {
            NSLog(@"first3");
        }];
        
        [_weaponBtn3 setEndBlock:^(UIButton *fir) {
            NSLog(@"first3");            
        }];
    }
    
    return self;
}

- (void)fireAction:(UIButton *)sender
{
    if (_fireBlock) {
        _fireBlock();
    }
    
}

- (void)weapon1AnimationEnd
{
    _fireBtn.userInteractionEnabled = YES;
}


- (void)weapon1{

    _fireBtn.userInteractionEnabled = NO;
    
    [self setFireType:1];
    
    SkillAnimationTime *skill = [SkillAnimationTime share];
    [skill weaponAction:_weaponBtn1];
    

    if (_weapon1Block) {
        _weapon1Block();
    }
}


- (void)fire:(NSTimer *)timer
{
    if (_fireBlock) {
        _fireBlock();
    }
}

//设置是否可以攻击
- (void)setFireType:(int)fireType
{
    _fireType += fireType;
    
    if (_fireType == 0) {
        _fireBtn.userInteractionEnabled = YES;
    }else{
        _fireBtn.userInteractionEnabled = NO;
    }
}




@end