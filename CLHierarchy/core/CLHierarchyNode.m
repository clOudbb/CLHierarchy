//
//  CLHierarchyNode.m
//  bilianime
//
//  Created by 张征鸿 on 2021/3/3.
//  Copyright © 2021 clOudbb. All rights reserved.
//

#import "CLHierarchyNode.h"
#import "CLHierarchyNode+Private.h"

@implementation CLHierarchyNode {
    CLHierarchyService *_service;
    NSMutableArray<id<CLHierarchyNode>> *_subnodes; // mutable order ?
}

- (instancetype)initWithService:(CLHierarchyService *)service identify:(NSString *)identify level:(CLHierarchyLevel)level supernode:(id<CLHierarchyNode>)supernode {
    self = [super init];
    if (self) {
        _service = service;
        _subnodes = @[].mutableCopy;
        _supernode = supernode;
        _level = level;
        [self _setIdentify:identify.length ? identify: [NSString stringWithFormat:@"unidentify_node_level_%.f", _level]];
        if (!supernode) _rootNode = YES;
    }
    return self;
}

- (BOOL)isEqual:(CLHierarchyNode *)object {
    if (object == self) return YES;
    
    return _level == object.level && [_identity isEqual:object.identity];
}

#pragma mark - protocol CLHierarchyNode

- (void)add:(id<CLHierarchyNode>)node {
    id<CLHierarchyNode> supernode = node.supernode;
    supernode && supernode != self && !supernode.isRootNode ? [supernode add:node] : [self _add:node];
}

- (void)delete:(id<CLHierarchyNode>)node {
    id<CLHierarchyNode> supernode = node.supernode;
    supernode && supernode != self && !supernode.isRootNode ? [supernode delete:node]: [self _delete:node];
}

- (void)remove:(id<CLHierarchyNode>)node {
    [self willRemoveSubnode:node];
    [self delete:node];
    [self didRemoveSubnode:node];
}

- (void)clear {
    [_subnodes removeAllObjects];
}

- (void)clearAllSubnodes {
    [_subnodes removeAllObjects];
}

- (void)update:(id<CLHierarchyNode>)origin newNode:(id<CLHierarchyNode>)newNode {
    [(CLHierarchyNode *)origin _updateNodeInfoWithNewNode:newNode];
    [self _add:origin];
}

#pragma mark - private

- (void)_updateNodeInfoWithNewNode:(id<CLHierarchyNode>)newNode {
    if (newNode.level) _level = newNode.level;
    if (newNode.supernode) _supernode = newNode.supernode;
}

- (void)_setIdentify:(NSString *)identify {
    _identity = identify;
}

- (void)_setSupernode:(id<CLHierarchyNode>)supernode {
    _supernode = supernode;
}

- (void)_setDepth:(NSUInteger)depth {
    _depth = depth;
}

- (void)_node:(id<CLHierarchyNode>)node processSuperNode:(id<CLHierarchyNode>)supernode {
    if (!node || !supernode) return;
    
    [(CLHierarchyNode *)node _setSupernode:supernode];
    [(CLHierarchyNode *)node _setDepth:supernode.depth + 1];
}

- (void)_delete:(id<CLHierarchyNode>)node {
    [_subnodes removeObject:node];
    [self _node:node processSuperNode:nil];
}

- (void)_add:(id<CLHierarchyNode>)node {
    NSMutableArray *nodes = _subnodes;
    if (!node || !nodes) return;
    
    NSUInteger index = [nodes indexOfObjectPassingTest:^BOOL(id<CLHierarchyNode>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        return obj.level >= node.level;
    }];
    if (index == NSNotFound) {
        [self _node:node processSuperNode:self];
        
        [self willAddSubnode:node];
        [_subnodes addObject:node];
        [self didAddSubnode:node];
    } else {
        id<CLHierarchyNode> target = nodes[index];
        if (target.level == node.level) {
            NSAssert(target.level != node.level, @"node level has been expected.");
        } else {
            [self _node:node processSuperNode:self];
            
            NSUInteger atIndex = index ?: 0;
            [self willInsertNode:node belowNode:target];
            [self _insertNode:node atIndex:atIndex];
            [self didInsertedNode:node belowNode:target];
        }
    }
}

- (void)_insertNode:(id<CLHierarchyNode>)node atIndex:(NSUInteger)index {
    [_subnodes insertObject:node atIndex:index];
}

@end

@implementation CLHierarchyNode (NodeHierarchy)

- (void)willInsertNode:(id<CLHierarchyNode>)node atIndex:(NSUInteger)index {
    
}

- (void)didInsertedNode:(id<CLHierarchyNode>)node atIndex:(NSUInteger)index {
    
}

- (void)willInsertNode:(id<CLHierarchyNode>)node aboveNode:(id<CLHierarchyNode>)siblingNode {
    
}

- (void)didInsertedNode:(id<CLHierarchyNode>)node aboveNode:(id<CLHierarchyNode>)siblingNode {
    
}

- (void)willInsertNode:(id<CLHierarchyNode>)node belowNode:(id<CLHierarchyNode>)siblingNode {
    
}

- (void)didInsertedNode:(id<CLHierarchyNode>)node belowNode:(id<CLHierarchyNode>)siblingNode {
    
}

- (void)willAddSubnode:(id<CLHierarchyNode>)node {
    
}

- (void)didAddSubnode:(id<CLHierarchyNode>)node {
    
}

- (void)willRemoveSubnode:(id<CLHierarchyNode>)node {
    
}

- (void)didRemoveSubnode:(id<CLHierarchyNode>)node {
    
}

- (void)orderWithRule:(id)rule {
    // needs test
    [_subnodes sortUsingComparator:^NSComparisonResult(id<CLHierarchyNode>  _Nonnull obj1, id<CLHierarchyNode>  _Nonnull obj2) {
        if (obj1.level > obj2.level) return NSOrderedAscending;
        else return NSOrderedDescending;
    }];
    
    if (!_subnodes.count) return;
    
    [_subnodes enumerateObjectsUsingBlock:^(CLHierarchyNode *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj orderWithRule:rule];
    }];
}

@end

@implementation CLHierarchyNode (NodeFormatter)

- (NSString *)format {
    NSMutableString *result = @"".mutableCopy;
    id<CLHierarchyFormatter> formatter = _service.pluginManager.formatter;
    NSString *format = [formatter respondsToSelector:@selector(formatWithNode:)] ? [formatter formatWithNode:self] : [self defaultFormat];
    [result appendString:format];
    if (!_subnodes.count) return result;
    
    [_subnodes enumerateObjectsUsingBlock:^(CLHierarchyNode *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [result appendString:[obj format]];
    }];
    return result.copy;
}

- (NSString *)defaultFormat {
    return [[NSString alloc] initWithFormat:@"%@ %@\n", [self prefixFormat], _identity];
}

- (NSString *)prefixFormat {
    NSMutableString *format = @"".mutableCopy;
    NSUInteger depth = _depth;
    while (depth--) {
        [format appendString:@"   "];
    }
    [format appendString:@"├ ---"];
    return format.copy;
}

@end
