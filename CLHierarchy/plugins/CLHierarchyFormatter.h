//
//  CLHierarchyFormatter.h
//  bilianime
//
//  Created by 张征鸿 on 2021/3/3.
//  Copyright © 2021 clOudbb. All rights reserved.
//

#ifndef CLHierarchyFormatter_h
#define CLHierarchyFormatter_h

#import "CLHierarchyCoreProtocol.h"

@protocol CLHierarchyFormatter <CLHierarchyPlugin>

/**
 * 控制台输出格式
 * @param node 当前节点
 */
- (NSString *)formatWithNode:(id<CLHierarchyNode>)node;

@end

#endif /* CLHierarchyFormatter_h */
