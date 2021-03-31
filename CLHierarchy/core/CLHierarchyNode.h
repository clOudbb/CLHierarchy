//
//  CLHierarchyNode.h
//  bilianime
//
//  Created by 张征鸿 on 2021/3/3.
//  Copyright © 2021 clOudbb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLHierarchyCoreProtocol.h"
#import "CLHierarchyService.h"

NS_ASSUME_NONNULL_BEGIN

@interface CLHierarchyNode : NSObject <CLHierarchyNode>

@property (nonatomic, weak, readonly) id<CLHierarchyNode> supernode;

@property (nonatomic, assign, readonly) CLHierarchyLevel level; // 本节点的level

@property (nonatomic, copy, readonly) NSString *identity; // 本节点的名称

@property (nonatomic, assign, readonly) NSUInteger depth; //该节点的深度

@property (nonatomic, assign, readonly, getter=isRootNode) BOOL rootNode;

@property (nonatomic, copy, readonly) NSArray<id<CLHierarchyNode>> *subnodes;

- (instancetype)initWithService:(nullable CLHierarchyService *)service
                       identify:(nonnull NSString *)identify
                          level:(CLHierarchyLevel)level
                      supernode:(nullable id<CLHierarchyNode>)supernode;

@end

@interface CLHierarchyNode (NodeHierarchy)

- (void)willAddSubnode:(id<CLHierarchyNode>)node;
- (void)didAddSubnode:(id<CLHierarchyNode>)node;

- (void)willRemoveSubnode:(id<CLHierarchyNode>)node;
- (void)didRemoveSubnode:(id<CLHierarchyNode>)node;

- (void)willInsertNode:(id<CLHierarchyNode>)node atIndex:(NSUInteger)index;
- (void)didInsertedNode:(id<CLHierarchyNode>)node atIndex:(NSUInteger)index;

- (void)willInsertNode:(id<CLHierarchyNode>)node belowNode:(id<CLHierarchyNode>)siblingNode;
- (void)didInsertedNode:(id<CLHierarchyNode>)node belowNode:(id<CLHierarchyNode>)siblingNode;

- (void)willInsertNode:(id<CLHierarchyNode>)node aboveNode:(id<CLHierarchyNode>)siblingNode;
- (void)didInsertedNode:(id<CLHierarchyNode>)node aboveNode:(id<CLHierarchyNode>)siblingNode;

- (void)orderWithRule:(id)rule;

@end

@interface CLHierarchyNode (NodeFormatter)

- (NSString *)format;
- (NSString *)defaultFormat;
- (NSString *)prefixFormat;

@end


/**
{
 id: 1,
 level: 0,
 root: true,
 attr: [],
 subnodes: [{
     id: 1,
     level: 0,
     root: false,
     attr: [],
     subnodes: [{}]
 }]
}
 */
NS_ASSUME_NONNULL_END
