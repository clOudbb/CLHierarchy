//
//  CLHierarchyPlugin.h
//  bilianime
//
//  Created by 张征鸿 on 2021/3/3.
//  Copyright © 2021 clOudbb. All rights reserved.
//

#import "CLHierarchyCoreProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface CLHierarchyPlugin<__covariant PluginType: id<CLHierarchyPlugin>> : NSObject

@end

@interface CLHierarchyPlugin (Install)

- (void)willInstallToManager;
- (void)didInstalledToManager;

- (void)willUninstallToManager;
- (void)didUninstallToManager;

@end

NS_ASSUME_NONNULL_END
