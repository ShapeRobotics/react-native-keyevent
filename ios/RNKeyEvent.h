#import <React/RCTEventEmitter.h>

#ifdef RCT_NEW_ARCH_ENABLED
#import <RNKeyEventSpec/RNKeyEventSpec.h>

NS_ASSUME_NONNULL_BEGIN

@interface RNKeyEvent : RCTEventEmitter <NativeKeyEventSpec>

NS_ASSUME_NONNULL_END

#else
#import <React/RCTBridgeModule.h>

@interface RNKeyEvent : RCTEventEmitter <RCTBridgeModule>
#endif

@property (nonatomic, assign) BOOL hasListener;

@end