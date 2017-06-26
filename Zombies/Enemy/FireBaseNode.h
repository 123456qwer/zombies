//
//  FireBaseNode.h
//  Zombies
//
//  Created by 吴冬 on 17/4/17.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import "BaseNode.h"

@interface FireBaseNode : BaseNode

- (void)fireDirection:(NSString *)direction personPosition:(CGPoint)point distance:(int)distances;
@end
