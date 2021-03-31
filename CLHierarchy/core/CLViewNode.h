//
//  CLViewNode.h
//  bilianime
//
//  Created by 张征鸿 on 2021/3/3.
//  Copyright © 2021 clOudbb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLHierarchyNode.h"

NS_ASSUME_NONNULL_BEGIN

@interface CLViewNode : CLHierarchyNode

@property (nonatomic, weak, readonly) UIView *view;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithService:(CLHierarchyService *)service
                       identify:(NSString *)identify
                          level:(CLHierarchyLevel)level
                      supernode:(nullable id<CLHierarchyNode>)supernode
                           view:(UIView *)view NS_DESIGNATED_INITIALIZER;

@end

@interface CLViewHierarchyNodeMaker : NSObject

@property (nonatomic, copy, readonly) NSDictionary<NSString *, id> *hierarchyAttributes;

- (instancetype)initWithService:(CLHierarchyService *)service block:(void(^__nullable)(CLViewHierarchyNodeMaker *))block;
- (id<CLHierarchyNode>)makeNodeWithSupernode:(id<CLHierarchyNode>)supernode;

#pragma mark - view

/**
 * 该节点的视图。
 * 必须传入
 */
- (CLViewHierarchyNodeMaker *(^)(UIView *))view;

#pragma mark - attribute

/**
 * 节点视图级别
 * 必须传入. level可为负数，但不能为0
 * 同一层级的节level必须保证唯一，不同一层级的level可以相同
 */
- (CLViewHierarchyNodeMaker *(^)(CLHierarchyLevel))level;

/**
 * 该节点唯一标识。
 * 非必须传入。如不传入，默认为 类名+View地址+level
 */
- (CLViewHierarchyNodeMaker *(^)(CLHierarchyNodeIdentify))identify;

/**
 * 该节点视图的父视图。
 * 非必须参数。但如果不传入取值本节点视图的父视图，且原视图没有建立关系，则本节点添加不会成功
 */
- (CLViewHierarchyNodeMaker *(^)(UIView *))superview;

@end

NS_ASSUME_NONNULL_END
