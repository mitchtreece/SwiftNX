import stdlib
import libnx

@_silgen_name("printf")
func printf(_ format: StaticString, _ parameters: StaticString ...)

@_silgen_name("swift_main")
func swift_main() -> Int {

    gfxInitDefault();
    consoleInit(NULL);

    printf("Hello, world!")

	while (aptMainLoop()) {

		// Scan all the inputs.
        // This should be done once for each frame
		hidScanInput()

		// Flush and swap framebuffers
		gfxFlushBuffers()
		gfxSwapBuffers()
        gfxWaitForVsync()

	}

	gfxExit()
    return 0

}
