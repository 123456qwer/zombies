//
//  Map_1.m
//  Zombies
//
//  Created by 吴冬 on 17/4/10.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import "Map_1.h"
#import "PersonNode.h"
#import "NormalZombies.h"
#import "ConnonZombies.h"
#import <objc/runtime.h>

static void *zomLink = @"zomLink";

@implementation Map_1
{
    PersonNode *_personNode;
    SKSpriteNode *_backGroundNode;
    
    NSTimer *_normalTimer;
    
    
    SKSpriteNode *_bgNode;
    
    int _zombiesNumber;
    int _personNumber;
    
    ConnonZombies *_cannon;
    ConnonZombies *_fire;
    CGPoint _lastPostion;
    
    CADisplayLink *_mapLink;
    NSTimer *_mapTimer;
    BOOL  _destoryConnon;
    
}

- (void)mapMove{
    _personNode.mapNode.position = [_personNode.nodeBehavior setBGPositionWithPersonNode:_personNode.position];
}

/*
- (void)mapMove:(NSTimer *)timer
{
    _personNode.mapNode.position = [_personNode.nodeBehavior setBGPositionWithPersonNode:_personNode.position];
}
 */

- (void)didMoveToView:(SKView *)view
{
    
    if (!self.isAlreadyCreate) {
        [self _createNodes];
        self.isAlreadyCreate = YES;
        
        _mapLink.paused = YES;
        [_mapLink invalidate];
        _mapLink = nil;
        
        
        [_normalTimer invalidate];
        _normalTimer = nil;
        
       //[_mapTimer invalidate];
       // _mapTimer = nil;
        
        //_normalTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(apearZombiesNodes:) userInfo:nil repeats:YES];
        
        //_mapTimer = [NSTimer scheduledTimerWithTimeInterval:0.0 target:self selector:@selector(mapMove:) userInfo:nil repeats:YES];
       
        _mapLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(mapMove)];
        [_mapLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
}


//人物移动
- (void)moveAction:(NSString *)key speed:(CGFloat)speed
{
    [_personNode move:key];
    [self mapMove];

}


- (void)stopAction{
    [_personNode stopMove];
}


//僵尸出现
- (void)apearZombiesNodes:(NSTimer *)timer
{
    _zombiesNumber--;
    if (_zombiesNumber <= 0) {
        [_normalTimer invalidate];
        _normalTimer = nil;
        
        return;
    }
    
    NormalZombies *zom;
    
    if (_zombiesNumber % 5 == 0) {
    
        zom = [[NormalZombies alloc] initZombiesNodeWithPerson:_personNode level:level2];

    }else{
        
        zom = [[NormalZombies alloc] initZombiesNodeWithPerson:_personNode level:level1];
    }
    
    [_backGroundNode addChild:zom];

    //观察血量变化
    [zom addObserver:self forKeyPath:@"blood" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:NULL];
    
    //设置物理，初始化坐标
    //NSTimer *timer1 = [NSTimer scheduledTimerWithTimeInterval:0.016 target:self selector:@selector(zomMove:) userInfo:zom repeats:YES];
    
    CADisplayLink *_link = [CADisplayLink displayLinkWithTarget:self selector:@selector(zomMove:)];
    [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];

    //设置链接
    objc_setAssociatedObject(_link, zomLink, zom, OBJC_ASSOCIATION_RETAIN);
    
}

//僵尸移动
- (void)zomMove:(CADisplayLink *)link
{
    NormalZombies *zom = objc_getAssociatedObject(link, zomLink);
    if (zom.blood == 0) {

        link.paused = YES;
        [link invalidate];
        link = nil;
        return;
    }
    
    if (zom.isRedZom) {
        [zom zomMoveWithPerson:_personNode];
    }else{
        [zom zomMoveWithPerson:_personNode];
    }

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:@"blood"]) {
        NormalZombies *zom = (NormalZombies *)object;
        if (zom.blood <= 0) {
            
            [zom removeObserver:self forKeyPath:@"blood"];
            NSMutableArray *diedArr;
            [zom died:diedArr];
        }
    }else if([keyPath isEqualToString:@"position"]){
       

//        PersonNode *personNode = (PersonNode *)object;
//        
//        //[personNode.nodeBehavior setPersonLocation:personNode.position];
//        NSLog(@"最终人物的距离：%lf",personNode.position.x);
   
    }
}


