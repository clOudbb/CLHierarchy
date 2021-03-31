//
//  CLHierarchyTree.h
//  bilianime
//
//  Created by 张征鸿 on 2021/3/3.
//  Copyright © 2021 clOudbb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLHierarchyNode.h"
#import "CLHierarchyService.h"

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN CLHierarchyNodeIdentify CLHierarchyRootNodeIdentify;

@class CLHierarchyTree;
@protocol CLHierarchyTreeDelegate <NSObject>
@optional

- (void)hierarchyTreeWillUpdate:(CLHierarchyTree *)hierarchyTree;
- (void)hierarchyTreeDidUpdated:(CLHierarchyTree *)hierarchyTree;

@end

@interface CLHierarchyTree<__covariant NodeType: id<CLHierarchyNode>> : NSObject

@property (nonatomic, strong, readonly) id<CLHierarchyNode> rootNode;
@property (nonatomic, weak, nullable) id<CLHierarchyTreeDelegate> delegate;

- (instancetype)initWithService:(CLHierarchyService *)service;

- (void)calibrate;

- (void)consoleLog;

@end

@interface CLHierarchyTree<NodeType> (Hierarchy) <CLHierarchyNode>

- (NodeType)retrieveWithIdentify:(NSString *)identify;

@end

NS_ASSUME_NONNULL_END
