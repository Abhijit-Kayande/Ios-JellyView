//
//  JellyView.m
//  JellyView
//
//  Created by Abhi on 02/01/15.
//  Copyright (c) 2015 Abhi. All rights reserved.
//

#import "JellyView.h"


@interface JellyView ()



@property (strong, nonatomic) CAShapeLayer *viewLayer;
@property (strong, nonatomic) CAShapeLayer *Diagonal;
@property (strong, nonatomic) NSMutableArray *JointsArray;
@property (strong, nonatomic) CADisplayLink *displayLink;
@property (strong, nonatomic) UIView *ReferenceView;
@end

@implementation JellyView


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(id)initWithFrame:(CGRect)frame andReferenceView:(UIView *)RView
{

    self = [super initWithFrame:frame];
    if (self) {
        
        _ReferenceView=RView;
        _Damping=0.5;
        _Frequency=50;
        _Elasticity=0.5;
        _Density=2;
        _Resistance=0;
        _Friction=0;
        _AngularResistance=0;
        _color = [UIColor purpleColor];
        
        
        [_ReferenceView addSubview:self];
        
        [self SetupViews];
        
        
        
    }
    
    
    
    return self;


}



-(void)SetupViews
{

    _JointsArray = [[NSMutableArray alloc] init];
    
    float Width = self.frame.size.width;
    
    float Height = self.frame.size.height;
    
    
    UIView *Point1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    
    [Point1 setBackgroundColor:[UIColor clearColor]];
    
    [self addSubview:Point1];
    
    [_JointsArray addObject:Point1];
    
    
    
    
    
    UIView *Point2 = [[UIView alloc] initWithFrame:CGRectMake((Width/2)-5, 0, 10, 10)];
    
    [Point2 setBackgroundColor:[UIColor clearColor]];
    
    [self addSubview:Point2];
    
    [_JointsArray addObject:Point2];
    
    
    
    
    UIView *Point3 = [[UIView alloc] initWithFrame:CGRectMake(Width-10, 0, 10, 10)];
    
    [Point3 setBackgroundColor:[UIColor clearColor]];
    
    [self addSubview:Point3];
    
    [_JointsArray addObject:Point3];
    
    
    
    
    
    UIView *Point4 = [[UIView alloc] initWithFrame:CGRectMake(Width-10, (Height/2)-5, 10, 10)];
    
    [Point4 setBackgroundColor:[UIColor clearColor]];
    
    [self addSubview:Point4];
    
    [_JointsArray addObject:Point4];
    
   
    
    
    
    
    UIView *Point5 = [[UIView alloc] initWithFrame:CGRectMake(Width-10, Height-10, 10, 10)];
    
    [Point5 setBackgroundColor:[UIColor clearColor]];
    
    [self addSubview:Point5];
    
    [_JointsArray addObject:Point5];
    
    
    
    
    
    UIView *Point6 = [[UIView alloc] initWithFrame:CGRectMake((Width/2)-5, Height-10, 10, 10)];
    
    [Point6 setBackgroundColor:[UIColor clearColor]];
    
    [self addSubview:Point6];
    
    [_JointsArray addObject:Point6];
    
    
    
    
    
    UIView *Point7 = [[UIView alloc] initWithFrame:CGRectMake(0, Height-10, 10, 10)];
    
    [Point7 setBackgroundColor:[UIColor clearColor]];
    
    [self addSubview:Point7];
    
    [_JointsArray addObject:Point7];
    
    
   
    
    
    
    
    
    UIView *Point8 = [[UIView alloc] initWithFrame:CGRectMake(0, (Height/2)-5, 10, 10)];
    
    [Point8 setBackgroundColor:[UIColor clearColor]];
    
    [self addSubview:Point8];
    
    [_JointsArray addObject:Point8];
    
    
   
    
    
    
    
    _JellyCenterView = [[UIView alloc] initWithFrame:CGRectMake((Width/2)-5, (Height/2)-5, 10, 10)];
    
    [_JellyCenterView setBackgroundColor:[UIColor clearColor]];
    
    
    [self addSubview:_JellyCenterView];
    
    
    [self AttachViews];

}

