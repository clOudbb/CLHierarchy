//
//  CLHierarchyLogger.h
//  bilianime
//
//  Created by 张征鸿 on 2021/3/3.
//  Copyright © 2021 clOudbb. All rights reserved.
//

#ifndef CLHierarchyLogger_h
#define CLHierarchyLogger_h

#import "CLHierarchyCoreProtocol.h"

typedef NS_OPTIONS(NSUInteger, CLHierarchyLogFlag){
    CLHierarchyLogFlagError      = (1 << 0),
    CLHierarchyLogFlagWarning    = (1 << 1),
    CLHierarchyLogFlagInfo       = (1 << 2),
    CLHierarchyLogFlagDebug      = (1 << 3),
    CLHierarchyLogFlagVerbose    = (1 << 4)
};

@protocol CLHierarchyLogger <CLHierarchyPlugin>
@required

- (void)logWithTag:(NSString * _Nullable)tag flag:(CLHierarchyLogFlag)flag file:(const char * _Nullable)file function:(const char * _Nullable)function line:(NSUInteger)line format:(NSString *_Nullable)format, ... NS_FORMAT_FUNCTION(6, 7);

@end


#endif /* CLHierarchyLogger_h */
