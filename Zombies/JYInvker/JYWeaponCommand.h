//
//  JYWeaponCommand.h
//  Zombies
//
//  Created by 吴冬 on 2017/6/30.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYInvker.h"
@interface JYWeaponCommand : NSObject<InvkerProtocol>

- (instancetype)initWithSender:(FireBtn *)sender;

@end