//僵尸移动
/*
- (void)zomMove:(NSTimer *)timer
{
   
    NormalZombies *zom = timer.userInfo;
    if (zom.blood == 0) {
        [timer invalidate];
        timer = nil;
        return;
    }
    
    if (zom.isRedZom) {
        [zom zomMoveWithPerson:_personNode];
    }else{
        [zom zomMoveWithPerson:_personNode];
    }
}
 */



- (void)_createNodes
{
    self.physicsWorld.contactDelegate = self;
    
    _zombiesNumber = 50;
    _bgNode = (SKSpriteNode *)[self childNodeWithName:@"bg"];
    _bgNode.hidden = YES;
    _backGroundNode = (SKSpriteNode *)[self childNodeWithName:@"landNode"];
   
    _backGroundNode.xScale = kScreenWidth / 667.0;
    _backGroundNode.yScale = kScreenHeight / 375.0;
    
    
    
    
    _personNode = [[PersonNode alloc] initPersonNodeWithBgNode:_backGroundNode];
    [_backGroundNode addChild:_personNode];
    [_personNode addObserver:self forKeyPath:@"position" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
  
    _backGroundNode.position = CGPointMake(0, 0);
    
    NSMutableArray *x_arr = [NSMutableArray array];
    for (int i = 0; i < 2001; i ++) {
        int x = i;
        if (x * x_Scale < kScreenWidth / 2.0 ) {
            [x_arr addObject:@(0)];
        }else if(x * x_Scale > 2 * kScreenWidth + kScreenWidth / 2.0){
            [x_arr addObject:@(-kScreenWidth * 2)];
        }else{
            [x_arr addObject:@(-(x * x_Scale - kScreenWidth / 2.0))];
        }
    }
    NSMutableArray *y_arr = [NSMutableArray array];
    for (int i = 0; i < 1125; i ++) {
        int y = i;
        if (y * y_Scale < kScreenHeight / 2.0 ) {
            [y_arr addObject:@(0)];
        }else if(y * y_Scale > 2 * kScreenHeight + kScreenHeight / 2.0){
            [y_arr addObject:@(-kScreenHeight * 2 )];
        }else{
            [y_arr addObject:@(-(y * y_Scale - kScreenHeight / 2.0))];
        }
    }
    
    
    [_personNode.nodeBehavior setBGarrWithX:x_arr y:y_arr];
   
    //_backGroundNode.zPosition = -100;
    
    for (int i = 0; i < 4 ; i++) {
        NSString *name = [NSString stringWithFormat:@"wall%d",i+1];
        SKSpriteNode *wallNode = (SKSpriteNode *)[_backGroundNode childNodeWithName:name];
        
        
        SKPhysicsBody *body = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, wallNode.size.width, wallNode.size.height)];

        
        body.affectedByGravity = NO;
        body.allowsRotation = NO;
        body.categoryBitMask = wall_type;
        body.collisionBitMask = wall_type;
        body.dynamic = NO;
        
        wallNode.physicsBody = body;
    }
    
    if (!_destoryConnon) {
        //[self performSelector:@selector(createConnon) withObject:nil afterDelay:3];
    }
}



- (void)createConnon
{
    _cannon = [[ConnonZombies alloc] initConnonNodeWithPersonNode:_personNode];
    [_backGroundNode addChild:_cannon];
    [_cannon.nodeBehavior connonFire:@{@"connon":_cannon,@"person":_personNode}];
}

