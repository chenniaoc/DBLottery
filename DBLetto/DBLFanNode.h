//
//  DBLFanNode.h
//  DBLetto
//
//  Created by zhangyuchen on 13-12-17.
//  Copyright (c) 2013年 Zhang Yuchen. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DBLFanNode : SKShapeNode

@property(nonatomic,copy) NSString *number;
@property(nonatomic,assign) CGFloat startAngle,endAngle,unitAngleSize;

+(instancetype)nodeWithStartAngle:(CGFloat) start endAngle:(CGFloat)end;

- (void)drawContents;

@end
