import UIKit
@objc(RNKeyEvent)
class RNKeyEvent: RCTEventEmitter {
    static var instance:RNKeyEvent!
    override init(){
        super.init()
        RNKeyEvent.instance = self
    }

    var hasListener: Bool = false

    override func startObserving() {
      hasListener = true
    }

    override func stopObserving() {
       hasListener = false
     }

    @objc
    override func supportedEvents() -> [String]! {
      ["onKeyDown", "onKeyUp"]
    }

    @objc override static func requiresMainQueueSetup() -> Bool {
        return false

    }
    @objc func onKeyDown(keyEvent: [String: Any]) -> Void{
        sendEvent(withName: "onKeyDown", body: keyEvent)
        }
    @objc func onKeyUp(keyEvent: [String: Any]) -> Void {
        sendEvent(withName: "onKeyUp", body: keyEvent)
        }
}
