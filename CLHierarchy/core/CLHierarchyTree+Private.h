//
//  CLHierarchyTree+Private.h
//  bilianime
//
//  Created by 张征鸿 on 2021/3/3.
//  Copyright © 2021 clOudbb. All rights reserved.
//

#ifndef CLHierarchyTree_Private_h
#define CLHierarchyTree_Private_h

#import "CLHierarchyTree.h"

@interface CLHierarchyTree ()

- (void)_setRootNode:(CLHierarchyNode *)rootNode;
- (BOOL)_hasExisted:(id<CLHierarchyNode>)node;

@end

#endif /* CLHierarchyTree_Private_h */
