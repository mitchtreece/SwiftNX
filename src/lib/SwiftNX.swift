
/**
 * @Author: Mitch Treece <mitchtreece>
 * @Date:   05-28-2018
 * @Email:  mitchtreece@me.com
 * @Project: SwiftNX
 * @Filename: SwiftNX.swift
 * @Last modified by:   mitchtreece
 * @Last modified time: 05-28-2018
 */

@_silgen_name("printf")
func printf(_ format: StaticString, _ parameters: StaticString ...)

// TODO: Fix include.py paths so they're relative to the current include file's path
// i.e. "NXApplet.swift" from this directory should resolve to: ../path/to/project/src/lib/NXApplet.swift"

// MARK: Core

include "lib/NXApplet.swift"
include "lib/NXConsole.swift"
include "lib/NXGfx.swift"
// include "lib/NXInput.swift"

// MARK: UI

include "lib/ui/NXUIPoint.swift"
include "lib/ui/NXUIRect.swift"
include "lib/ui/NXUIColor.swift"
