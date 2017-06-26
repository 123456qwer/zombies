//
//  ConnonBehavior.m
//  Zombies
//
//  Created by 吴冬 on 2017/6/22.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import "ConnonBehavior.h"
#import "ConnonZombies.h"

@implementation ConnonBehavior

- (void)connonFire:(NSDictionary *)dic
{
    
    ConnonZombies *connonZom = dic[@"connon"];
    PersonNode    *person    = dic[@"person"];
    
    [connonZom removeAllActions];
    
    CGFloat x = connonZom.position.x  - person.position.x ;
    CGFloat y = connonZom.position.y - person.position.y ;
    CGFloat count = atan2(y, x) + M_PI;
    
    ConnonZombies *fire = [ConnonZombies spriteNodeWithTexture:_fire_connonArr[0]];
    [connonZom.parent addChild:fire];
    
    fire.isFire = YES;
    fire.xScale = 0.6;
    fire.yScale = 0.6;
    fire.zRotation = count;
    connonZom.zRotation = count;
    fire.zPosition = connonZom.zPosition - 1;
    
    //火箭筒动画
    SKAction *connonAction = [SKAction animateWithTextures:_connonArr timePerFrame:0.2];
    [connonZom runAction:connonAction];
    
    
    NSDictionary *dictionary = @{@"fire":fire,@"x":@(person.position.x),@"y":@(person.position.y),@"connon":connonZom};
    [self performSelector:@selector(fire:) withObject:dictionary afterDelay:0.6];
}


- (void)fire:(NSDictionary *)dic
{
    
    ConnonZombies *fire = dic[@"fire"];
    ConnonZombies *connon = dic[@"connon"];
    CGPoint position = CGPointMake([dic[@"x"] floatValue], [dic[@"y"]floatValue]);
    fire.position = CGPointMake(connon.position.x, connon.position.y );
    
    fire.hidden = NO;
    [fire removeAllActions];
    
    CGFloat distance = [CalculateDistance zomAndPersonDistance:fire.position personPoint:position];
    CGFloat time = distance / 400.0;
    
    
    SKAction *a1 = [SKAction animateWithTextures:_fire_connonArr timePerFrame:0.1];
    SKAction *rep1 = [SKAction repeatAction:a1 count:time / 0.4];
    SKAction *moveAction = [SKAction moveTo:CGPointMake(position.x, position.y) duration:time];
    SKAction *grop = [SKAction group:@[moveAction,rep1]];
    
    
    SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(fire.size.width - 20, fire.size.height - 20)];
    
    body.affectedByGravity = NO;
    body.allowsRotation = NO;
    
    body.categoryBitMask = 0;
    body.contactTestBitMask = player_type;
    body.collisionBitMask = connonFire_type;
    body.dynamic = NO;
    
    fire.physicsBody = body;
    
    
    [fire runAction:grop completion:^{
        
        [fire removeFromParent];
        if (self.finishConnonFire) {
            self.finishConnonFire();
        }
    }];
    
}



@end
