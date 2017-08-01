//
//  NormalZombies.m
//  Zombies
//
//  Created by 吴冬 on 17/4/13.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import "NormalZombies.h"
@implementation NormalZombies

{
    SKLabelNode *_lableNode;
}

- (NormalZombies *)initZombiesNodeWithPerson:(PersonNode *)personNode
                                       level:(zomLevel)level
{
    if (self = [super init]) {
        
        NSMutableDictionary *moveDic;
        NSMutableArray *diedArr;
        NSMutableDictionary *attackDic;
        NSMutableArray *bornArr;
        
       self = [NormalZombies spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(50, 50)];
        switch (level) {
            case level1:
            {
                self.isRedZom = NO;
                self.blood = 4;
                self.speeds = 1;
                
                moveDic = [CutPictureTool cutPic:[UIImage imageNamed:@"NormalZom"] size:CGSizeMake(50, 50) line:8 arrange:3];
                attackDic = [CutPictureTool cutPic:[UIImage imageNamed:@"NZ_Attack"] size:CGSizeMake(50, 50) line:8 arrange:4];
                diedArr = [CutPictureTool cutPic:[UIImage imageNamed:@"NormalDied"] size:CGSizeMake(50.f, 50.f) count:4];
                bornArr =  [CutPictureTool cutPic:[UIImage imageNamed:@"NormalBorn"] size:CGSizeMake(50.f, 50.f) count:4];
                
            }
                break;
            case level2:
            {
                self.isRedZom = YES;
                self.blood = 8;
                self.speeds = 2;
                
                moveDic = [CutPictureTool cutPic:[UIImage imageNamed:@"RedNarmalZom"] size:CGSizeMake(50,50) line:8 arrange:3];
                attackDic = [CutPictureTool cutPic:[UIImage imageNamed:@"Red_NZ_Attack"] size:CGSizeMake(50, 50) line:8 arrange:4];
                diedArr = [CutPictureTool cutPic:[UIImage imageNamed:@"RedNormalDied"] size:CGSizeMake(50.f, 50.f) count:4];
                bornArr = [CutPictureTool cutPic:[UIImage imageNamed:@"RedNormalBorn"] size:CGSizeMake(50.f, 50.f) count:4];
            }
                break;
                
                
            default:
                break;
        }
        
        self.nodeBehavior = [ZombiesBehavior new];

        
        self.isAttack = YES;
        
        CGFloat x = arc4random() % (int)kScreenHeight*2;
        CGFloat y = arc4random() % (int)kScreenWidth*2;
        
        
        self.position = CGPointMake(x, y);
        self.zPosition =3 * kScreenHeight - y * y_Scale;
        
        
        
        SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(20, 20)];
        body.affectedByGravity = NO;
        body.allowsRotation = NO;
        
        body.categoryBitMask = normal_zom;
        body.contactTestBitMask = player_type;
        body.collisionBitMask = normal_zom;
        body.dynamic = YES;
        
        self.physicsBody = body;
        
        SKAction *bornAction = [SKAction animateWithTextures:bornArr timePerFrame:0.2];
        [self runAction:bornAction completion:^{
            self.isAttack = NO;
        }];
        
        
        self.stiff = 0;
        self.attack = 1;
        
        
        [self.nodeBehavior setValue:moveDic forKey:@"moveDic"];
        [self.nodeBehavior setValue:attackDic forKey:@"attackDic"];
        [self.nodeBehavior setValue:diedArr forKey:@"diedArr"];
        [self.nodeBehavior setValue:bornArr forKey:@"bornArr"];
        
        
        _lableNode = [SKLabelNode labelNodeWithFontNamed:@"Georgia-Bold"];
        _lableNode.hidden = YES;
        _lableNode.fontSize = 18.f;
        _lableNode.position = CGPointMake(0, 15);
        [self addChild:_lableNode];
        
    }
    
    return self;
}

- (void)setLabelText:(NSString *)text
{
    _lableNode.hidden = NO;
    _lableNode.text = text;
    
    [self performSelector:@selector(hiddenLabel) withObject:nil afterDelay:0.5];
}

- (void)hiddenLabel
{
    _lableNode.hidden = YES;
}

- (void)setBodyAndPosition:(NSMutableArray *)bornArr
{
    
}

- (void)attackActionWithPerson:(PersonNode *)person
                    Completion:(void (^)(BOOL))block;
{
    
    NSDictionary *pasDic = @{kNode:self,kPerNode:person,@"block":block};
    [self.nodeBehavior attack:pasDic];
}


- (void)died:(id )personNode{
    PersonNode *person = personNode;
    [self.nodeBehavior died:@{kNode:self,kPerNode:person}];
}

- (void)zomMoveWithPerson:(PersonNode *)person

{
    [self.nodeBehavior move:@{kPerNode:person,kNode:self}];
}

- (void)beAttackWithPerson:(PersonNode *)person
{
    [self.nodeBehavior beAttack:@{kPerNode:person,kNode:self}];
}

@end
