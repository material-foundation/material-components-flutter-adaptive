#import "AdaptiveBreakpointsPlugin.h"
#if __has_include(<adaptive_breakpoints/adaptive_breakpoints-Swift.h>)
#import <adaptive_breakpoints/adaptive_breakpoints-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "adaptive_breakpoints-Swift.h"
#endif

@implementation AdaptiveBreakpointsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAdaptiveBreakpointsPlugin registerWithRegistrar:registrar];
}
@end
