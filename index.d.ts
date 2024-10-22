declare module 'react-native-keyevent'

export enum action { KEY_DOWN = 0, KEY_UP = 1, KEY_MULTIPLE = 2 }
export type keyEvent = { action: action; keyCode: number; pressedKey: string }
export type multipleKeyEvent = keyEvent & { repeatCount: number; characters?: string }
export function onKeyDownListener(callback: (keyEvent: keyEvent) => void)
export function onKeyUpListener(callback: (keyEvent: keyEvent) => void)
export function onKeyMultipleListener(callback: (keyEvent: multipleKeyEvent) => void)

export function removeKeyDownListener(): void
export function removeKeyUpListener(): void
export function removeKeyMultipleListener(): void
