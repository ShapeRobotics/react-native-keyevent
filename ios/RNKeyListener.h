#import <UIKit/UIKit.h>

#ifdef RCT_NEW_ARCH_ENABLED
#import <RNKeyListenerSpec/RNKeyListenerSpec.h>

NS_ASSUME_NONNULL_BEGIN

@interface RNKeyListener : UIViewController <NativeKeyListenerSpec>
NS_ASSUME_NONNULL_END

#else
#import <UIKit/UIKit.h>

@interface RNKeyListener : UIViewController

#endif


@end
