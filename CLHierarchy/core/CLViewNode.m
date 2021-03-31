//
//  CLViewNode.m
//  bilianime
//
//  Created by 张征鸿 on 2021/3/3.
//  Copyright © 2021 clOudbb. All rights reserved.
//

#import "CLViewNode.h"
#import "CLHierarchyNode+Private.h"

@implementation CLViewNode

- (instancetype)initWithService:(CLHierarchyService *)service identify:(NSString *)identify level:(CLHierarchyLevel)level supernode:(id<CLHierarchyNode>)supernode view:(UIView *)view  {
    self = [super initWithService:service identify:identify level:level supernode:supernode];
    if (self) {
        _view = view;
        [self _setIdentify:identify.length ? identify: [NSString stringWithFormat:@"%@_%p_level_%.f", NSStringFromClass(view.class), view, self.level]];
    }
    return self;
}

- (BOOL)isEqual:(CLViewNode *)object {
    if (object == self) return YES;
    
    return self.level == object.level && [self.identity isEqual:object.identity] && self.view == object.view;
}

#pragma mark - Override

- (void)clear {
    [super clear];
    [_view removeFromSuperview];
}

- (void)clearAllSubnodes {
    [super clearAllSubnodes];
    [self.subnodes enumerateObjectsUsingBlock:^(CLViewNode *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.view removeFromSuperview];
    }];
}

- (void)didAddSubnode:(CLViewNode *)node {
    UIView *superview = node.isRootNode ? node.view : ((CLViewNode *)node.supernode).view;
    [superview addSubview:node.view];
}

- (void)didRemoveSubnode:(CLViewNode *)node {
    [node.view removeFromSuperview];
}

- (void)didInsertedNode:(CLViewNode *)node atIndex:(NSUInteger)index {
    UIView *superview = node.isRootNode ? node.view : ((CLViewNode *)node.supernode).view;
    [superview insertSubview:((CLViewNode *)node).view atIndex:index];
}

- (void)didInsertedNode:(CLViewNode *)node belowNode:(CLViewNode *)siblingNode {
    UIView *superview = node.isRootNode ? node.view : ((CLViewNode *)node.supernode).view;
    UIView *siblingView = siblingNode.view;
    [superview insertSubview:node.view belowSubview:siblingView];
}

- (void)didInsertedNode:(CLViewNode *)node aboveNode:(CLViewNode *)siblingNode {
    UIView *superview = node.isRootNode ? node.view : ((CLViewNode *)node.supernode).view;
    UIView *siblingView = siblingNode.view;
    [superview insertSubview:node.view aboveSubview:siblingView];
}

- (void)_updateNodeInfoWithNewNode:(CLViewNode *)newNode {
    [super _updateNodeInfoWithNewNode:newNode];
    _view = newNode.view;
}

@end

@interface CLViewHierarchyNodeMaker ()

@end

@implementation CLViewHierarchyNodeMaker {
    CLHierarchyService *_service;
    NSMutableDictionary *_attributes;
}

- (instancetype)initWithService:(CLHierarchyService *)service block:(void(^__nullable)(CLViewHierarchyNodeMaker *))block {
    if (self = [super init]) {
        _service = service;
        _attributes = @{}.mutableCopy;

        if (block) block(self);
    }
    return self;
}

- (id<CLHierarchyNode>)makeNodeWithSupernode:(id<CLHierarchyNode>)supernode {
    UIView *view = _attributes[NSStringFromSelector(@selector(view))];
    NSString *identify = _attributes[NSStringFromSelector(@selector(identity))];
    CLHierarchyLevel level = [_attributes[NSStringFromSelector(@selector(level))] floatValue];
    NSAssert(view, @"Node view is necessary");
    return [[CLViewNode alloc] initWithService:_service identify:identify level:level supernode:supernode view:view];
}

- (NSDictionary<NSString *,id> *)hierarchyAttributes {
    return _attributes.copy;
}

- (CLViewHierarchyNodeMaker * _Nonnull (^)(UIView * _Nonnull))view {
    return ^id(UIView *view) {
        self->_attributes[NSStringFromSelector(_cmd)] = view;
        return self;
    };
}

- (CLViewHierarchyNodeMaker * _Nonnull (^)(UIView * _Nonnull))superview {
    return ^id(UIView *superview) {
        self->_attributes[NSStringFromSelector(_cmd)] = superview;
        return self;
    };
}

- (CLViewHierarchyNodeMaker * _Nonnull (^)(CLHierarchyNodeIdentify _Nonnull))identify {
    return ^id(CLHierarchyNodeIdentify identify) {
        self->_attributes[NSStringFromSelector(_cmd)] = identify;
        return self;
    };
}

- (CLViewHierarchyNodeMaker * _Nonnull (^)(CLHierarchyLevel))level {
    return ^id(CLHierarchyLevel level) {
        self->_attributes[NSStringFromSelector(_cmd)] = @(level);
        return self;
    };
}

@end
