//
//  CLViewHierarchyManager.m
//  bilianime
//
//  Created by 张征鸿 on 2021/3/3.
//  Copyright © 2021 clOudbb. All rights reserved.
//

#import "CLViewHierarchyManager.h"
#import "CLViewHierarchyTree.h"

@implementation CLViewHierarchyManager {
    CLHierarchyService *_service;
    CLViewHierarchyTree<CLViewNode *> *_coordinator;
}

- (instancetype)initWithRootView:(UIView *)rootView {
    self = [super init];
    if (self) {
        NSAssert(rootView, @"Root view must be specified");
        _pluginManager = [[CLHierarchyPluginManager alloc] init];
        _service = [[CLHierarchyService alloc] initWithPluginManager:_pluginManager];
        _coordinator = [[CLViewHierarchyTree alloc] initWithService:_service rootView:rootView];
    }
    return self;
}

#pragma mark - public

- (void)update:(void(NS_NOESCAPE ^)(CLViewHierarchyNodeMaker *make))block {
    if (!block) return;
    
    CLViewHierarchyNodeMaker *maker = [[CLViewHierarchyNodeMaker alloc] initWithService:_service block:block];
    UIView *nodeView = maker.hierarchyAttributes[NSStringFromSelector(@selector(view))];
    UIView *nodeSuperview = maker.hierarchyAttributes[NSStringFromSelector(@selector(superview))];
    
    id<CLHierarchyNode> originNode = [_coordinator retrieveWithView:nodeView];
    if (!originNode) return;
    
    // 已经注册过
    id<CLHierarchyNode> supernode = [_coordinator retrieveWithView:nodeSuperview];
    if (!supernode) supernode = originNode.supernode;
    
    if (!supernode) {
        NSAssert(supernode, @"super view must have been registerd in tree");
        return;
    }
    
    id<CLHierarchyNode> newNode = [maker makeNodeWithSupernode:supernode];
    [_coordinator update:originNode newNode:newNode];
    
    [self _consolelogIfNeeded];
}

- (void)add:(void(NS_NOESCAPE ^)(CLViewHierarchyNodeMaker *make))block {
    if (!block) return;
    
    CLViewHierarchyNodeMaker *maker = [[CLViewHierarchyNodeMaker alloc] initWithService:_service block:block];
    UIView *nodeView = maker.hierarchyAttributes[NSStringFromSelector(@selector(view))];
    UIView *nodeSuperview = maker.hierarchyAttributes[NSStringFromSelector(@selector(superview))];

    // 如果已经存在该视图产生节点，重新创建关系
    id<CLHierarchyNode> origin = [_coordinator retrieveWithView:nodeView];
    if (origin) [_coordinator delete:origin];
    
    id<CLHierarchyNode> supernode = [_coordinator retrieveWithView:nodeSuperview ?: nodeView.superview];
    if (!supernode) {
        NSAssert(supernode, @"super view must have been registerd in tree");
        return;
    }
    
    id<CLHierarchyNode> node = [maker makeNodeWithSupernode:supernode];
    [_coordinator add:node];
    
    [self _consolelogIfNeeded];
}

- (void)deleteWithIdentify:(CLHierarchyNodeIdentify)identify {
    if (!identify.length) return;
    
    id<CLHierarchyNode> node = [_coordinator retrieveWithIdentify:identify];
    [_coordinator delete:node];
}

- (void)deleteWithView:(UIView *)view {
    if (!view) return;
    
    id<CLHierarchyNode> node = [_coordinator retrieveWithView:view];
    [_coordinator delete:node];
}

- (void)removeWithIdentify:(CLHierarchyNodeIdentify)identify {
    if (!identify.length) return;
    
    id<CLHierarchyNode> node = [_coordinator retrieveWithIdentify:identify];
    [_coordinator remove:node];
    
    [self _consolelogIfNeeded];
}

- (void)removeWithView:(UIView *)view {
    if (!view) return;
    
    id<CLHierarchyNode> node = [_coordinator retrieveWithView:view];
    [_coordinator remove:node];
    
    [self _consolelogIfNeeded];
}

- (void)clear {
    [_coordinator clear];
}

- (UIView *)retrieveViewWithIdenetify:(CLHierarchyNodeIdentify)identify {
    if (!identify.length) return nil;
    
    CLViewNode *node = [_coordinator retrieveWithIdentify:identify];
    if (![node isKindOfClass:CLViewNode.class]) return nil;
    
    return node.view;
}

- (BOOL)containsView:(UIView *)view {
    return [_coordinator retrieveWithView:view];
}

#pragma mark - private

- (void)_consolelogIfNeeded {
    if (_requireConsoleLog) [_coordinator consoleLog];
}

@end

@implementation CLViewHierarchyManager (Extension)

- (CLViewHierarchyNodeMaker *)make {
    CLViewHierarchyNodeMaker *maker = [[CLViewHierarchyNodeMaker alloc] initWithService:_service block:nil];
    return maker;
}

- (void)addWithMaker:(CLViewHierarchyNodeMaker *)maker {
    if (!maker) return;
    
    UIView *nodeView = maker.hierarchyAttributes[NSStringFromSelector(@selector(view))];
    UIView *nodeSuperview = maker.hierarchyAttributes[NSStringFromSelector(@selector(superview))];
    // 如果已经存在该视图产生节点，重新创建关系
    id<CLHierarchyNode> origin = [_coordinator retrieveWithView:nodeView];
    if (origin) [_coordinator delete:origin];
    
    id<CLHierarchyNode> supernode = [_coordinator retrieveWithView:nodeSuperview ?: nodeView.superview];
    if (!supernode) {
        NSAssert(supernode, @"super view must have been registerd in tree");
        return;
    }
    
    id<CLHierarchyNode> node = [maker makeNodeWithSupernode:supernode];
    [_coordinator add:node];
    
    [self _consolelogIfNeeded];
}

- (void)updateWithMaker:(CLViewHierarchyNodeMaker *)maker {
    if (!maker) return;
    
    UIView *nodeView = maker.hierarchyAttributes[NSStringFromSelector(@selector(view))];
    UIView *nodeSuperview = maker.hierarchyAttributes[NSStringFromSelector(@selector(superview))];
    
    id<CLHierarchyNode> originNode = [_coordinator retrieveWithView:nodeView];
    if (!originNode) return;
    
    // 已经注册过
    id<CLHierarchyNode> supernode = [_coordinator retrieveWithView:nodeSuperview];
    if (!supernode) supernode = originNode.supernode;
    
    if (!supernode) {
        NSAssert(supernode, @"super view must have been registerd in tree");
        return;
    }
    
    id<CLHierarchyNode> newNode = [maker makeNodeWithSupernode:supernode];
    [_coordinator update:originNode newNode:newNode];
    
    [self _consolelogIfNeeded];
}

@end
