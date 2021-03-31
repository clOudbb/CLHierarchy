//
//  CLHierarchyExtendManager.h
//  CLHierarchyDemo
//
//  Created by 张征鸿 on 2021/3/31.
//

#import <CLHierarchy/CLHierarchy.h>

NS_ASSUME_NONNULL_BEGIN

#define CL_ADD_VIEW_HIERARCHY(manager, attributes)\
{\
    CLViewHierarchyNodeMaker *make = [manager make];\
    if (make) \
        attributes\
    [manager addWithMaker:make];\
}

#define CL_UPDATE_VIEW_HIERARCHY(manager, attributes)\
{\
    CLViewHierarchyNodeMaker *make = [manager make];\
    if (make) \
        attributes\
    [manager updateWithMaker:make];\
}


UIKIT_EXTERN const CLHierarchyLevel CLViewHierarchyLevelUnknown; // unknown = 0.f

UIKIT_EXTERN CLHierarchyNodeIdentify CLFirstContainerViewId;

@interface CLHierarchyExtendManager : NSObject

- (NSDictionary<CLHierarchyNodeIdentify, NSNumber *> *)roomHierarchy;

- (CLHierarchyLevel)levelWithId:(CLHierarchyNodeIdentify)identify;

@end

NS_ASSUME_NONNULL_END
