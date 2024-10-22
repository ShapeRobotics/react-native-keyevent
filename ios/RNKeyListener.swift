@objc(RNKeyListener)
class RNKeyListener: UIViewController {
    override func pressesBegan(_ presses: Set<UIPress>,  with event: UIPressesEvent?) {
        for press in presses {
            guard let key = press.key else { continue }
            let keyEvent:[String: Any] = ["pressedKey": key.charactersIgnoringModifiers, "keyCode": key.keyCode.rawValue, "action": 0]
            RNKeyEvent.instance.onKeyDown(keyEvent: keyEvent)
            super.pressesBegan(presses, with: event)
        }
    }
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        for press in presses {
            guard let key = press.key else { continue }
            let keyEvent:[String: Any] = ["pressedKey": key.charactersIgnoringModifiers, "keyCode": key.keyCode.rawValue, "action": 1];
            RNKeyEvent.instance.onKeyUp(keyEvent: keyEvent)
            super.pressesEnded(presses, with: event)
        }
    }
}