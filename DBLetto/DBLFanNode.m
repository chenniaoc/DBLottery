//
//  DBLFanNode.m
//  DBLetto
//
//  Created by zhangyuchen on 13-12-17.
//  Copyright (c) 2013年 Zhang Yuchen. All rights reserved.
//

#import "DBLFanNode.h"
#import "DBLCommmonMacro.h"

@implementation DBLFanNode

+(instancetype)nodeWithStartAngle:(CGFloat) start endAngle:(CGFloat)end
{
    id node = [super node];
    
    SKShapeNode *shapeNode = (SKShapeNode *)node;
    CGMutablePathRef myFanPath = CGPathCreateMutable();
    CGPathAddArc(myFanPath, NULL, 250/2, 250/2, 250/2, Degree_2_Radian(start), Degree_2_Radian(end), NO);
    CGPathAddLineToPoint(myFanPath, NULL, 250/2, 250/2);
    //CGPathMoveToPoint(myFanPath, NULL, 250/2, 250/2);
    shapeNode.path = myFanPath;
    shapeNode.fillColor = SKRGB(252, 241, 199);
    shapeNode.lineWidth = 0.01f;
    //shapeNode.position = CGPointMake(250/2, 250/2);
    CGPathRelease(myFanPath);
    
    return node;
}

@end
