//
//  main.m
//  DBLetto
//
//  Created by Zhang Yuchen on 2013/12/14.
//  Copyright (c) 2013年 Zhang Yuchen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DBLAppDelegate.h"


#define SKRGB(r,g,b) [SKColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

int main(int argc, char * argv[])
{
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([DBLAppDelegate class]));
    }
}
