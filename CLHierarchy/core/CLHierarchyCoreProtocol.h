//
//  CLHierarchyCoreProtocol.h
//  bilianime
//
//  Created by 张征鸿 on 2021/3/3.
//  Copyright © 2021 clOudbb. All rights reserved.
//

#ifndef CLHierarchyCoreProtocol_h
#define CLHierarchyCoreProtocol_h

#import <Foundation/Foundation.h>
#import "CLHierarchyBase.h"

@protocol CLHierarchyNode <NSObject>
@optional

@property (nonatomic, weak, readonly) id<CLHierarchyNode> supernode;

@property (nonatomic, assign, readonly) CLHierarchyLevel level; // 本节点的level

@property (nonatomic, copy, readonly) NSString *identity; // 本节点的名称  后边默认取类名 子类可自定扩展

@property (nonatomic, assign, readonly) NSUInteger depth; //该节点的深度

@property (nonatomic, copy, readonly) NSArray<id<CLHierarchyNode>> *subnodes;

@property (nonatomic, assign, readonly, getter=isRootNode) BOOL rootNode;

- (void)add:(id<CLHierarchyNode>)node;
- (void)delete:(id<CLHierarchyNode>)node;
- (void)remove:(id<CLHierarchyNode>)node;
- (void)clear;
- (void)clearAllSubnodes;
- (void)update:(id<CLHierarchyNode>)origin newNode:(id<CLHierarchyNode>)newNode;

@end

@protocol CLHierarchyPlugin <NSObject>

@end

#endif /* CLHierarchyCoreProtocol_h */
