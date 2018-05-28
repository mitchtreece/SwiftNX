
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

include "lib/SwiftNX.swift"

// // MARK: Applet + console
//
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
//
// // MARK: Console only
//
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

// MARK: Applet only

@_silgen_name("swift_main")
func swift_main() -> Int {

    gfxInitDefault()

    var console = PrintConsole()
    consoleInit(&console)
    consoleSelect(&console)
    printf("Hello, swift!")

    NXApplet.main {

        gfxFlushBuffers()
        gfxSwapBuffers()
        gfxWaitForVsync()

    }

    gfxExit()
    return 0

}

// MARK: Template

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
