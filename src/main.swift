
/**
 * @Author: Mitch Treece <mitchtreece>
 * @Date:   05-24-2018
 * @Email:  mitchtreece@me.com
 * @Project: SwiftNX
 * @Filename: main.swift
 * @Last modified by:   mitchtreece
 * @Last modified time: 05-28-2018
 */

import stdlib
import libnx
import sdl2

include "lib/SwiftNX.swift"

// MARK: GFX

@_silgen_name("swift_main")
func swift_main() -> Int {

    let gfx = NXGfx()

    var console = PrintConsole()
    consoleInit(&console)
    consoleSelect(&console)
    printf("Hello, swift!")

    while(appletMainLoop()) {
        gfx.clean()
    }

    return gfx.exit(0)

}

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
