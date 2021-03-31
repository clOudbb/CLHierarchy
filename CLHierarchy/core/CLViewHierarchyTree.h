//
//  CLViewHierarchyTree.h
//  bilianime
//
//  Created by 张征鸿 on 2021/3/3.
//  Copyright © 2021 clOudbb. All rights reserved.
//

#import "CLHierarchyTree.h"
#import "CLViewNode.h"
NS_ASSUME_NONNULL_BEGIN

@interface CLViewHierarchyTree<NodeType: CLViewNode *> : CLHierarchyTree

- (instancetype)initWithService:(CLHierarchyService *)service rootView:(UIView *)rootView;

- (NodeType)retrieveWithView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
