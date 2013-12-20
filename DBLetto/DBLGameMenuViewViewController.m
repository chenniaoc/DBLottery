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
@property(nonatomic,assign) BOOL isRotating;
@property(nonatomic,assign) NSInteger turnplateNumber;
@end

@implementation DBLMenuScene

-(SKShapeNode *)newTurnplateWithNumbers:(NSInteger)numberOfFan
{
    SKShapeNode *turnplate = [SKShapeNode node];
    CGMutablePathRef turnplatePath = CGPathCreateMutable();

    CGPathAddEllipseInRect(turnplatePath, NULL, CGRectMake(0, 0, 250, 250));
    
    turnplate.path = turnplatePath;

    //turnplate.position = (CGPoint){(320-250)/2.0,self.view.frame.size.height/2 - 250/2.0};
    turnplate.position = (CGPoint){-125,-125};

    turnplate.strokeColor = [SKColor yellowColor];
    turnplate.fillColor = [SKColor whiteColor];
    
    
    turnplate.userInteractionEnabled = NO;
    turnplate.alpha = 0.8f;
    
    //fan shapes start here
    for (int i=0; i<numberOfFan; i++) {
        DBLFanNode *fanNode = [DBLFanNode node];//[DBLFanNode nodeWithStartAngle:360/16.0f * i endAngle:360/16.0f * (i + 1)];
        
        fanNode.startAngle = 360.0/numberOfFan * i;
        fanNode.endAngle = 360.0/numberOfFan * (i + 1);
        fanNode.number = [NSString stringWithFormat:@"%d",(i + 1)];
        fanNode.fillColor = (i % 2 ==0)?SKRGB(252, 241, 199):SKRGB(255, 255, 255);
        [fanNode drawContents];
        [turnplate addChild:fanNode];
    }
    
    
    CGPathRelease(turnplatePath);
    return turnplate;
}

- (void)didMoveToView:(SKView *)view
{
    self.backgroundColor = SKRGB(255, 69, 0);
    SKNode *hover = [SKNode node];
    hover.position = CGPointMake(320/2, 480/2 + 125);
    hover.name = @"turnPlateHover";
    
    SKNode *turnPlate = [self newTurnplateWithNumbers:16];

    turnPlate.name = @"turnPlateNode";
    [hover addChild:turnPlate];
    [self addChild:hover];
    

    SKAction *rotateAction = [SKAction rotateToAngle:6000 * 3.1415926 duration:60*60*24];
    //SKAction *repeatRotateAction = [SKAction repeatActionForever:rotateAction];
    [hover runAction:rotateAction];
    
    double delayInSeconds = 10.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //[hover removeAllActions];
    });
    
    UIButton *changeNumbersButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [changeNumbersButton setTitle:@"change to 32" forState:UIControlStateNormal];
    changeNumbersButton.frame = CGRectMake(320/2+20, 350, 100, 50);
    changeNumbersButton.backgroundColor = [UIColor whiteColor];
    [changeNumbersButton addTarget:self action:@selector(changeNumbers:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeNumbersButton];
    _turnplateNumber = 16;
    
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [startButton setTitle:@"start" forState:UIControlStateNormal];
    startButton.frame = CGRectMake(320/2-100-20, 350, 100, 50);
    startButton.backgroundColor = [UIColor whiteColor];
    [startButton addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    _isRotating = NO;
}

-(void)changeNumbers:(UIButton *)sender
{
    SKNode *hoverNode = [self childNodeWithName:@"turnPlateHover"];
    [hoverNode removeAllChildren];
    switch (_turnplateNumber) {
        case 16:
        {
            [sender setTitle:@"change to 33" forState:UIControlStateNormal];
            _turnplateNumber = 33;
            //SKNode *turnPlate = [self newTurnplateWithNumbers:33];
            SKNode *turnPlate = [self newTurnplateWithNumbers:33];
            [hoverNode addChild:turnPlate];
            break;
        }
        case 33:
        {
            [sender setTitle:@"change to 16" forState:UIControlStateNormal];
            _turnplateNumber = 16;
            SKNode *turnPlate = [self newTurnplateWithNumbers:_turnplateNumber];
            [hoverNode addChild:turnPlate];
            break;
        }
        default:
            break;
    }
}

-(void)start:(UIButton *)sender
{
    SKNode *hover = [self childNodeWithName:@"turnPlateHover"];
    if (!_isRotating) {
        SKAction *rotateAction = [SKAction rotateToAngle:10000 * 3.1415926 duration:60*60];
        //SKAction *repeatRotateAction = [SKAction repeatActionForever:rotateAction];
        [hover runAction:rotateAction];
        [sender setTitle:@"stop" forState:UIControlStateNormal];
    } else
    {
        [hover removeAllActions];
        [sender setTitle:@"start" forState:UIControlStateNormal];
    }
    _isRotating = !_isRotating;
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


