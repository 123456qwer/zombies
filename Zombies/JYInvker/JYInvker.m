//
//  JYInvker.m
//  Zombies
//
//  Created by 吴冬 on 2017/6/30.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import "JYInvker.h"
static JYInvker *manager = nil;
@implementation JYInvker
+ (JYInvker *)shareInvker
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[JYInvker alloc] init];
            manager.commandList = [NSMutableArray array];
        }
    });
    
    return manager;
}

- (void)addCommand:(id<InvkerProtocol>)command
{
    [_commandList addObject:command];
}

//执行按钮操作
- (void)executeWithIndex:(int)index
{
    [_commandList[index] execute];
}

//撤销操作
- (void)rollBackExecute:(int)index
{
    [_commandList[index] rollBackExecute];
}


@end
