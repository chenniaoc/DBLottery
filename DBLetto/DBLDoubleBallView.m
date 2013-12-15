//
//  DBLDoubleBallView.m
//  DBLetto
//
//  Created by Zhang Yuchen on 2013/12/15.
//  Copyright (c) 2013年 Zhang Yuchen. All rights reserved.
//

#import "DBLDoubleBallView.h"

@interface DBLDoubleBallView (){
    UITapGestureRecognizer *tap ;
    BOOL _selected;
    UIColor *_color;
}

@end

@implementation DBLDoubleBallView

- (id)initWithFrame:(CGRect)frame Number:(NSString *)number
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _number = number;
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedMe:)];
        self.backgroundColor = [UIColor clearColor];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame Number:(NSString *)number Color:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _number = number;
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedMe:)];
        _color = color;
        self.backgroundColor = [UIColor clearColor];
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)tappedMe:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint point = [gestureRecognizer locationInView:self];
    NSLog(@"tapped me %f %f",point.x,point.y);
    _selected = !_selected;
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextAddEllipseInRect(ctx,rect);
    CGColorRef ballColor = !_selected?[_color CGColor]:[[UIColor greenColor] CGColor];
    CGContextSetFillColor(ctx, CGColorGetComponents(ballColor));
    CGContextFillPath(ctx);
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentCenter];
    NSDictionary *attr = [NSDictionary dictionaryWithObject:style forKey:NSParagraphStyleAttributeName];
    [_number drawInRect:rect withAttributes:attr];

    
    NSLog(@"%d",_selected);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
