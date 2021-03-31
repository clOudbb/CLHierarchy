//
//  CLHierarchyTree.m
//  bilianime
//
//  Created by 张征鸿 on 2021/3/3.
//  Copyright © 2021 clOudbb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLHierarchyTree.h"
#import "CLHierarchyTree+Private.h"

CLHierarchyNodeIdentify CLHierarchyRootNodeIdentify = @"com.cloud.hierarchy.root.node";

@implementation CLHierarchyTree {
    CLHierarchyService *_service;
    
    NSMapTable<NSString *, id<CLHierarchyNode>> *_indexOfIdentify;
}

- (instancetype)initWithService:(CLHierarchyService *)service {
    if (self = [super init]) {
        _service = service;
        [self _setRootNode:[[CLHierarchyNode alloc] initWithService:service identify:CLHierarchyRootNodeIdentify level:0 supernode:nil]];
        _indexOfIdentify = [NSMapTable strongToWeakObjectsMapTable];
    }
    return self;
}

#pragma mark - public

/// 校准层级
- (void)calibrate {
//    [((CLHierarchyNode *)_rootNode) orderWithRule:xx];
}

- (void)consoleLog {
#ifdef DEBUG
    NSMutableString *string = @"\n".mutableCopy;
    [string appendString:[((CLHierarchyNode *)_rootNode) format]];
    NSLog(@"%@", string);
#endif
}

#pragma mark - private

- (void)_treeWillUpdate {
    if ([self.delegate respondsToSelector:@selector(hierarchyTreeWillUpdate:)]) {
        [self.delegate hierarchyTreeWillUpdate:self];
    }
}

- (void)_treeDidUpdated {
    if ([self.delegate respondsToSelector:@selector(hierarchyTreeDidUpdated:)]) {
        [self.delegate hierarchyTreeDidUpdated:self];
    }
}

- (void)_setRootNode:(CLHierarchyNode *)rootNode {
    if (rootNode != _rootNode) {
        _rootNode = rootNode;
    }
}

- (BOOL)_hasExisted:(id<CLHierarchyNode>)node {
    return [_indexOfIdentify objectForKey:node.identity] ? YES: NO;
}

@end

@implementation CLHierarchyTree (Hierarchy)

- (id<CLHierarchyNode>)retrieveWithIdentify:(NSString *)identify {
    if (!identify.length) return nil;
    
    return [_indexOfIdentify objectForKey:identify];
}

- (void)add:(id<CLHierarchyNode>)node {
    CLHierarchyLogInfo(@"node addition: %@", node);
    if (!node || [self _hasExisted:node]) return;
    
    [self _treeWillUpdate];
    [_rootNode add:node];
    if (node.identity) [_indexOfIdentify setObject:node forKey:node.identity];
    [self _treeDidUpdated];
}

- (void)delete:(id<CLHierarchyNode>)node {
    CLHierarchyLogInfo(@"node delete: %@", node);
    if (!node || ![self _hasExisted:node]) return;
    
    [self _treeWillUpdate];
    [_rootNode delete:node];
    if (node.identity) [_indexOfIdentify removeObjectForKey:node.identity];
    [self _treeDidUpdated];
}

- (void)remove:(id<CLHierarchyNode>)node {
    CLHierarchyLogInfo(@"node remove: %@", node);
    if (!node || ![self _hasExisted:node]) return;
    
    [self _treeWillUpdate];
    [_rootNode remove:node];
    if (node.identity) [_indexOfIdentify removeObjectForKey:node.identity];
    [self _treeDidUpdated];
}

- (void)clear {
    CLHierarchyLogInfo(@"node clear");
    [self _treeWillUpdate];
    [_rootNode clear];
    _rootNode = nil;
    [_indexOfIdentify removeAllObjects];
    [self _treeDidUpdated];
}

- (void)update:(id<CLHierarchyNode>)origin newNode:(id<CLHierarchyNode>)newNode {
    CLHierarchyLogInfo(@"node update: %@", newNode);
    if (!newNode || ![self _hasExisted:newNode]) return;
    
    [self _treeWillUpdate];
    [origin.supernode delete:origin]; // 更新只移除node关系
    [newNode.supernode update:origin newNode:newNode];
    [self _treeDidUpdated];
}

@end
