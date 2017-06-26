//
//  JYLoginVC.m
//  Zombies
//
//  Created by 吴冬 on 17/4/10.
//  Copyright © 2017年 北京金源互动科技有限公司. All rights reserved.
//

#import "JYLoginVC.h"
#import "JYLoginScene.h"
#import "JYOperationView.h"
#import "JYFireView.h"

@interface JYLoginVC ()
{
    JYLoginScene *_loginScene;
    JYOperationView *_operationV;
    JYFireView   *_fireView;
    
    JYBaseScene  *_appearScene;
    
}
@end

@implementation JYLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //初始化技能时间
    SkillAnimationTime *skill = [SkillAnimationTime share];
    [skill createAnimationTime];
   
    
    SKView *skView = (SKView *)self.view;
    
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.ignoresSiblingOrder = YES;
    
    _loginScene = [JYLoginScene sceneWithSize:CGSizeMake(kScreenWidth, kScreenHeight)];
    [skView presentScene:_loginScene];
    
    
    __weak typeof(self) weekSelf = self;
    [_loginScene setStartWithLevelName:^(NSString *mapName, NSString *personName) {
        [weekSelf startWithMapName:mapName personName:personName];
    }];
    
    
    
    //fire按钮
    _fireView = [[JYFireView alloc] initWithFrame:CGRectMake(kScreenWidth / 2.0, 0, kScreenWidth / 2.0, kScreenHeight)];
    _fireView.hidden = YES;
    [self.view addSubview:_fireView];
    
    [_fireView setFireBlock:^{
        [weekSelf fireAction];
    }];
    
    [_fireView setWeapon1Block:^{
        [weekSelf weapon1Action];
    }];
    
    
    //操作视图
    _operationV = [[JYOperationView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth / 2.0, kScreenHeight)];
    _operationV.hidden = YES;
    [self.view addSubview:_operationV];
    
    [_operationV setMoveBlock:^(NSString *direction, CGFloat speed) {
        
        [weekSelf moveAction:direction speed:speed];
    }];
    
    [_operationV setStopBlock:^{
        [weekSelf stop];
    }];
    

}

- (void)weapon1Action{

    _operationV.canUse = NO;
    _operationV.hidden = YES;
    [_appearScene weapon1];
    
}

- (void)fireAction{
    [_appearScene fire];
}

- (void)stop{
    [_appearScene stopAction];
}

- (void)canUseOperation:(int)fireType{
    
    [_fireView setFireType:fireType];
    _operationV.canUse = YES;
    _operationV.hidden = NO;

}

- (void)moveAction:(NSString *)direction speed:(CGFloat)speed
{
    [_appearScene moveAction:direction speed:speed];
}

- (void)startWithMapName:(NSString *)mapName
              personName:(NSString *)personName
{
    [self hiddenOperation:NO];
    Class mapClass = NSClassFromString(mapName);
    JYBaseScene *sence = [mapClass nodeWithFileNamed:mapName];
    SKView *skView = (SKView *)self.view;
    sence.personName = personName;
    _appearScene = sence;
    [skView presentScene:sence];
    
   
    __weak typeof(self)weekSelf = self;
    [sence setGameOver:^{
        [weekSelf hiddenOperation:YES];
    }];
    
    [sence setStartGame:^{
        [weekSelf startWithMapName:mapName personName:personName];
    }];
    
    [sence setWeapon1Finish:^(int count){
        
        [weekSelf canUseOperation:count];
    }];
}

- (void)hiddenOperation:(BOOL)isHidden
{
    _operationV.hidden = isHidden;
    _fireView.hidden = isHidden;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
