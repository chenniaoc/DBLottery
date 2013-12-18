//
//  DBLGameMenuViewViewController.m
//  DBLetto
//
//  Created by zhangyuchen on 13-12-17.
//  Copyright (c) 2013年 Zhang Yuchen. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "DBLGameMenuViewViewController.h"
#import "DBLFanNode.h"
#import "DBLCommmonMacro.h"


@interface DBLMenuScene : SKScene

@end

@implementation DBLMenuScene

-(SKShapeNode *)newTurnplate
{
    SKShapeNode *turnplate = [SKShapeNode node];
    CGMutablePathRef turnplatePath = CGPathCreateMutable();

    CGPathAddEllipseInRect(turnplatePath, NULL, CGRectMake(0, 0, 250, 250));
    
    turnplate.path = turnplatePath;

    turnplate.position = (CGPoint){(320-250)/2.0,self.view.frame.size.height/2 - 250/2.0};
    turnplate.strokeColor = [SKColor yellowColor];
    turnplate.fillColor = [SKColor whiteColor];
    
    
    turnplate.userInteractionEnabled = YES;
    turnplate.alpha = 0.8f;
    
    //fan shapes start here
    for (int i=0; i<33; i++) {
        DBLFanNode *fanNode = [DBLFanNode node];//[DBLFanNode nodeWithStartAngle:360/16.0f * i endAngle:360/16.0f * (i + 1)];
        fanNode.startAngle = 360/16.0f * i;
        fanNode.endAngle = 360/16.0f * (i + 1);
        fanNode.number = [NSString stringWithFormat:@"%d",(i + 1)];
        [fanNode drawContents];
        [turnplate addChild:fanNode];
    }
    
    
    CGPathRelease(turnplatePath);
    return turnplate;
}

- (void)didMoveToView:(SKView *)view
{
    self.backgroundColor = SKRGB(255, 69, 0);
    [self addChild:[self newTurnplate]];
}

@end


@interface DBLGameMenuViewViewController ()

@end

@implementation DBLGameMenuViewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    SKView *view = (SKView *)self.view;
    view.showsFPS = YES;
    view.showsDrawCount = YES;
    view.showsNodeCount = YES;
    
    DBLMenuScene *menuScene = [[DBLMenuScene alloc] initWithSize:[UIScreen mainScreen].bounds.size];
    [view presentScene:menuScene];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


