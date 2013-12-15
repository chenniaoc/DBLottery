//
//  DBLDoubleBallView.h
//  DBLetto
//
//  Created by Zhang Yuchen on 2013/12/15.
//  Copyright (c) 2013年 Zhang Yuchen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    BallColorBlue,
    BallColorRed,
}BallColor;

@interface DBLDoubleBallView : UIView

@property(nonatomic,copy) NSString *number;
@property(nonatomic,assign) BOOL selected;
@property(nonatomic,strong) UIColor *color;

- (id)initWithFrame:(CGRect)frame Number:(NSString *)number;

- (id)initWithFrame:(CGRect)frame Number:(NSString *)number Color:(UIColor *)color;

@end
