//
//  CLHierarchyPluginManager.h
//  bilianime
//
//  Created by 张征鸿 on 2021/3/3.
//  Copyright © 2021 clOudbb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLHierarchyLogger.h"
#import "CLHierarchyFormatter.h"

NS_ASSUME_NONNULL_BEGIN

@class CLHierarchyPluginManager;
@protocol CLHierarchyPluginManagerDelegate <NSObject>
@optional

- (void)hierarchyPluginManager:(CLHierarchyPluginManager *)hierarchyPluginManager willInstallPlugin:(id<CLHierarchyPlugin>)plugin;
- (void)hierarchyPluginManager:(CLHierarchyPluginManager *)hierarchyPluginManager didInstalledPlugin:(id<CLHierarchyPlugin>)plugin;

- (void)hierarchyPluginManager:(CLHierarchyPluginManager *)hierarchyPluginManager willUninstallPlugin:(id<CLHierarchyPlugin>)plugin;
- (void)hierarchyPluginManager:(CLHierarchyPluginManager *)hierarchyPluginManager didUninstalledPlugin:(id<CLHierarchyPlugin>)plugin;

@end

@interface CLHierarchyPluginManager : NSObject

@property (nonatomic, weak, nullable) id<CLHierarchyPluginManagerDelegate> delegate;

@property (nonatomic, strong, readonly) id<CLHierarchyLogger> logger;
@property (nonatomic, strong, readonly) id<CLHierarchyFormatter> formatter;
@property (nonatomic, copy, readonly) NSArray<id<CLHierarchyPlugin>> *plugins;

- (void)install:(id<CLHierarchyPlugin>)plugin;

- (void)batch:(NSArray<id<CLHierarchyPlugin>> *)plugins;

- (void)uninstall:(id<CLHierarchyPlugin>)plugin;

@end

NS_ASSUME_NONNULL_END
