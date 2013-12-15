//
//  DBLHistoryDataHelper.h
//  DBLetto
//
//  Created by Zhang Yuchen on 2013/12/14.
//  Copyright (c) 2013年 Zhang Yuchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBLHistoryDataHelper : NSObject

@property(nonatomic,strong) NSMutableSet *historyDataSet;
@property(nonatomic,strong) NSMutableDictionary *historyDataDictionary;

- (NSString *)generateRandomPermutation;
- (BOOL)isEverOpenedPermutationWithPermutation:(NSString *)permutation;
- (NSString *)generateRandomByCustimzedValues:(NSArray *)values maxCount:(int)maxCount;

@end
