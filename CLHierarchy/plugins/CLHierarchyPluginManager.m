//
//  CLHierarchyPluginManager.m
//  bilianime
//
//  Created by 张征鸿 on 2021/3/3.
//  Copyright © 2021 clOudbb. All rights reserved.
//

#import "CLHierarchyPlugin.h"
#import "CLHierarchyPluginManager.h"

@implementation CLHierarchyPluginManager

- (instancetype)init {
    self = [super init];
    if (self) {
        _plugins = @[];
    }
    return self;
}

- (void)batch:(NSArray<id<CLHierarchyPlugin>> *)plugins {
    if (!plugins.count) return;
    
    [plugins enumerateObjectsUsingBlock:^(id<CLHierarchyPlugin>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self install:obj];
    }];
}

- (void)install:(id<CLHierarchyPlugin>)plugin {
    if (!plugin) return;
    
    [self _install:plugin];
}

- (void)uninstall:(id<CLHierarchyPlugin>)plugin {
    if (!plugin) return;
    
    [self _uninstall:plugin];
}

#pragma mark - private

- (void)_install:(id<CLHierarchyPlugin>)plugin {
    [self _willInstallPlugin:plugin];
    if ([plugin conformsToProtocol:@protocol(CLHierarchyFormatter)]) _formatter = (id<CLHierarchyFormatter>)plugin;
    if ([plugin conformsToProtocol:@protocol(CLHierarchyLogger)]) _logger = (id<CLHierarchyLogger>)plugin;
    
    _plugins = [_plugins arrayByAddingObjectsFromArray:@[plugin]];
    [self _didInstalledPlugin:plugin];
}

- (void)_uninstall:(id<CLHierarchyPlugin>)plugin {
    [self _willUninstallPlugin:plugin];
    NSMutableArray *plugins = _plugins.mutableCopy;
    [plugins removeObject:plugin];
    _plugins = plugins;
    [self _didUninstalledPlugin:plugin];
}

- (void)_willInstallPlugin:(id<CLHierarchyPlugin>)plugin {
    if ([self.delegate respondsToSelector:@selector(hierarchyPluginManager:willInstallPlugin:)]) {
        [self.delegate hierarchyPluginManager:self willInstallPlugin:plugin];
    }
    if (![plugin isKindOfClass:CLHierarchyPlugin.class]) return;
    
    [(CLHierarchyPlugin *)plugin willInstallToManager];
}

- (void)_didInstalledPlugin:(id<CLHierarchyPlugin>)plugin {
    if ([self.delegate respondsToSelector:@selector(hierarchyPluginManager:didInstalledPlugin:)]) {
        [self.delegate hierarchyPluginManager:self didInstalledPlugin:plugin];
    }
    if (![plugin isKindOfClass:CLHierarchyPlugin.class]) return;
    
    [(CLHierarchyPlugin *)plugin didInstalledToManager];
}

- (void)_willUninstallPlugin:(id<CLHierarchyPlugin>)plugin {
    if ([self.delegate respondsToSelector:@selector(hierarchyPluginManager:willUninstallPlugin:)]) {
        [self.delegate hierarchyPluginManager:self willUninstallPlugin:plugin];
    }
    if (![plugin isKindOfClass:CLHierarchyPlugin.class]) return;
    
    [(CLHierarchyPlugin *)plugin willUninstallToManager];
}

- (void)_didUninstalledPlugin:(id<CLHierarchyPlugin>)plugin {
    if ([self.delegate respondsToSelector:@selector(hierarchyPluginManager:didUninstalledPlugin:)]) {
        [self.delegate hierarchyPluginManager:self didUninstalledPlugin:plugin];
    }
    if (![plugin isKindOfClass:CLHierarchyPlugin.class]) return;
    
    [(CLHierarchyPlugin *)plugin didUninstallToManager];
}

@end
