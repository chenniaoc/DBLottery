//
//  DBLFanNode.m
//  DBLetto
//
//  Created by zhangyuchen on 13-12-17.
//  Copyright (c) 2013年 Zhang Yuchen. All rights reserved.
//

#import "DBLFanNode.h"
#import "DBLCommmonMacro.h"

#import <objc/runtime.h>
#import <objc/message.h>


@interface DBLFanNode()

@property(nonatomic,strong) NSMutableDictionary *backStoreDic;

@end

@implementation DBLFanNode

@dynamic number;

static id PropertyIMP(id self,SEL aSel)
{
    return [[self backStoreDic] objectForKey:NSStringFromSelector(aSel)];
}

static void SetPropertyIMP(id self,SEL aSet,id aValue)
{
    NSMutableString *key = [NSStringFromSelector(aSet) mutableCopy];
    id value = [aValue mutableCopy];
    
    [key deleteCharactersInRange:NSRangeFromString(@"0,3")];
    [key deleteCharactersInRange:NSMakeRange([key length] - 1, 1)];
    [key replaceCharactersInRange:NSMakeRange(0, 1) withString:[[key substringToIndex:1] lowercaseString]];
    
    //NSLog(@"set val:%@ for key:%@",value,key);
    [[self backStoreDic] setValue:value forKey:key];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _backStoreDic = [[NSMutableDictionary alloc] init];
    }
    return self;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    NSString *selString = NSStringFromSelector(sel);
    
    //NSLog(@"%@",NSStringFromSelector(_cmd));
    if ([selString hasPrefix:@"set"]) {
        class_addMethod([DBLFanNode class], sel, (IMP)SetPropertyIMP, "v@:@");
        return YES;
    } else {
        class_addMethod([DBLFanNode class], sel, (IMP)PropertyIMP, "@@:");
        return YES;
    }
    
    return NO;
    
}

+(instancetype)nodeWithStartAngle:(CGFloat) start endAngle:(CGFloat)end
{
    id node = [super node];
    DBLFanNode *myNode = (DBLFanNode *)node;
    myNode.startAngle = start;
    myNode.endAngle = end;
    
    return node;
}

- (void)drawContents
{
    CGMutablePathRef myFanPath = CGPathCreateMutable();
    CGPathAddArc(myFanPath, NULL, 250/2, 250/2, 250/2, Degree_2_Radian(self.startAngle), Degree_2_Radian(self.endAngle), NO);
    CGPathAddLineToPoint(myFanPath, NULL, 250/2, 250/2);
    static BOOL onceFlag = YES;
    //NSLog(@"%f",Degree_2_Radian(self.endAngle) - Degree_2_Radian((self.endAngle- self.startAngle)));
    // the radian value to the number text
    float unitRadian = Degree_2_Radian(self.endAngle) - Degree_2_Radian((self.endAngle- self.startAngle)) + 0.392699/2;
    float radius = sqrt(100*100 + 10*10);
    //NSLog(@"radius: %f %f",radius,100 / cos( Degree_2_Radian((self.endAngle- self.startAngle)) ) );
    if (YES || onceFlag) {
        SKLabelNode *numberLabel = [SKLabelNode node];
        numberLabel.text = self.number;
        numberLabel.fontSize = 16.0f;
        numberLabel.fontColor = [SKColor blackColor];
        //numberLabel.zRotation = self.endAngle - 1;
        numberLabel.zPosition = 3;
        //float x2 = (100-250/2)*cos(-self.endAngle)-(10-250/2)*sin(-self.endAngle)+250/2 ;
        //float y2 = (10 - 250/2)*cos(-self.endAngle) + (100 - 250/2)*sin(-self.endAngle) + 250/2;
        float x2 = cos(unitRadian) * radius + 250/2 ;
        float y2 = sin(unitRadian) * radius + 250/2 ;
        NSLog(@"%f %f %f",unitRadian,x2,y2);
        //numberLabel.position = CGPointMake(250/2 + 100, 250/2 + 10);
        numberLabel.position = CGPointMake(x2, y2);
        [self addChild:numberLabel];
        onceFlag = NO;
    }

    self.path = myFanPath;
    self.fillColor = SKRGB(252, 241, 199);
    self.lineWidth = 0.01f;
    CGPathRelease(myFanPath);
}

@end
