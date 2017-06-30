//
//  CalculateDistance.m
//  Zombies
//
//  Created by 吴冬 on 17/4/13.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import "CalculateDistance.h"

@implementation CalculateDistance

+ (NSString *)directionWithPointForZom:(CGPoint )point1
                                point2:(CGPoint )point2
{
    CGFloat x = point1.x - point2.x;
    CGFloat y = point1.y - point2.y;
    
    
    CGFloat count = atan2(y, x) * 180 / M_PI;
    NSString *keyStr = @"";
    
    if (count <= 20 && count >= -20) {
        keyStr = kLeft;
    }else if(count <= -70 && count >= -110){
        keyStr = kUp;
    }else if(count <= -160 || count >= 160){
        keyStr = kRight;
    }else if(count <= 110 & count >= 70){
        keyStr = kDown;
    }
    
    if ([keyStr isEqualToString:@""]) {
        
        if (count < -20 && count > -70) {
            keyStr = kLU;
        }else if(count < -110 && count > - 160){
            keyStr = kRU;
        }else if(count < 160 && count > 110){
            keyStr = kRD;
        }else if(count < 70 && count > 20){
            keyStr = kLD;
        }
    }
    
    return keyStr;

}

+ (CGPoint)fireMove:(NSString *)direction
        personPoint:(CGPoint )point
           distance:(int)distance
{
    CGFloat x = 0;
    CGFloat y = 0;
    
    CGFloat dis1 = sqrt((distance * distance) / 2.0);
    
    if ([direction isEqualToString:kUp]) {
  
        x = point.x;
        y = point.y + distance;
        
    }else if([direction isEqualToString:kDown]){
        
        x = point.x;
        y = point.y - distance;
        
    }else if([direction isEqualToString:kLeft]){
        
        x = point.x - distance;
        y = point.y;
        
    }else if([direction isEqualToString:kRight]){
        
        x = point.x + distance;
        y = point.y;
        
    }else if([direction isEqualToString:kLU]){
        
        y = point.y + dis1;
        x = point.x - dis1;
        
    }else if([direction isEqualToString:kRU]){
        
        y = point.y + dis1;
        x = point.x + dis1;
        
    }else if([direction isEqualToString:kLD]){
        
        y = point.y - dis1;
        x = point.x - dis1;
        
    }else if([direction isEqualToString:kRD]){
        
        y = point.y - dis1;
        x = point.x + dis1;
    }
    
    return CGPointMake(x, y);
}


+ (NSString *)directionWithPoint:(CGPoint )point1
                          point2:(CGPoint )point2
{
    CGFloat x = point1.x - point2.x;
    CGFloat y = point1.y - point2.y;
    
    
    CGFloat count = atan2(y, x) * 180 / M_PI;
    NSString *keyStr = @"";
    
    if (count <= 20 && count >= -20) {
        keyStr = kRight;
    }else if(count <= -70 && count >= -110){
        keyStr = kUp;
    }else if(count <= -160 || count >= 160){
        keyStr = kLeft;
    }else if(count <= 110 & count >= 70){
        keyStr = kDown;
    }
    
    if ([keyStr isEqualToString:@""]) {
        
        if (count < -20 && count > -70) {
            keyStr = kRU;
        }else if(count < -110 && count > - 160){
            keyStr = kLU;
        }else if(count < 160 && count > 110){
            keyStr = kLD;
        }else if(count < 70 && count > 20){
            keyStr = kRD;
        }
    }

    return keyStr;
}

+ (CGPoint)firePoint:(NSString *)direction
{
    CGFloat x = 0;
    CGFloat y = 0;
    
    
    if ([direction isEqualToString:kUp]) {

        x = 8;
        y = 36;
        
    }else if([direction isEqualToString:kDown]){

        x = -8;
        y = -36;
        
    }else if([direction isEqualToString:kLeft]){
        
        x = -35;
        y = -3;
        
    }else if([direction isEqualToString:kRight]){
   
        x = 35;
        y = -3;
        
    }else if([direction isEqualToString:kLU]){
     
        x = -20;
        y = 23;
        
    }else if([direction isEqualToString:kRU]){
     
        x = 31;
        y = 23;
        
    }else if([direction isEqualToString:kLD]){
    
        x = -31;
        y = -23;
        
    }else if([direction isEqualToString:kRD]){
        
        x = 20;
        y = -23;
    }
    
    return CGPointMake(x, y);
}

