//
//  JellyView.h
//  JellyView
//
//  Created by Abhi on 02/01/15.
//  Copyright (c) 2015 Abhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JellyView : UIView

@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) UIView *JellyCenterView;

@property (strong, nonatomic) UIColor *color;

//Call SetupViews function after setting these values
@property (nonatomic) float Damping;
@property (nonatomic) float Frequency;
@property (nonatomic) float Elasticity;
@property (nonatomic) float Density;
@property (nonatomic) float Resistance;
@property (nonatomic) float Friction;
@property (nonatomic) float AngularResistance;

@property (nonatomic) BOOL DisplaySkeleton;

-(id)initWithFrame:(CGRect)frame andReferenceView:(UIView *)RView;
-(void)SetupViews;

@end
