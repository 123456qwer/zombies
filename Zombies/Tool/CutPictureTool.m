//
//  CutPictureTool.m
//  Zombies
//
//  Created by 吴冬 on 17/4/11.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import "CutPictureTool.h"

@implementation CutPictureTool



+ (NSMutableDictionary *)cutFirePic:(UIImage *)image size:(CGSize )size
{
    CGImageRef imageRef = image.CGImage;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:8];
    NSArray *keyArr = @[kLeft,kRight,kUp,kDown,kLU,kRU,kLD,kRD];
    for (int i = 0; i < keyArr.count; i++) {
        
        CGRect rect = CGRectMake(i * size.width, 0, size.width, size.height);
        CGImageRef cgImage = CGImageCreateWithImageInRect(imageRef, rect);
        
        UIImage *shearImage = [[UIImage alloc] initWithCGImage:cgImage];
        //直接存储贴图
        SKTexture *text = [SKTexture textureWithImage:shearImage];
       
        [dic setObject:text forKey:keyArr[i]];
    }
    
    return dic;
}

+ (NSMutableArray *)cutImage:(UIImage *)image
                        size:(CGSize )size
                        line:(int)line
                     arrange:(int)arrange
{

    int count = line * arrange;
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:count];
    CGImageRef imageRef = image.CGImage;
    
    for (int i = 0; i < count; i++) {
       
        CGFloat x = (i % arrange) * size.width;
        CGFloat y = (i / arrange) * size.height;
        
        CGRect rect = CGRectMake(x, y, size.width, size.height);
        CGImageRef cgImage = CGImageCreateWithImageInRect(imageRef, rect);
        
        UIImage *shearImage = [[UIImage alloc] initWithCGImage:cgImage];
        
        SKTexture *text = [SKTexture textureWithImage:shearImage];
        [arr addObject:text];
        
        
    }

    return arr;
}



+ (NSMutableArray *)cutPic:(UIImage *)image size:(CGSize )size count:(int)count
{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:4];
    CGImageRef imageRef = image.CGImage;

    for (int i = 0; i < count; i++) {
        
        CGRect rect = CGRectMake(i * size.width, 0, size.width, size.height);
        CGImageRef cgImage = CGImageCreateWithImageInRect(imageRef, rect);
        
        UIImage *shearImage = [[UIImage alloc] initWithCGImage:cgImage];
        
        //直接存储贴图
        SKTexture *text = [SKTexture textureWithImage:shearImage];
        [arr addObject:text];
    }
    
    return arr;
}

+ (NSMutableDictionary *)cutPic:(UIImage *)image
                    size:(CGSize)size
                    line:(int)line
                 arrange:(int)arrange
{
    if (!image) {

        return nil;
    }
    
    int count = line * arrange;
    CGImageRef imageRef = image.CGImage;
    
    NSMutableArray *picArr = [NSMutableArray array];
    NSMutableDictionary *picDic = [NSMutableDictionary dictionary];
    
    for (int i = 0; i < line; i++) {
        NSMutableArray *arr = [NSMutableArray array];
        [picArr addObject:arr];
    }
    
    
    for (int i = 0; i < count; i++) {
        CGFloat x = (i % arrange) * size.width;
        int y     = (i / arrange) * size.height;
        
        int index = i / arrange;
        
        CGRect frame = CGRectMake(x, y, size.width, size.height);
        CGImageRef cgImage = CGImageCreateWithImageInRect(imageRef, frame);
        
        UIImage *shearImage = [[UIImage alloc] initWithCGImage:cgImage];
        
        //直接存储贴图
        SKTexture *text = [SKTexture textureWithImage:shearImage];
        NSMutableArray *arr = picArr[index];
        [arr addObject:text];
    }
    
    NSArray *keyArr = @[kLeft,kRight,kUp,kDown,kLU,kRU,kLD,kRD];
    for (int i = 0; i < keyArr.count; i++) {
        
        [picDic setObject:picArr[i] forKey:keyArr[i]];
    }
    
    
    return picDic;
}

@end
