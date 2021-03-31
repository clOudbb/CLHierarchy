//
//  CLViewHierarchyManager.h
//  bilianime
//
//  Created by 张征鸿 on 2021/3/3.
//  Copyright © 2021 clOudbb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLHierarchyCore.h"

NS_ASSUME_NONNULL_BEGIN

@interface CLViewHierarchyManager : NSObject

@property (nonatomic, strong, readonly) CLHierarchyPluginManager *pluginManager;

/**
 * 是否需要控制台层级树日志. 开启会在控制台显示类似如下日志
 * 日志格式可以通过插件自定义. 详见CLHierarchyFormatter
 *├── com.hierarchy.root.node
 *  ├── container2
 *  ├── container1
 *     ├── view1
 *     ├── view2
 *     ├── view3
 */
@property (nonatomic, assign, getter=requireConsoleLog) BOOL requireConsoleLog;

/**
 * 必须指定rootView
 * @param rootView 根视图
 */
- (instancetype)initWithRootView:(UIView *)rootView NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

/**
 * 新增节点
 * 通过make来进行Node构建. 详细参数见CLViewHierarchyNodeMaker
 * View必须赋值
 */
- (void)add:(void(NS_NOESCAPE ^)(CLViewHierarchyNodeMaker *make))block;

/**
 * 更新节点
 * 可以进行已注册节点的属性更新，包括父视图切换
 * 更新的节点必须已注册，否则无效
 */
- (void)update:(void(NS_NOESCAPE ^)(CLViewHierarchyNodeMaker *make))block;

/**
 * 根据id移除节点
 * 会同时移除节点与视图关系
 * @param identify 指定id
 */
- (void)removeWithIdentify:(CLHierarchyNodeIdentify)identify;

/**
 * 根据指定视图移除节点
 * 会同时移除节点与视图关系
 * @param view 指定视图
 */
- (void)removeWithView:(UIView *)view;

/**
 * 移除当前管理者下所有节点及视图关系
 */
- (void)clear;

/**
 * 是否包含指定视图
 * @param view 指定视图
 */
- (BOOL)containsView:(UIView *)view;

/**
 * 获取指定id的视图
 * @param identify 指定id
 */
- (UIView *)retrieveViewWithIdenetify:(CLHierarchyNodeIdentify)identify;

@end

@interface CLViewHierarchyManager (Extension)

- (CLViewHierarchyNodeMaker *)make;

- (void)addWithMaker:(CLViewHierarchyNodeMaker *)maker;
- (void)updateWithMaker:(CLViewHierarchyNodeMaker *)maker;

@end

NS_ASSUME_NONNULL_END
