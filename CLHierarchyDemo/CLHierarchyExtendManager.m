//
//  CLHierarchyExtendManager.m
//  CLHierarchyDemo
//
//  Created by 张征鸿 on 2021/3/31.
//

#import "CLHierarchyExtendManager.h"

const CLHierarchyLevel CLViewHierarchyLevelUnknown = 0.f;
CLHierarchyNodeIdentify CLFirstContainerViewId = @"com.hierarchy.first.container";

@implementation CLHierarchyExtendManager

- (NSSet<NSDictionary<CLHierarchyNodeIdentify, NSNumber *> *> *)hierarchySet {
    static NSSet *hierarchySet = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hierarchySet = [NSSet setWithArray:@[
            self.roomHierarchy,
        ]];
    });
    return hierarchySet;
}

- (NSDictionary<NSString *,NSNumber *> *)roomHierarchy {
    static NSDictionary *hierarchy = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hierarchy = @{
            CLFirstContainerViewId : @1,
        };
    });
    return hierarchy;
}

- (CLHierarchyLevel)levelWithId:(CLHierarchyNodeIdentify)identify {
    __block CLHierarchyLevel level = CLViewHierarchyLevelUnknown;
    if (!identify.length) return level;
    
    [self.hierarchySet enumerateObjectsUsingBlock:^(NSDictionary<NSString *,NSNumber *> * _Nonnull obj, BOOL * _Nonnull stop) {
        NSNumber *levelNumber = obj[identify];
        if (!levelNumber) return;
        
        level = levelNumber.floatValue;
        *stop = YES;
    }];
    return level;
}


@end
