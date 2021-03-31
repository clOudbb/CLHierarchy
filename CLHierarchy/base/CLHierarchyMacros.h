//
//  CLHierarchyMacros.h
//  bilianime
//
//  Created by 张征鸿 on 2021/3/3.
//  Copyright © 2021 clOudbb. All rights reserved.
//

#ifndef CLHierarchyMacros_h
#define CLHierarchyMacros_h

#define CLHierarchyLogTag @"[CLHierarchyLog] - "

#define CLHierarchyLogError(FMTS, ...) CLHierarchyLog(CLHierarchyDefaultLogger, CLHierarchyLogFlagError, FMTS, ##__VA_ARGS__)
#define CLHierarchyLogWarning(FMTS, ...) CLHierarchyLog(CLHierarchyDefaultLogger, CLHierarchyLogFlagWarning, FMTS, ##__VA_ARGS__)
#define CLHierarchyLogInfo(FMTS, ...) CLHierarchyLog(CLHierarchyDefaultLogger, CLHierarchyLogFlagInfo, FMTS, ##__VA_ARGS__)
#define CLHierarchyLogDebug(FMTS, ...) CLHierarchyLog(CLHierarchyDefaultLogger, CLHierarchyLogFlagDebug, FMTS, ##__VA_ARGS__)

#define CLHierarchyDefaultLogger _service.pluginManager.logger

#define CLHierarchyLog(LOGGER, LOG_FLAG, FMTS, ...) \
if ([LOGGER respondsToSelector:@selector(logWithTag:flag:file:function:line:format:)]) { \
    [LOGGER logWithTag:CLHierarchyLogTag flag:LOG_FLAG file:__FILE__ function:__PRETTY_FUNCTION__ line:__LINE__ format:FMTS, ##__VA_ARGS__];\
}

#endif /* CLHierarchyMacros_h */
