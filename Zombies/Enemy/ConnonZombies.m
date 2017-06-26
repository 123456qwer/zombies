//
//  ConnonZombies.m
//  Zombies
//
//  Created by 吴冬 on 2017/6/22.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import "ConnonZombies.h"
#import "ConnonBehavior.h"

@implementation ConnonZombies
{
    CGPoint _lastPostion;
    
    PersonNode *_personNode;
}

- (ConnonZombies *)initConnonNodeWithPersonNode:(PersonNode *)personNode
{
    
    if (self = [super init]) {
        
        NSMutableArray *_connonArr = [CutPictureTool cutImage:[UIImage imageNamed:@"connon.png"] size:CGSizeMake(128, 128) line:2 arrange:2];
        NSMutableArray *_fireArr =  [CutPictureTool cutImage:[UIImage imageNamed:@"connon_fire.png"] size:CGSizeMake(256, 100) line:4 arrange:1];

        
        self = [ConnonZombies spriteNodeWithTexture:_connonArr[0]];
        
        self.nodeBehavior = [ConnonBehavior new];
        [self.nodeBehavior setValue:_connonArr forKey:@"connonArr"];
        [self.nodeBehavior setValue:_fireArr forKey:@"fire_connonArr"];
        
        SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.size.width , self.size.height )];
        
        body.affectedByGravity = NO;
        body.allowsRotation = NO;
        
        body.categoryBitMask = normal_zom;
        body.contactTestBitMask = normal_zom;
        body.collisionBitMask = connon_type;
        body.dynamic = YES;
        self.physicsBody = body;
        
        self.blood = 20;
        
        self.position = CGPointMake(3 * kScreenWidth / 2.0, 3 * kScreenHeight / 2.0);
        self.zPosition = 1000;
        
        
        CGFloat x = self.position.x  - personNode.position.x ;
        CGFloat y = self.position.y - personNode.position.y ;
        CGFloat count = atan2(y, x) + M_PI;
        
        self.zRotation = count;
        self.isFire = NO;
        self.zPosition = 1000;
        self.xScale = 0.8;
        self.yScale = 0.8;
        
        _personNode = personNode;
        
       //刷新火箭
        __weak typeof(self)weekSelf = self;
        [self.nodeBehavior setFinishConnonFire:^{
            [weekSelf reloadFireAction];
        }];
    }
    
    return self;
}

- (void)reloadFireAction
{
    [self.nodeBehavior connonFire:@{@"connon":self,@"person":_personNode}];
}

/*
- (void)changePosition:(PersonNode *)personNode
{
    ConnonZombies *_fire = [ConnonZombies spriteNodeWithTexture:_fireArr[0]];
    _fire.xScale = 0.6;
    _fire.yScale = 0.6;
    _fire.zRotation = count;
    _fire.isFire = YES;
    
    _fire.hidden = YES;
    _fire.zPosition = 999;
    
    SKAction *a1 = [SKAction animateWithTextures:_fireArr timePerFrame:0.1];
    SKAction *rep = [SKAction repeatActionForever:a1];
    [_fire runAction:rep];
    
    [personNode.mapNode addChild:_fire];
    
    _lastPostion = personNode.position;
    
    [self performSelector:@selector(fire:) withObject:_fire afterDelay:0.3];
    
}


- (void)fire:(ConnonZombies *)_fire
{
    _fire.hidden = NO;
    [_fire removeAllActions];
    
    CGFloat distance = [CalculateDistance zomAndPersonDistance:_fire.position personPoint:_lastPostion];
    CGFloat time = distance / 400;
    
    NSLog(@"距离：%lf",distance);
    NSLog(@"时间: %lf",time);
    
    _fire.position = CGPointMake(self.position.x, self.position.y);
    SKAction *a1 = [SKAction animateWithTextures:_fireArr timePerFrame:0.1];
    SKAction *rep1 = [SKAction repeatAction:a1 count:time / .4 + .5];
    
    
    SKAction *moveAction = [SKAction moveTo:CGPointMake(_lastPostion.x, _lastPostion.y) duration:time];
    
    
    
    SKAction *grop = [SKAction group:@[moveAction,rep1]];
    
    SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(_fire.size.width - 20, _fire.size.height - 20)];
    
    body.affectedByGravity = NO;
    body.allowsRotation = NO;
    
    body.categoryBitMask = 0;
    body.contactTestBitMask = player_type;
    body.collisionBitMask = connonFire_type;
    body.dynamic = NO;
    
    
    _fire.physicsBody = body;
    
    [_fire runAction:grop completion:^{
   
        [_fire removeFromParent];
        //[self changePosition:_personNode];
    }];
}

 */

@end
