//
//  CutPictureTool.h
//  Zombies
//
//  Created by 吴冬 on 17/4/11.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface CutPictureTool : NSObject

+ (NSMutableDictionary *)cutPic:(UIImage *)image
                    size:(CGSize )size
                    line:(int)line
                 arrange:(int)arrange;


+ (NSMutableArray *)cutPic:(UIImage *)image size:(CGSize )size count:(int)count;

+ (NSMutableDictionary *)cutFirePic:(UIImage *)image size:(CGSize )size;

+ (NSMutableArray *)cutImage:(UIImage *)image
                        size:(CGSize )size
                        line:(int)line
                     arrange:(int)arrange;

@end
