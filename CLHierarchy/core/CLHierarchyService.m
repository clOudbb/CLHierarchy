//
//  CLHierarchyService.m
//  bilianime
//
//  Created by 张征鸿 on 2021/3/3.
//  Copyright © 2021 clOudbb. All rights reserved.
//

#import "CLHierarchyService.h"

@implementation CLHierarchyService

- (instancetype)initWithPluginManager:(CLHierarchyPluginManager *)pluginManager {
    self = [super init];
    if (self) {
        _pluginManager = pluginManager;
    }
    return self;
}

@end