+ (CGPoint )movePointWithSpeed:(CGFloat)speed
                     direction:(NSString *)direction
                         point:(BaseNode *)personNode

{
    
    
    CGFloat x = personNode.position.x;
    CGFloat y = personNode.position.y;
    
    
    
    CGFloat speed1 = sqrt((speed * speed)/ 2.0);
    
    //相反方向
    if (speed < 0) {
        speed1 = -1 * speed1;
    }
    
    
    if ([direction isEqualToString:kUp]) {
        
        y += speed ;
        
    }else if([direction isEqualToString:kDown]){
        
        y-=speed ;

    }else if([direction isEqualToString:kLeft]){

        x -= speed ;
        
    }else if([direction isEqualToString:kRight]){
        
        x += speed ;
        
    }else if([direction isEqualToString:kLU]){
       
         y += speed1 ;
         x -= speed1 ;

    }else if([direction isEqualToString:kRU]){
       
         y += speed1 ;
         x += speed1 ;
        
    }else if([direction isEqualToString:kLD]){
      
         y -= speed1 ;
         x -= speed1;
        
    }else if([direction isEqualToString:kRD]){
       
        y-=speed1 ;
        x += speed1 ;
    }
 
    
    return  CGPointMake(x, y);
}



+ (CGFloat)zomAndPersonDistance:(CGPoint )zomPoint
                    personPoint:(CGPoint)personPoint
{
    
    CGFloat x = fabs( zomPoint.x - personPoint.x);
    CGFloat y = fabs(zomPoint.y - personPoint.y);
    
    return sqrt(x * x + y * y);
}


+ (NSString *)oppositeDirection:(NSString *)direction
{
    NSDictionary *dic = @{kDown:kUp,kUp:kDown,kLeft:kRight,kRight:kLeft,kLU:kRD,kLD:kRU,kRU:kLD,kRD:kLU};
    
    return [dic objectForKey:direction];
}

+(NSDictionary *)blinkZrotation:(NSString *)direction
                          speed:(CGFloat)speed
                    personPoint:(CGPoint)point
{
    CGFloat r = 0;
    CGFloat x = point.x;
    CGFloat y = point.y;
    
    
    
    if ([direction isEqualToString:kUp]) {
        y += speed;
        r = M_PI * 3 / 2.0;

    }else if([direction isEqualToString:kDown]){
        y -= speed;
        r = M_PI / 2.0;

    }else if([direction isEqualToString:kLeft]){
        x -= speed;
        r = 0;

    }else if([direction isEqualToString:kRight]){
        x += speed;
        r = M_PI;

    }else if([direction isEqualToString:kLU]){
        y += speed;
        x -= speed;
        r = M_PI * 7 / 4.0;

    }else if([direction isEqualToString:kRU]){
        y += speed;
        x += speed;
        r = M_PI * 5 / 4.0;

    }else if([direction isEqualToString:kLD]){
        y -= speed;
        x -= speed;
        r = M_PI / 4.0;

    }else if([direction isEqualToString:kRD]){
        y -= speed;
        x += speed;
        r = M_PI * 3 / 4.0;
    }
    
    if (x * x_Scale < 30) {
        x = point.x;
    }else if(x * x_Scale > 3 * kScreenWidth){
        x = point.x;
    }
    
    if (y * y_Scale < 30) {
        y = point.y;
    }else if(y * y_Scale > 3 * kScreenHeight){
        y = point.y;
    }
   
    
    return @{@"r":@(r),@"x":@(x),@"y":@(y)};
}

@end
