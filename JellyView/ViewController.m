//
//  ViewController.m
//  JellyView
//
//  Created by Abhi on 02/01/15.
//  Copyright (c) 2015 Abhi. All rights reserved.
//

#import "ViewController.h"
#import "JellyView.h"

@interface ViewController ()

@property (strong, nonatomic) JellyView *JellyView;






@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _JellyView = [[JellyView alloc] initWithFrame:CGRectMake(100, 100, 200, 200) andReferenceView:self.view];
    
    _JellyView.Density = 10.1;
    _JellyView.Elasticity = 2.5;
    _JellyView.Damping = 10.1;
    _JellyView.Frequency = 0;
    _JellyView.Resistance = 0;
    _JellyView.Friction = 0;
    _JellyView.AngularResistance = 0;
    
    _JellyView.color = [UIColor redColor];
    
    
    
    [_JellyView SetupViews];
    
    
    
    UIPanGestureRecognizer *Pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(PanTheView:)];
    
    [self.view addGestureRecognizer:Pan];
    
    
    
    
    
    
    [self AddAnimations];
    
}
- (IBAction)SwitchSkeletonMode:(UISwitch *)sender {
    
    if ([sender isOn]) {
        _JellyView.DisplaySkeleton = YES;
        
    }
    else
    {
        _JellyView.DisplaySkeleton = NO;
        
    }
    
}


-(void)PanTheView:(UIPanGestureRecognizer *)Pan
{
    
    CGPoint Translation = [Pan translationInView:self.view];
    
    
    
    
    
    for (UIView *SubView in _JellyView.subviews) {
        
            SubView.center = CGPointMake(SubView.center.x + Translation.x, SubView.center.y + Translation.y);
            [_JellyView.animator updateItemUsingCurrentState:SubView];
        
    }
    
    _JellyView.JellyCenterView.center = CGPointMake(_JellyView.JellyCenterView.center.x + Translation.x, _JellyView.JellyCenterView.center.y + Translation.y);
    
    [_JellyView.animator updateItemUsingCurrentState:_JellyView.JellyCenterView];
    
    [Pan setTranslation:CGPointMake(0, 0) inView:self.view];
    
    
    
    

}

-(void)AddAnimations
{

    
    
    
   
    
    
    
    UIGravityBehavior *Gravity = [[UIGravityBehavior alloc] initWithItems:_JellyView.subviews];
    
    [_JellyView.animator addBehavior:Gravity];
    
    
    Gravity.action = ^{
    
       

    
    };
    
    
    
    UICollisionBehavior *Collision = [[UICollisionBehavior alloc] initWithItems:_JellyView.subviews];
    
    
    [Collision setTranslatesReferenceBoundsIntoBoundary:YES];
    
    [Collision setCollisionMode:UICollisionBehaviorModeEverything];
    
    
    
    [_JellyView.animator addBehavior:Collision];
    
    
    
    
    
    


}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
