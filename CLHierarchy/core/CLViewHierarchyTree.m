//
//  CLViewHierarchyTree.m
//  bilianime
//
//  Created by 张征鸿 on 2021/3/3.
//  Copyright © 2021 clOudbb. All rights reserved.
//

#import "CLViewHierarchyTree.h"
#import "CLHierarchyTree+Private.h"

@implementation CLViewHierarchyTree {
    NSMapTable<UIView *, id<CLHierarchyNode>> *_indexOfView;
}

- (instancetype)initWithService:(CLHierarchyService *)service rootView:(UIView *)rootView {
    self = [super initWithService:service];
    if (self) {
        [self _setRootNode:[[CLViewNode alloc] initWithService:service identify:CLHierarchyRootNodeIdentify level:0 supernode:nil view:rootView]];
        _indexOfView = [NSMapTable weakToWeakObjectsMapTable];
        [_indexOfView setObject:self.rootNode forKey:rootView];
    }
    return self;
}

- (id<CLHierarchyNode>)retrieveWithView:(UIView *)view {
    if (!view) return nil;
    
    return [_indexOfView objectForKey:view];
}

- (void)add:(CLViewNode *)node {
    [super add:node];
    if (!node || !node.view) return;
    
    [_indexOfView setObject:node forKey:node.view];
}

- (void)delete:(CLViewNode *)node {
    [super delete:node];
    if (!node || !node.view) return;
    
    [_indexOfView removeObjectForKey:node.view];
}

- (void)clear {
    [super clear];
    [_indexOfView removeAllObjects];
}

- (BOOL)_hasExisted:(CLViewNode *)node {
    return [_indexOfView objectForKey:node.view];
}

@end
