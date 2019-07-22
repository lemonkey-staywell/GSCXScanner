//
// Copyright 2018 Google Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "GSCXAutoInstaller.h"

#import "GSCXInstaller.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - GSCXAutoInstallerAppListener Interface

/**
 *  Listens to app notifications and installs scanner when app is launched.
 */
@interface GSCXAutoInstallerAppListener : NSObject
/**
 *  Begin listening for app notifications.
 */
+ (void)startListening;
@end

#pragma mark - GSCXAutoInstallerAppListener Implementation

@implementation GSCXAutoInstallerAppListener {
    UIWindow *_overlayWindow;
    BOOL _performScanButtonIsHidden;
}

+ (instancetype)defaultListener {
    static dispatch_once_t onceToken;
    static GSCXAutoInstallerAppListener *defaultInstance;
    dispatch_once(&onceToken, ^{
        defaultInstance = [[GSCXAutoInstallerAppListener alloc] init];
    });
    return defaultInstance;
}

+ (void)startListening {
    [[NSNotificationCenter defaultCenter] addObserver:[GSCXAutoInstallerAppListener defaultListener]
                                             selector:@selector(applicationDidFinishLaunching:)
                                                 name:UIApplicationDidFinishLaunchingNotification
                                               object:nil];
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    NSAssert(_overlayWindow == nil, @"iOS Scanner was already installed.");
    // TODO: Also check if scanner was installed using other APIs in GSCXInstaller.
    _overlayWindow = [GSCXInstaller installScanner];
}

@end

#pragma mark - GSCXAutoInstaller Implementation

@implementation GSCXAutoInstaller

+ (void)load {
    // TPHA-419:20170722:AB
    // In case we want to skip the scanner for local test builds via
    
//    BOOL skip_load = false;
//
//    NSProcessInfo *processInfo = [NSProcessInfo processInfo];
//    if(processInfo) {
//        NSArray *processInfoArguments = processInfo.arguments;
//        if(processInfoArguments.count > 0)
//        {
//            if([processInfoArguments containsObject:@"SKIP_GSCXSCANNER"]) {
//                skip_load = true;
//            }
//        }
//    }
//
//    if(!skip_load) {
//        NSLog(@"Loading GSCXScanner (GSCXAutoInstaller.m +load)");
//
//        [GSCXAutoInstallerAppListener startListening];
//    } else {
//        NSLog(@"Skipping loading of GSCXScanner (GSCXAutoInstaller.m +load)");
//    }
}

@end

NS_ASSUME_NONNULL_END
