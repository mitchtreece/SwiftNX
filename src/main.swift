import stdlib
import libnx

@_silgen_name("printf")
func printf(_ format: StaticString, _ parameters: StaticString ...)

@_silgen_name("swift_main")
func swift_main() -> Int {

    var console = PrintConsole()

    gfxInitDefault()

    consoleInit(&console)
    consoleSelect(&console)

    printf("Hello, world!")

    while(appletMainLoop()) {

        gfxFlushBuffers()
		gfxSwapBuffers()
        gfxWaitForVsync()

    }

    gfxExit()
    return 0

}