-(void)AttachViews
{
    
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:_ReferenceView];
    
    
    for (int i=0; i<[_JointsArray count]; i++) {
        
        
        UIAttachmentBehavior *attach;
        
        if (i==[_JointsArray count]-1) {
            
            attach = [[UIAttachmentBehavior alloc] initWithItem:[_JointsArray objectAtIndex:i] attachedToItem:[_JointsArray objectAtIndex:0]];
            
        }
        else
        {
            
            attach = [[UIAttachmentBehavior alloc] initWithItem:[_JointsArray objectAtIndex:i] attachedToItem:[_JointsArray objectAtIndex:i+1]];
            
        }
        
        
        attach.damping = _Damping;
        attach.frequency = _Frequency;
        
        
        [_animator addBehavior:attach];
        
        
        
        if (i % 2 == 0) {
            
            UIAttachmentBehavior *AttachToCenter = [[UIAttachmentBehavior alloc] initWithItem:[_JointsArray objectAtIndex:i] attachedToItem:_JellyCenterView];
            
            
            AttachToCenter.damping = _Damping;
            AttachToCenter.frequency = _Frequency;
            
            
            [_animator addBehavior:AttachToCenter];
        }
        
        
        
        
        UIDynamicItemBehavior *bh = [[UIDynamicItemBehavior alloc]initWithItems:@[[_JointsArray objectAtIndex:i]]];
        bh.elasticity = _Elasticity;
        bh.density = _Density;
        bh.resistance = _Resistance;
        bh.friction = _Friction;
        bh.angularResistance = _AngularResistance;
        [_animator addBehavior:bh];
        
    }
    

    
    [self show];

}




- (void) show {
    
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(MaskJellyView)];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
}



-(void)MaskJellyView
{
    
    
    UIBezierPath *Path = [[UIBezierPath alloc] init];
    
    [Path moveToPoint:[[_JointsArray objectAtIndex:0] center]];
    
    [Path addQuadCurveToPoint:[[_JointsArray objectAtIndex:2] center] controlPoint:[[_JointsArray objectAtIndex:1] center]];
    
    [Path addQuadCurveToPoint:[[_JointsArray objectAtIndex:4] center] controlPoint:[[_JointsArray objectAtIndex:3] center]];
    
    [Path addQuadCurveToPoint:[[_JointsArray objectAtIndex:6] center] controlPoint:[[_JointsArray objectAtIndex:5] center]];
    
    [Path addQuadCurveToPoint:[[_JointsArray objectAtIndex:0] center] controlPoint:[[_JointsArray objectAtIndex:7] center]];
    
    
    
    if (!_viewLayer) {
        _viewLayer = [CAShapeLayer layer];
        _viewLayer.fillColor = _color.CGColor;
        _viewLayer.cornerRadius = 10;
        [self.layer addSublayer:_viewLayer];
    }
    
    _viewLayer.path = Path.CGPath;
    
    if (_DisplaySkeleton) {
        
        _viewLayer.fillColor = [UIColor clearColor].CGColor;
        _viewLayer.strokeColor = [UIColor blackColor].CGColor;
        
        UIBezierPath *DiagonalPath = [[UIBezierPath alloc] init];
        
        [DiagonalPath moveToPoint:[[_JointsArray objectAtIndex:0] center]];
        
        [DiagonalPath addLineToPoint:[[_JointsArray objectAtIndex:4] center]];
        
        [DiagonalPath moveToPoint:[[_JointsArray objectAtIndex:6] center]];
        
        [DiagonalPath addLineToPoint:[[_JointsArray objectAtIndex:2] center]];
        
        
        if (!_Diagonal) {
            
            _Diagonal = [CAShapeLayer layer];
            _Diagonal.fillColor = [UIColor clearColor].CGColor;
            _Diagonal.strokeColor = [UIColor blackColor].CGColor;
            [self.layer addSublayer:_Diagonal];
            
            for (UIView *View in _JointsArray) {
                [View setBackgroundColor:[UIColor lightGrayColor]];
            }
            
            [_JellyCenterView setBackgroundColor:[UIColor lightGrayColor]];
            
        }
        
        _Diagonal.path = DiagonalPath.CGPath;
        
        
        
        
        
    }
    else
    {
        _viewLayer.fillColor = _color.CGColor;
        _viewLayer.strokeColor = [UIColor clearColor].CGColor;
        
        if (_Diagonal) {
            [_Diagonal removeFromSuperlayer];
            _Diagonal=nil;
            
            for (UIView *View in _JointsArray) {
                [View setBackgroundColor:[UIColor clearColor]];
            }
            
            [_JellyCenterView setBackgroundColor:[UIColor clearColor]];
            
        }
        
        
    
    }
    
    
}

@end
