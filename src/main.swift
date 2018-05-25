import stdlib
import libnx

@_silgen_name("printf")
func printf(_ format: StaticString, _ parameters: StaticString ...)

class NXApplet {

    static func main(_ loop: ()->()) {

        while(appletMainLoop()) {
            loop()
        }

    }

}

class NXGfx {

    func flush() {
        gfxFlushBuffers()
    }

    func swap() {
        gfxSwapBuffers()
    }

    func waitForVsync() {
        gfxWaitForVsync()
    }

    func exit(_ code: Int) -> Int {

        gfxExit()
        return code

    }

}

// struct NXConsole {
//
//     private var _console: PrintConsole
//
//     init() {
//
//         _console = PrintConsole()
//         _init()
//
//     }
//
//     private mutating func _init() {
//         consoleInit(&_console)
//     }
//
//     mutating func select() {
//         consoleSelect(&_console)
//     }
//
//     func print(_ string: StaticString) {
//         printf(string)
//     }
//
// }

@_silgen_name("swift_main")
func swift_main() -> Int {

    let gfx = NXGfx()

    // var console = NXConsole()
    // console.select()
    // console.print("Hello, world!")

    NXApplet.main {

        gfx.flush()
        gfx.swap()
        gfx.waitForVsync()

    }

    return gfx.exit(0)

}

// @_silgen_name("swift_main")
// func swift_main() -> Int {
//
//     gfxInitDefault()
//
//     var console = PrintConsole()
//     consoleInit(&console)
//     consoleSelect(&console)
//     printf("Hello, world!")
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
