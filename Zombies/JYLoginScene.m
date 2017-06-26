//
//  JYLoginScene.m
//  Zombies
//
//  Created by 吴冬 on 17/4/10.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import "JYLoginScene.h"


@implementation JYLoginScene
{
    
    NSArray      *_personPic;
    NSArray      *_levelPic;
    NSArray      *_personName;
    NSArray      *_levelName;
    
    SKSpriteNode *_personNode;
    SKSpriteNode *_mapNode;
    
    int _personNumber;
    int _levelNumber;
}

- (void)didMoveToView:(SKView *)view
{
    if (!self.isAlreadyCreate) {
        
        [self _createNodes];
        self.isAlreadyCreate = YES;
    }
    
}

- (void)_createNodes
{
    _personNumber = 3;
    _levelNumber  = 0;
    
    NSMutableArray *p_pic_arr = [NSMutableArray arrayWithCapacity:4];
    NSMutableArray *p_name_arr = [NSMutableArray arrayWithCapacity:4];
    for (int i = 0; i < 4; i++) {
        
        NSString *picName = [NSString stringWithFormat:@"person_%d",i+1];
        SKTexture *texture = [SKTexture textureWithImage:[UIImage imageNamed:picName]];
        [p_pic_arr addObject:texture];
        [p_name_arr addObject:picName];
    }
    
    NSMutableArray *l_pic_arr = [NSMutableArray arrayWithCapacity:1];
    NSMutableArray *l_name_arr = [NSMutableArray arrayWithCapacity:1];
    for (int i = 0; i < 1; i++) {
        NSString *picName = [NSString stringWithFormat:@"Map_%d",i+1];
        SKTexture *texture = [SKTexture textureWithImage:[UIImage imageNamed:picName]];
        [l_pic_arr addObject:texture];
        [l_name_arr addObject:picName];
    }
    
    _levelPic = l_pic_arr;
    _personPic = p_pic_arr;
    
    _levelName = l_name_arr;
    _personName = p_name_arr;
   
    
    _personNode = [SKSpriteNode spriteNodeWithTexture:_personPic[_personNumber]];
    _personNode.xScale = (168 / 750.0 * kScreenWidth) / 168 / 2.0;
    _personNode.yScale = (168 / 750.0 * kScreenWidth) / 168 / 2.0;
    
    _personNode.position = CGPointMake(3 + 40 + 10 + _personNode.frame.size.width / 2.0, kScreenHeight / 2.0);
    [self addChild:_personNode];
    
  
    
    
    
    

 
    SKSpriteNode *left = [SKSpriteNode spriteNodeWithColor:[UIColor yellowColor] size:CGSizeMake(40, 40)];
    left.name = @"left";
    left.position = CGPointMake(10 + 40 / 2.0, kScreenHeight / 2.0);
    left.xScale = (40 / 750.0 * kScreenWidth) / 40.0;
    left.yScale = (40 / 750.0 * kScreenWidth) / 40.0;
    
    
    SKSpriteNode *right =  [SKSpriteNode spriteNodeWithColor:[UIColor yellowColor] size:CGSizeMake(40, 40)];
    right.name = @"right";
    right.position = CGPointMake(_personNode.position.x + 3 + _personNode.frame.size.width / 2.0 + 40 / 2.0, kScreenHeight / 2.0);
    right.xScale = (40 / 750.0 * kScreenWidth) / 40.0;
    right.yScale = (40 / 750.0 * kScreenWidth) / 40.0;
    
    
    SKSpriteNode *lLeft = [SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(40, 40)];
    lLeft.name = @"levelLeft";
    lLeft.position = CGPointMake(right.position.x + 40 + right.frame.size.width / 2.0, kScreenHeight / 2.0);
    lLeft.xScale = (40 / 750.0 * kScreenWidth) / 40.0;
    lLeft.yScale = (40 / 750.0 * kScreenWidth) / 40.0;
    
    
    _mapNode = [SKSpriteNode spriteNodeWithTexture:_levelPic[_levelNumber]];
    _mapNode.name = @"mapNode";
    _mapNode.xScale = (355 / 667.0 * kScreenWidth) / 355.0 / 2.0;
    _mapNode.yScale = (183 / 375.0 * kScreenHeight) / 183.0 / 2.0;
    _mapNode.position = CGPointMake(lLeft.position.x + lLeft.frame.size.width / 2.0 + 3 + _mapNode.frame.size.width / 2.0, kScreenHeight / 2.0);
    [self addChild:_mapNode];
    
    SKSpriteNode *lRight = [SKSpriteNode spriteNodeWithColor:[UIColor blueColor] size:CGSizeMake(40, 40)];
    lRight.name = @"levelRight";
    lRight.position = CGPointMake(_mapNode.position.x + _mapNode.frame.size.width / 2.0 + 3 + lRight.frame.size.width / 2.0, kScreenHeight  / 2.0);
    lRight.xScale = (40 / 750.0 * kScreenWidth) / 40.0;
    lRight.yScale = (40 / 750.0 * kScreenWidth) / 40.0;
    
    
    
    [self addChild:left];
    [self addChild:right];
    [self addChild:lLeft];
    [self addChild:lRight];
  
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *node = (SKSpriteNode *)[self nodeAtPoint:location];
        
        if ([node.name isEqualToString:@"left"]) {
            
            _personNumber--;
            if (_personNumber < 0) {
                _personNumber = (int)_personPic.count - 1;
            }
            
        }else if([node.name isEqualToString:@"right"]){
        
            _personNumber++;
            if (_personNumber >= _personPic.count) {
                _personNumber = 0;
            }

        }else if([node.name isEqualToString:@"levelLeft"]){
        
            _levelNumber--;
            if (_levelNumber < 0) {
                _levelNumber = (int)_levelPic.count - 1;
            }
            
        }else if([node.name isEqualToString:@"levelRight"]){
        
            _levelNumber++;
            if (_levelNumber >= _levelPic.count - 1) {
                _levelNumber = 0;
            }
            
        }else if([node.name isEqualToString:@"mapNode"]){
            
            if (_startWithLevelName) {
                _startWithLevelName(_levelName[_levelNumber],_personName[_personNumber]);
            }
        }
        
  
        _personNode.texture = _personPic[_personNumber];
        _mapNode.texture    = _levelPic[_levelNumber];
        
    }
    
    
}

@end
