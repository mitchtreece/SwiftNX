
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
import sdl2

include "lib/swiftnx.swift"

@_silgen_name("swift_main")
func swift_main() -> Int {

    // let app = NXApplet.current
    // let gfx = NXGfx()

    gfxInitDefault()

    var console = PrintConsole()
    consoleInit(&console)
    consoleSelect(&console)
    printf("Hello, swift!")

    while(appletMainLoop()) {

        // gfx.clean()

        gfxFlushBuffers()
        gfxSwapBuffers()
        gfxWaitForVsync()

    }

    // gfx.exit()
    gfxExit()

    // return app.exit(0)
    return 0

}
