//
//  PersonBehavior.h
//  Zombies
//
//  Created by 吴冬 on 17/4/20.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import "NodeBehavior.h"

@interface PersonBehavior : NodeBehavior

@property (nonatomic ,strong)NSDictionary *moveDic;
@property (nonatomic ,assign)CGFloat lastMove_x;
@property (nonatomic ,assign)CGFloat lastMove_y;
@property (nonatomic ,strong)NSMutableArray *bg_xArr;
@property (nonatomic ,strong)NSMutableArray *bg_yArr;


@end
