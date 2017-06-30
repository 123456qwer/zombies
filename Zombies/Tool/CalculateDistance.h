//
//  CalculateDistance.h
//  Zombies
//
//  Created by 吴冬 on 17/4/13.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonNode.h"

@interface CalculateDistance : NSObject

//子弹飞行方向
+ (CGPoint)fireMove:(NSString *)direction
        personPoint:(CGPoint )point
           distance:(int)distance;

//开火方向
+ (CGPoint)firePoint:(NSString *)direction;

//人物移动方向
+ (NSString *)directionWithPoint:(CGPoint )point1
                          point2:(CGPoint )point2;

//僵尸移动方向
+ (NSString *)directionWithPointForZom:(CGPoint )point1
                                point2:(CGPoint )point2;

//人物位移
+ (CGPoint )movePointWithSpeed:(CGFloat)speed
                     direction:(NSString *)direction
                         point:(PersonNode *)personNode;



//人物与僵尸之间距离
+ (CGFloat)zomAndPersonDistance:(CGPoint )zomPoint
                    personPoint:(CGPoint)personPoint;

//受攻击，人物与僵尸方向相反
+ (NSString *)oppositeDirection:(NSString *)direction;

//瞬移方向
+(NSDictionary *)blinkZrotation:(NSString *)direction
                          speed:(CGFloat)speed
                    personPoint:(CGPoint)point;

@end
