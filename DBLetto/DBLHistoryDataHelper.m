//
//  DBLHistoryDataHelper.m
//  DBLetto
//
//  Created by Zhang Yuchen on 2013/12/14.
//  Copyright (c) 2013年 Zhang Yuchen. All rights reserved.
//

#import "DBLHistoryDataHelper.h"

#define kDATA_PATH @"all_fixed_db"

@implementation DBLHistoryDataHelper

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSError *error ;
        NSString *path = [[NSBundle mainBundle] pathForResource:kDATA_PATH ofType:@"csv"];
        NSString *tempSting = [NSString stringWithContentsOfFile:path
                                                        encoding:NSUTF8StringEncoding error:&error];
        NSArray *speratedByLineArray = [tempSting componentsSeparatedByString:@"\n"];
        NSLog(@"%@",[error description]);
        
        _historyDataDictionary = [NSMutableDictionary dictionaryWithCapacity:2000];
        _historyDataSet = [NSMutableSet setWithCapacity:2000];
        for (NSString *line in speratedByLineArray) {
            NSArray *fields = [line componentsSeparatedByString:@","];
            NSString *key = [fields objectAtIndex:0];
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:(NSRange){1,[fields count] - 1}];
            NSArray *value = [fields objectsAtIndexes:indexSet];
            NSMutableString *numberString = [NSMutableString string];
            for (NSString *number in value) {
                [numberString appendFormat:@"%@,",number];
            }
            [numberString deleteCharactersInRange:(NSRange){[numberString length] - 1,1}];
            
            [_historyDataDictionary setValue:numberString forKey:key];
            [_historyDataSet addObject:numberString];
            
        }
        
    }
    return self;
}

- (BOOL)isEverOpenedPermutationWithPermutation:(NSString *)permutation
{
    return [_historyDataSet containsObject:permutation];
}

- (NSString *)generateRandomPermutation{
    
    NSMutableArray *result = [NSMutableArray array];
    int counter = 0;
    while (YES) {
        counter++;
        while ([result count] < 7) {
            int modNumer = 16;
            if ([result count] <6) {
                modNumer = 33;
            }
            
            NSNumber *oneValue = [NSNumber numberWithInt:(arc4random() % modNumer)+1];
            if (![result containsObject:oneValue] || modNumer == 16) {
                [result addObject:[oneValue stringValue]];
            }
        }
        NSMutableString *numberString = [NSMutableString string];
        for (NSString *number in result) {
            [numberString appendFormat:@"%@,",number];
        }
        [numberString deleteCharactersInRange:(NSRange){[numberString length] - 1,1}];
        if (![_historyDataSet containsObject:numberString]) {
            NSLog(@"congratulations %@ ,loop counter is %d",[result description],counter);
            break;
            return numberString;
        }
        
        [result removeAllObjects];
    }
    return @"";
}


- (NSString *)generateRandomByCustimzedValues:(NSArray *)values maxCount:(int)maxCount
{
    if (values == nil || [values count] < 1) {
        return @"";
    }
    NSMutableArray *resultArray = [NSMutableArray array];
    NSSet *set = [NSSet setWithArray:values];
    NSArray *uniqElementArray = [set allObjects];
    NSInteger modNumber = [uniqElementArray count];
    while (YES) {
        int randomIndex = arc4random() % modNumber;
        NSString *candidateNumber = uniqElementArray[randomIndex];
        if (![resultArray containsObject:candidateNumber]) {
            [resultArray addObject:candidateNumber];
        }
        if ([resultArray count] == modNumber || [resultArray count] == maxCount) {
            break;
        }
    }
    [resultArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    NSMutableString *numberString = [NSMutableString string];
    for (NSString *number in resultArray) {
        [numberString appendFormat:@"%@,",number];
    }
    [numberString deleteCharactersInRange:(NSRange){[numberString length] - 1,1}];
    NSLog(@"generateRandomByCustimzedValues %@",numberString);
    return numberString;
}



@end
