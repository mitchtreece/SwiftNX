
/**
 * @Author: Mitch Treece <mitchtreece>
 * @Date:   05-24-2018
 * @Email:  mitchtreece@me.com
 * @Project: SwiftNX
 * @Filename: main.swift
 * @Last modified by:   mitchtreece
 * @Last modified time: 05-28-2018
 */

import libnx
// import swiftnx

// MARK: Console (raw)

@_silgen_name("swift_main")
func swift_main() -> Int {

    consoleInit(nil)
    print("Hello, Swift!")

    while(appletMainLoop()) {
        consoleUpdate(nil)
    }

    consoleExit(nil)
    return 0

}

// MARK: GFX

// @_silgen_name("swift_main")
// func swift_main() -> Int {
//
//     // let app = NXApplet.current
//     // let gfx = NXGfx()
//
//     gfxInitDefault()
//
//     socketInitializeDefault()
//     nxlinkStdio()
//
//     var console = PrintConsole()
//     consoleInit(&console)
//     consoleSelect(&console)
//     printf("Hello, swift!")
//
//     while(appletMainLoop()) {
//
//         // gfx.clean()
//
//         gfxFlushBuffers()
//         gfxSwapBuffers()
//         gfxWaitForVsync()
//
//     }
//
//     // gfx.exit()
//
//     socketExit()
//     gfxExit()
//     // return app.exit(0)
//     return 0
//
// }

// MARK: UI (SDL)

// @_silgen_name("swift_main")
// func swift_main() -> Int {
//
//     let app = NXApplet.current
//
//     app.mainLoop {
//
//         app.renderer.clear()
//
//         let view = NXUIView(frame: NXUIRect(x: 0, y: 0, width: 100, height: 100))
//         view.color = NXUIColor.red
//         app.renderer.draw(view)
//
//         // if flag {
//         //     return app.exit(0)
//         // }
//
//     }
//
//     app.renderer.present()
//
// }

// MARK: Applet + console

// @_silgen_name("swift_main")
// func swift_main() -> Int {
//
//     gfxInitDefault()
//
//     let console = NXConsole()
//     console.print("Hello, swift!")
//
//     NXApplet.main {
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

// MARK: Console only - NOT WORKING (no console text is drawn)

// @_silgen_name("swift_main")
// func swift_main() -> Int {
//
//     gfxInitDefault()
//
//     let console = NXConsole()
//     console.print("Hello, swift!")
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

// MARK: Applet only - WORKING (console text looks weird)

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
//     NXApplet.main {
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

// MARK: Template - WORKING

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
