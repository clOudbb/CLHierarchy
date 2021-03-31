//
//  ViewHierarchyFormatter.m
//  BattleTest
//
//  Created by 张征鸿 on 2021/3/3.
//  Copyright © 2021 clOudbb. All rights reserved.
//

#import "ViewHierarchyFormatter.h"

@implementation ViewHierarchyFormatter

- (NSString *)formatWithNode:(id<CLHierarchyNode>)node {
    return [[NSString alloc] initWithFormat:@"%@ %@\n", [self prefixFormatWihtNode:node], node.identity];
}

- (NSString *)prefixFormatWihtNode:(id<CLHierarchyNode>)node {
    NSMutableString *format = @"".mutableCopy;
    NSUInteger depth = node.depth;
    while (depth--) {
        [format appendString:@"   "];
    }
    [format appendString:@"├"];
    return format.copy;
}

@end
