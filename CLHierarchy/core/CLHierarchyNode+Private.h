//
//  CLHierarchyNode+Private.h
//  bilianime
//
//  Created by 张征鸿 on 2021/3/3.
//  Copyright © 2021 clOudbb. All rights reserved.
//

#ifndef CLHierarchyNode_Private_h
#define CLHierarchyNode_Private_h

#import "CLHierarchyNode.h"

@interface CLHierarchyNode ()

- (void)_insertNode:(id<CLHierarchyNode>)node atIndex:(NSUInteger)index;
- (void)_setIdentify:(NSString *)identify;
- (void)_updateNodeInfoWithNewNode:(id<CLHierarchyNode>)newNode;

@end

#endif /* CLHierarchyNode_Private_h */
