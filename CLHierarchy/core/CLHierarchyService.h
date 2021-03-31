//
//  CLHierarchyService.h
//  bilianime
//
//  Created by 张征鸿 on 2021/3/3.
//  Copyright © 2021 clOudbb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLHierarchyBase.h"
#import "CLHierarchyPluginManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface CLHierarchyService : NSObject

@property (nonatomic, weak, readonly) CLHierarchyPluginManager *pluginManager;

- (instancetype)initWithPluginManager:(CLHierarchyPluginManager *)pluginManager;

@end

NS_ASSUME_NONNULL_END
