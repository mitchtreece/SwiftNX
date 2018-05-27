import stdlib
import libnx

include "lib/NXTest.swift"

@_silgen_name("printf")
func printf(_ format: StaticString, _ parameters: StaticString ...)

class NXApplet {

    static func main(_ loop: ()->()) {

        while(appletMainLoop()) {
            loop()
        }

    }

}

class NXConsole {

    private var _console: PrintConsole

    init() {

        _console = PrintConsole()
        _init()

    }

    private func _init() {
        consoleInit(&_console)
    }

    func becomeRenderTarget() {
        consoleSelect(&_console)
    }

    func print(_ string: StaticString) {

        becomeRenderTarget()
        printf(string)

    }

}

class NXGfx {

    init() {
        gfxInitDefault()
    }

    func _flush() {
        gfxFlushBuffers()
    }

    func _swap() {
        gfxSwapBuffers()
    }

    func _waitForVsync() {
        gfxWaitForVsync()
    }

    func clean() {

        _flush()
        _swap()
        _waitForVsync()

    }

    func exit(_ code: Int) -> Int {

        gfxExit()
        return code

    }

}

// class NXInput {
//
//     enum ControllerId: Int {
//
//         case p1 = 0
//         case p2 = 1
//         case p3 = 2
//         case p4 = 3
//         case p5 = 4
//         case p6 = 5
//         case p7 = 6
//         case p8 = 7
//         case handheld = 8
//         case unknown = 9
//         case p1_auto = 10
//
//     }
//
//     struct ControllerKey: OptionSet {
//
//         let rawValue: Int
//
//         // Need to figure out (power) button code
//         static let plus = ControllerKey(rawValue: 1 << 10)
//         static let minus = ControllerKey(rawValue: 1 << 11)
//
//     }
//
//     struct Info {
//
//         var keysDown: ControllerKey
//         var keysUp: ControllerKey
//         var keysHeld: ControllerKey
//
//     }
//
//     static func scan(controllerId: ControllerId = .p1_auto) -> Info {
//
//         // let _keyPlus = ControllerKey(rawValue: Int(KEY_PLUS.rawValue))
//         // let _keyMinus = ControllerKey(rawValue: Int(KEY_MINUS.rawValue))
//
//         ///////////////////////
//
//         let r_cid: Int = controllerId.rawValue
//         let cid = HidControllerID(rawValue: UInt32(r_cid))
//
//         let rawKeysDown: UInt64 = hidKeysDown(cid)
//         let rawKeysUp: UInt64 = hidKeysUp(cid)
//         let rawKeysHeld: UInt64 = hidKeysHeld(cid)
//
//         let keysDown = ControllerKey(rawValue: Int(rawKeysDown))
//         let keysUp = ControllerKey(rawValue: Int(rawKeysUp))
//         let keysHeld = ControllerKey(rawValue: Int(rawKeysHeld))
//
//         return Info(keysDown: keysDown, keysUp: keysUp, keysHeld: keysHeld)
//
//     }
//
// }

// @_silgen_name("swift_main")
// func swift_main() -> Int {
//
//     let gfx = NXGfx()
//     let console = NXConsole()
//
//     console.print("Hello, world!")
//
//     let test = NXTest()
//     test.test()
//
//     NXApplet.main {
//
//         let info = NXInput.scan()
//
//         if info.keysDown.contains(.plus) {
//             console.print("You pressed the plus (+) key!")
//         }
//
//         if info.keysUp.contains(.plus) {
//             console.print("You released the plus (+) key!")
//         }
//
//         gfx.clean()
//
//     }
//
//     return gfx.exit(0)
//
// }

// @_silgen_name("swift_main")
// func swift_main() -> Int {
//
//     let gfx = NXGfx()
//     let console = NXConsole()
//
//     console.print("Hello, swift!")
//
//     NXApplet.main {
//         gfx.clean()
//     }
//
//     return gfx.exit(0)
//
// }


// Missing console + NXApplet code
@_silgen_name("swift_main")
func swift_main() -> Int {

    gfxInitDefault()

    let test = NXTest()
    test.test()

    let console = NXConsole()
    console.print("Hello, swift!")

    while(appletMainLoop()) {

        gfxFlushBuffers()
        gfxSwapBuffers()
        gfxWaitForVsync()

    }

    gfxExit()
    return 0

}

// MARK: Basic

// @_silgen_name("swift_main")
// func swift_main() -> Int {
//
//     gfxInitDefault()
//
//     var console = PrintConsole()
//     consoleInit(&console)
//     consoleSelect(&console)
//     printf("Hello, swift!")
//
//     while(appletMainLoop()) {
//
//         gfxFlushBuffers()
//         gfxSwapBuffers()
//         gfxWaitForVsync()
//
//     }
//
//     gfxExit()
//     return 0
//
// }
