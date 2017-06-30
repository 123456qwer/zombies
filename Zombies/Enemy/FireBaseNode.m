//
//  FireBaseNode.m
//  Zombies
//
//  Created by 吴冬 on 17/4/17.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import "FireBaseNode.h"

@implementation FireBaseNode

- (void)fireDirection:(NSString *)direction
       personPosition:(CGPoint)point
             distance:(int)distances
{
    self.xScale = 0.1;
    self.yScale = 0.1;
    self.position = point;
    
    CGPoint p = [CalculateDistance fireMove:direction personPoint:point distance:distances];
    CGFloat x = fabs(point.x - p.x);
    CGFloat y = fabs(point.y - p.y);
    CGFloat distance = sqrt(fabs(x * x)+fabs(y * y));
    
    SKAction *action = [SKAction moveTo:p duration:distance / 700.f];
    [self runAction:action completion:^{
        [self removeFromParent];
    }];
    
    SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(20, 20)];
    
    body.affectedByGravity = NO;
    body.allowsRotation = NO;
  
    body.dynamic = NO;
    body.categoryBitMask = 0;
    body.contactTestBitMask = normal_zom;
    body.collisionBitMask = fire_type ;
    
    self.physicsBody = body;
}

@end
