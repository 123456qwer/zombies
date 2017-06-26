//
//  ZombiesBehavior.h
//  Zombies
//
//  Created by 吴冬 on 17/4/20.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import "NodeBehavior.h"

@interface ZombiesBehavior : NodeBehavior

@property (nonatomic ,strong)NSDictionary *attackDic;
@property (nonatomic ,strong)NSDictionary *moveDic;
@property (nonatomic ,strong)NSMutableArray *diedArr;
@property (nonatomic ,strong)NSMutableArray *bornArr;

@end