#pragma mark physicsBody
- (void)didBeginContact:(SKPhysicsContact *)contact
{
    id A = contact.bodyA.node;
    id B = contact.bodyB.node;
   
   // NSLog(@"%@ %@",A,B);
    
    NormalZombies *zomNode = nil;
    PersonNode    *personNode = nil;
    FireBaseNode  *fireNode = nil;
    ConnonZombies *connonNode = nil;
    
    if ([A isKindOfClass:[FireBaseNode class]]) {
        fireNode = A;
    }else if([B isKindOfClass:[FireBaseNode class]]){
        fireNode = B;
    }
    
    
    if ([A isKindOfClass:[NormalZombies class]]) {
        zomNode = A;
    }else if([B isKindOfClass:[NormalZombies class]]){
        zomNode = B;
    }
    
   
    if ([A isKindOfClass:[PersonNode class]]) {
        personNode = A;
    }else if([B isKindOfClass:[PersonNode class]]){
        personNode = B;
    }
    
    
    if ([A isKindOfClass:[ConnonZombies class]]) {
        connonNode = A;
    }else if([B isKindOfClass:[ConnonZombies class]]){
        connonNode = B;
    }
    
    
    if (connonNode && fireNode && !connonNode.isFire) {
        NSLog(@"我打中火箭筒了");
        connonNode.blood --;
        connonNode.color = [SKColor redColor];
        connonNode.colorBlendFactor = (20 - connonNode.blood) / 20.0;
        if (connonNode.blood <= 0) {
            _destoryConnon = YES;
            [connonNode removeFromParent];
        }
        [fireNode removeFromParent];
    }
    
    
    if (connonNode && personNode && connonNode.isFire) {
        NSLog(@"火箭炮击中");
        
        NSString *direction = [CalculateDistance directionWithPointForZom:connonNode.position point2:_personNode.position];
        
        BOOL isGameOver = [_personNode.nodeBehavior beAttack:@{kNode:_personNode ,@"direction":direction,@"blood":@(3)}];
        
        if (isGameOver) {
            [self gameIsOver];
            return;
        }
        
        [connonNode removeFromParent];
       
        if (!_destoryConnon) {
            //刷新发射火箭动画
            [_cannon reloadFireAction];
        }
    }
    
    if (fireNode && zomNode && !zomNode.isAttack) {
        zomNode.blood --;
        [fireNode removeFromParent];
    }
    
    
    
    //__weak typeof(self)weekSelf = self;
    if (zomNode && personNode && !zomNode.isAttack) {
       
        if (personNode.isBlink) {
            zomNode.blood = 0;
            return;
        }
        
        __weak typeof(self)weekSelf = self;
        [zomNode attackActionWithPerson:_personNode Completion:^(BOOL isGameOver){
           
            
            if (isGameOver) {
                
                [weekSelf gameIsOver];
            }
            
        }];
    }
    
}

- (void)didEndContact:(SKPhysicsContact *)contact
{

}

- (void)hidden{
    _personNode.fireNode.hidden = YES;
}

- (void)weapon1{
   
    
    [_personNode removeAllActions];
    
    SkillAnimationTime *time = [SkillAnimationTime share];
    
    /*
    __weak typeof(self)weekSelf = self;
    [time rocketAction:_personNode dic:nil finishBlock:^(int skillCount) {
        if (weekSelf.weapon1Finish) {
            weekSelf.weapon1Finish(skillCount);
        }
    }];
    */
    
}



- (void)fire{
    
    _personNode.fireNode.hidden = NO;
    
    SKTexture *rext = [SKTexture textureWithImage:[UIImage imageNamed:@"选中"]];
    FireBaseNode *firNode = [FireBaseNode spriteNodeWithTexture:rext];
    [firNode fireDirection:_personNode.direction personPosition:_personNode.position distance:_personNode.attack_distance];
    firNode.zPosition = 2.0;
    [_backGroundNode addChild:firNode];
    [self performSelector:@selector(hidden) withObject:nil afterDelay:0.1];
    
}

- (void)gameIsOver
{
    [_normalTimer invalidate];
    _normalTimer = nil;
    self.isAlreadyCreate = NO;
    
    _bgNode.hidden = NO;
    _bgNode.xScale = kScreenWidth / 667.0;
    _bgNode.yScale = kScreenHeight / 375.0;
    
    if (self.gameOver) {
        self.gameOver();
    }

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        
        //CGPoint point = [touch locationInNode:self];
        
        if (!self.isAlreadyCreate) {
            if (self.startGame) {
                self.startGame();
            }
        }
        
    }
}

@end
