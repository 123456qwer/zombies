//
//  PersonNode.m
//  Zombies
//
//  Created by 吴冬 on 17/4/14.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import "PersonNode.h"

@implementation PersonNode
{
    SKSpriteNode *_fireNode;
    NSMutableDictionary *_fireDic;
    NSMutableArray    *_bloodArr;
    SKSpriteNode *_bloodNode;
    BOOL  _isStopMove;
}

- (PersonNode *)initPersonNodeWithBgNode:(SKSpriteNode *)mapNode
{
    if (self = [super init]) {
        
       
        NSMutableDictionary *moveDic = [CutPictureTool  cutPic:[UIImage imageNamed:@"person4"] size:CGSizeMake(50, 50) line:8 arrange:3];
        
       
        self = [PersonNode spriteNodeWithTexture:[moveDic objectForKey:kLeft][0]];
        self.mapNode = mapNode;
        
        self.position = CGPointMake(kScreenWidth / 2.0 , kScreenHeight / 2.0);
        self.speeds = 3;
        self.attack_distance = 170;
        
        self.nodeBehavior = [PersonBehavior new];
        [self.nodeBehavior setValue:moveDic forKey:@"moveDic"];
        [self.nodeBehavior setValue:@(kScreenWidth / 2.0) forKey:@"lastMove_x"];
        [self.nodeBehavior setValue:@(kScreenHeight / 2.0) forKey:@"lastMove_y"];

        
        _isStopMove = YES;
        _fireDic = [CutPictureTool cutFirePic:[UIImage imageNamed:@"fireAc"] size:CGSizeMake(45, 45)];
        
        self.direction = kLeft;
        self.blood = 10;
        
        
        SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(20, 20)];
        
        body.affectedByGravity = NO;
        body.allowsRotation = NO;
        
        body.categoryBitMask = player_type;
        body.contactTestBitMask = normal_zom;
        body.collisionBitMask = player_type;
        body.dynamic = YES;
        
        
        self.physicsBody = body;
        self.zPosition = 100;
        
        
        _fireNode = [SKSpriteNode spriteNodeWithTexture:_fireDic[self.direction]];
        
        _fireNode.hidden = YES;
        [self addChild:_fireNode];
        
        [self changeFireDirection];
        
        _bloodArr = [CutPictureTool cutPic:[UIImage imageNamed:@"blood"] size:CGSizeMake(50, 10) count:10];
        
        int index = fabs(self.blood - 10);
        
        _bloodNode = [SKSpriteNode spriteNodeWithTexture:_bloodArr[index]];
        _bloodNode.position = CGPointMake(0, 30);
        _bloodNode.alpha = 0.5;
        [self addChild:_bloodNode];
  
    }
    
    return self;
    
}


- (void)setBodyAndPosition:(SKSpriteNode *)mapNode
{
    
    
}

- (void)weapon1Action:(NSMutableDictionary *)dic
{


}

- (void)died
{

}

- (BOOL)beAttackWithZomDirection:(NSString *)direction
{
    NSDictionary *dic = @{kNode:self,@"direction":direction,@"blood":@(1)};
    return  [self.nodeBehavior beAttack:dic];
}

- (void)move:(NSString *)key
{
    self.isBlink = NO;
    [self.nodeBehavior move:@{@"key":key,kNode:self}];
}

- (void)stopMove{
    [self.nodeBehavior stopMove:@{kNode:self}];
}

- (void)changeFireDirection
{
    _fireNode.texture = _fireDic[self.direction];
    _fireNode.position = [CalculateDistance firePoint:self.direction];
}




@end
