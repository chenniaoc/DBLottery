//
//  DBLMainViewController.m
//  DBLetto
//
//  Created by Zhang Yuchen on 2013/12/15.
//  Copyright (c) 2013年 Zhang Yuchen. All rights reserved.
//

#import "DBLMainViewController.h"
#import "DBLDoubleBallView.h"
#import "DBLHistoryDataHelper.h"

static const int kBallHeight = 30;
static const int kBallWidth = 30;
static const int kBallVerticalPadding = kBallHeight + 4;
static const int kBallHorizontalPadding = kBallWidth + 4;

@interface DBLMainViewController ()

@end

@implementation DBLMainViewController

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
    
    _historyDataHelper = [[DBLHistoryDataHelper alloc] init];
    
    int heightCounter = 0;
    
    for (int i=0; i<33; i++) {
        NSString *ballNumber = [NSString stringWithFormat:@"%.2d",i + 1];
        static int newLineCount = 0;
        newLineCount = i % 7 == 0 ? newLineCount + 1:newLineCount;
        DBLDoubleBallView *ballView = [[DBLDoubleBallView alloc]initWithFrame:
                                       (CGRect){30 + ( i % 7 * kBallHorizontalPadding),
                                        80 + (newLineCount * (kBallVerticalPadding)),
                                           kBallWidth,kBallHeight} Number:ballNumber Color:[UIColor redColor]];
        
        heightCounter = 80 + (newLineCount * (kBallVerticalPadding));
        [self.view addSubview:ballView];
    }
    int buttonHeight = 0;
    for (int i=0; i<16; i++) {
        NSString *ballNumber = [NSString stringWithFormat:@"%.2d",i + 1];
        static int newLineCount = 0;
        newLineCount = i % 7 == 0 ? newLineCount + 1:newLineCount;
        DBLDoubleBallView *ballView = [[DBLDoubleBallView alloc]initWithFrame:
                                       (CGRect){30 + ( i % 7 * kBallHorizontalPadding),
                                           heightCounter + (newLineCount * (kBallVerticalPadding)),
                                           kBallWidth,kBallHeight} Number:ballNumber Color:[UIColor blueColor]];
        buttonHeight = heightCounter + (newLineCount * (kBallVerticalPadding));
        
        [self.view addSubview:ballView];
    }
    
    UIButton *genereteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [genereteButton setTitle:@"开始狂撸" forState:UIControlStateNormal];
    genereteButton.frame = CGRectMake(30, buttonHeight + 20, 120, 80);
    [genereteButton addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:genereteButton];
	// Do any additional setup after loading the view.
    
}

-(void)start:(UIButton *)sender
{
    NSLog(@"start");
    NSMutableArray *selectedRedBall = [NSMutableArray array];
    NSMutableArray *selectedBlueBall = [NSMutableArray array];
    for (UIView *subView in self.view.subviews) {
        if ([subView isKindOfClass:[DBLDoubleBallView class]]) {
            DBLDoubleBallView *ballView = (DBLDoubleBallView *)subView;
            if(ballView.selected) {
                if ([ballView.color isEqual:[UIColor redColor]]) {
                    [selectedRedBall addObject:ballView.number];
                } else {
                    [selectedBlueBall addObject:ballView.number];
                }
            }
            
        }
    }
    //NSLog(@"red:%@",[selectedRedBall description]);
    //NSLog(@"blue:%@",[selectedBlueBall description]);
    
    NSString *redResult = [_historyDataHelper generateRandomByCustimzedValues:selectedRedBall maxCount:6];
    NSString *blueResult = [_historyDataHelper generateRandomByCustimzedValues:selectedBlueBall maxCount:1];
    NSLog(@"red:%@",redResult);
    NSLog(@"blue:%@",blueResult);
    
    NSString *alsertString = [NSString stringWithFormat:@"redBall:\n%@\n blue ball:\n%@",redResult,blueResult];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"祝愿大猛哥中奖500万" message:alsertString delegate:nil cancelButtonTitle:@"中了必须分张洋大爹一份" otherButtonTitles:nil];
    [alertView show];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
