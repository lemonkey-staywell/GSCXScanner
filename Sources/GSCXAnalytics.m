//
// Copyright 2019 Google LLC.
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

#import "GSCXAnalytics.h"

/**
 Storage for GSCXAnalytics.enabled property.
 */
static BOOL gEnabled = YES;

/**
 Storage for GSCXAnalytics.handler property.
 */
static GSCXAnalyticsHandlerBlock gHandler;

/**
 The Analytics tracking ID that receives GSCXiLib usage data.
 */
static NSString *const kGSCXAnalyticsTrackingID = @"UA-113761703-1";

#pragma mark - Implementation

@implementation GSCXAnalytics

+ (void)load {
  // Initialize default handler to a no-op.
  gHandler = ^(GSCXAnalyticsEvent event, NSInteger count) {
    // Pass.
  };
}

+ (void)setHandler:(GSCXAnalyticsHandlerBlock)handler {
  NSParameterAssert(handler);
  gHandler = handler;
}

+ (GSCXAnalyticsHandlerBlock)handler {
  return gHandler;
}

+ (void)setEnabled:(BOOL)enabled {
  gEnabled = enabled;
}

+ (BOOL)enabled {
  return gEnabled;
}

+ (void)invokeAnalyticsEvent:(GSCXAnalyticsEvent)event count:(NSInteger)count {
  if (self.enabled) {
    self.handler(event, count);
  }
}

@end
