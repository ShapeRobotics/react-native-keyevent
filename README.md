This repository is a fork of react-native-keyevent made by kevinejohn

https://github.com/kevinejohn/react-native-keyevent

# React Native KeyEvent

[![npm version](https://badge.fury.io/js/react-native-keyevent.svg)](http://badge.fury.io/js/react-native-keyevent)

Capture external keyboard keys or remote control button events

[Learn about Android KeyEvent here](https://developer.android.com/reference/android/view/KeyEvent.html).


### Installation

#### via npm

Run `npm install react-native-keyevent --save`

#### via yarn

Run `yarn add react-native-keyevent`

### Linking

#### Android:

`react-native link react-native-keyevent` (for React Native <= 0.59 only)

#### iOS:

 `pod install`  inside your `ios` folder.

> Note: You still must manually register module in MainActivity! (Instructions below under Configuration Android)


#### Linking Manually

**Android**

1. In `android/setting.gradle`

    ```
    ...
    include ':react-native-keyevent'
    project(':react-native-keyevent').projectDir = new File(rootProject.projectDir, '../node_modules/react-native-keyevent/android')
    ```

2. In `android/app/build.gradle`

    ```
    ...
    dependencies {
        ...
        compile project(':react-native-keyevent')
    }
    ```

3. Register module (in MainApplication.java)

    ```
    import com.github.kevinejohn.keyevent.KeyEventPackage;  // <--- import

    public class MainApplication extends Application implements ReactApplication {
      ......

      @Override
      protected List<ReactPackage> getPackages() {
          return Arrays.<ReactPackage>asList(
              new MainReactPackage(),
              new KeyEventPackage()      <------- Add this
          );
      }

      ......

    }
    ```

**iOS**

Follow the instrutions listed here: [Manually Linking iOS](https://facebook.github.io/react-native/docs/linking-libraries-ios#manual-linking).

### Configuration

#### Android

Implement onConfigurationChanged method in MainActivity.java

```
    import android.view.KeyEvent; // <--- import
    import com.github.kevinejohn.keyevent.KeyEventModule; // <--- import


    public class MainActivity extends ReactActivity {
      ......
      @Override  // <--- Add this method if you want to react to keyDown
      public boolean onKeyDown(int keyCode, KeyEvent event) {

        // A. Prevent multiple events on long button press
        //    In the default behavior multiple events are fired if a button
        //    is pressed for a while. You can prevent this behavior if you
        //    forward only the first event:
        //        if (event.getRepeatCount() == 0) {
        //            KeyEventModule.getInstance().onKeyDownEvent(keyCode, event);
        //        }
        //
        // B. If multiple Events shall be fired when the button is pressed
        //    for a while use this code:
        //        KeyEventModule.getInstance().onKeyDownEvent(keyCode, event);
        //
        // Using B.
        KeyEventModule.getInstance().onKeyDownEvent(keyCode, event);

        // There are 2 ways this can be done:
        //  1.  Override the default keyboard event behavior
        //    super.onKeyDown(keyCode, event);
        //    return true;

        //  2.  Keep default keyboard event behavior
        //    return super.onKeyDown(keyCode, event);

        // Using method #1 without blocking multiple
        super.onKeyDown(keyCode, event);
        return true;
      }

      @Override  // <--- Add this method if you want to react to keyUp
      public boolean onKeyUp(int keyCode, KeyEvent event) {
        KeyEventModule.getInstance().onKeyUpEvent(keyCode, event);

        // There are 2 ways this can be done:
        //  1.  Override the default keyboard event behavior
        //    super.onKeyUp(keyCode, event);
        //    return true;

        //  2.  Keep default keyboard event behavior
        //    return super.onKeyUp(keyCode, event);

        // Using method #1
        super.onKeyUp(keyCode, event);
        return true;
      }

      @Override
      public boolean onKeyMultiple(int keyCode, int repeatCount, KeyEvent event) {
          KeyEventModule.getInstance().onKeyMultipleEvent(keyCode, repeatCount, event);
          return super.onKeyMultiple(keyCode, repeatCount, event);
      }
      ......

    }
```

#### iOS

This will need to be added in your `AppDelegate.mm` file:

```objc
// react-native-keyevent
#import <React/RCTRootView.h>
#import <RNKeyListener.h> // import these two files at the top after linking

@implementation AppDelegate

//....

/*!
 * react-native-keyevent support
 */

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.moduleName = @"YOUR_PROJECT_NAME";
  // You can add your custom initial props in the dictionary below.
  // They will be passed down to the ViewController used by React Native.
  self.initialProps = @{};
  BOOL init = [super application:application didFinishLaunchingWithOptions:launchOptions];   <-----|
  NSURL *jsCodeLocation = [self sourceURLForBridge:nil];                                           |
  RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation                    |
    moduleName:self.moduleName                                                                     | 
    initialProperties:self.initialProps                                                            |
    launchOptions:launchOptions];                                                                  |   Add all these lines
    RNKeyListener *keyListenerViewController = [RNKeyListener new];                                |
  self.window.rootViewController = keyListenerViewController;                                      |
  self.window.rootViewController.view = rootView;                                                  |
  [self.window makeKeyAndVisible];                                                                 |
  return init;                                                                               <-----|
}


@end
```

## Usage

Whenever you want to use it within React Native code now you can:

`import KeyEvent from 'react-native-keyevent';`

```javascript
  componentDidMount() {
    // if you want to react to keyDown
    KeyEvent.onKeyDownListener((keyEvent) => {
      console.log(`onKeyDown keyCode: ${keyEvent.keyCode}`);
      console.log(`Action: ${keyEvent.action}`);
      console.log(`Key: ${keyEvent.pressedKey}`);
    });

    // if you want to react to keyUp
    KeyEvent.onKeyUpListener((keyEvent) => {
      console.log(`onKeyUp keyCode: ${keyEvent.keyCode}`);
      console.log(`Action: ${keyEvent.action}`);
      console.log(`Key: ${keyEvent.pressedKey}`);
    });

    // if you want to react to keyMultiple
    KeyEvent.onKeyMultipleListener((keyEvent) => {
      console.log(`onKeyMultiple keyCode: ${keyEvent.keyCode}`);
      console.log(`Action: ${keyEvent.action}`);
      console.log(`Characters: ${keyEvent.characters}`);
    });
  }

  componentWillUnmount() {
    // if you are listening to keyDown
    KeyEvent.removeKeyDownListener();

     // if you are listening to keyUp
    KeyEvent.removeKeyUpListener();

     // if you are listening to keyMultiple
    KeyEvent.removeKeyMultipleListener();
  }
```
