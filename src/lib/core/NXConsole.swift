
/**
 * @Author: Mitch Treece <mitchtreece>
 * @Date:   05-28-2018
 * @Email:  mitchtreece@me.com
 * @Project: SwiftNX
 * @Filename: NXConsole.swift
 * @Last modified by:   mitchtreece
 * @Last modified time: 05-28-2018
 */

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
