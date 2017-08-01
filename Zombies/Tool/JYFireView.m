//
//  JYFireView.m
//  Zombies
//
//  Created by 吴冬 on 17/4/17.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import "JYFireView.h"
#import "FireBtn.h"
#import "BlinkBtn.h"

#define bigBtn 150 / 750.0 * kScreenWidth
#define smallBtn 60 / 750.0 * kScreenWidth
#define page1 20 / 750.0 * kScreenWidth

#import "Weapon.h"

@implementation JYFireView
{
    FireBtn *_fireBtn;
    
    FireBtn *_weaponBtn1;
    FireBtn *_weaponBtn2;
    FireBtn *_weaponBtn3;
    
    BlinkBtn *_blinkBtn1;
    
    int      _fireType;
    JYInvker *_invker;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
   
    if (self = [super initWithFrame:frame]) {
        
        _invker = [JYInvker shareInvker];
        
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
        [self addSubview:_weaponBtn1];
        
        
        //设置武器类型
        _weaponBtn1.skillType = 1;
        [_weaponBtn1 setSelectBlock:^(UIButton *fir) {
       
        }];
        
        
        [_weaponBtn1 setEndBlock:^(UIButton *fir) {
            [weekSelf weaponWithIndex:0];
        }];
        
        
        [_weaponBtn1 setEndSkillBlock:^{

        }];
        
        //闪现按钮
        _blinkBtn1 = [BlinkBtn buttonWithType:UIButtonTypeCustom];
        _blinkBtn1.frame = CGRectMake(0, 0,smallBtn, smallBtn);
        _blinkBtn1.center = CGPointMake(_weaponBtn1.left - smallBtn / 2.0 - page1, _fireBtn.center.y + page1);
        [_blinkBtn1 setImage:[UIImage imageNamed:@"weaponBtn"] forState:UIControlStateNormal];
        _blinkBtn1.alpha = 0.5;
        [self addSubview:_blinkBtn1];
        
        
        [_blinkBtn1 setEndBlock:^(UIButton *fir){
            
            [weekSelf weaponWithIndex:3];
            
        }];
        
        [_blinkBtn1 setSelectBlock:^(UIButton *fir){
            
        }];
        
        
        CGFloat dis      = smallBtn / 2.0 + bigBtn / 2.0;
        CGFloat distance = sqrt(dis * dis / 2.0);
        CGFloat x = _fireBtn.center.x - distance;
        CGFloat y = _fireBtn.center.y - distance;
        
        _weaponBtn2 = [FireBtn buttonWithType:UIButtonTypeCustom];
        _weaponBtn2.frame = CGRectMake(0, 0,smallBtn, smallBtn);
        _weaponBtn2.center = CGPointMake(x,y);
        [_weaponBtn2 setImage:[UIImage imageNamed:@"weaponBtn"] forState:UIControlStateNormal];
        [self addSubview:_weaponBtn2];
        
        
        [_weaponBtn2 setSelectBlock:^(UIButton *fir) {
        }];
        
        [_weaponBtn2 setEndBlock:^(UIButton *fir) {
            [weekSelf weaponWithIndex:1];
        }];
        
        
        
        _weaponBtn3 = [FireBtn buttonWithType:UIButtonTypeCustom];
        _weaponBtn3.frame = CGRectMake(0, 0,smallBtn, smallBtn);
        _weaponBtn3.center = CGPointMake(_fireBtn.center.x + page1,_fireBtn.center.y - bigBtn / 2.0 - smallBtn / 2.0);
        [_weaponBtn3 setImage:[UIImage imageNamed:@"weaponBtn"] forState:UIControlStateNormal];
        [self addSubview:_weaponBtn3];
        
        
        [_weaponBtn3 setSelectBlock:^(UIButton *fir) {
        }];
        
        [_weaponBtn3 setEndBlock:^(UIButton *fir) {
            [weekSelf weaponWithIndex:2];
        }];
        
        
        
        _weaponBtn1.userInteractionEnabled = NO;
        _weaponBtn2.userInteractionEnabled = NO;
        _weaponBtn3.userInteractionEnabled = NO;
        _blinkBtn1.userInteractionEnabled  = YES;
        
        [_weaponBtn1 canNotUse];
        [_weaponBtn2 canNotUse];
        [_weaponBtn3 canNotUse];
        [_blinkBtn1 canUse];
        
        _weaponBtn1.index = 0;
        _weaponBtn2.index = 1;
        _weaponBtn3.index = 2;
        _blinkBtn1.index  = 4;
        
        
        Weapon *weapon1 = [[Weapon alloc] initWithSender:_weaponBtn1];
        [weapon1 setSkillType:Speed];
        
        Weapon *weapon2 = [[Weapon alloc] initWithSender:_weaponBtn2];
        [weapon2 setSkillType:Attack];
        
        Weapon *weapon3 = [[Weapon alloc] initWithSender:_weaponBtn3];
        [weapon3 setSkillType:Attack_distance];
        
        Weapon *weapon4 = [[Weapon alloc] initWithSender:_blinkBtn1];
        [weapon4 setSkillType:blink];
        
        
        //添加到遥控器
        [_invker.commandList addObject:weapon1];
        [_invker.commandList addObject:weapon2];
        [_invker.commandList addObject:weapon3];
        [_invker.commandList addObject:weapon4];
        
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

- (void)weaponWithIndex:(int)index
{
    if (_weaponBlockWithIndex) {
        _weaponBlockWithIndex(index);
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



/*
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSLog(@"哈哈哈");
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if ([self respondsToSelector:aSelector]) {
        return [super methodSignatureForSelector:aSelector];
    }
    else {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
}
*/



@end
