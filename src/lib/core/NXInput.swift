
/**
 * @Author: Mitch Treece <mitchtreece>
 * @Date:   05-28-2018
 * @Email:  mitchtreece@me.com
 * @Project: SwiftNX
 * @Filename: NXInput.swift
 * @Last modified by:   mitchtreece
 * @Last modified time: 05-28-2018
 */

class NXInput {

    enum ControllerId: Int {

        case p1 = 0
        case p2 = 1
        case p3 = 2
        case p4 = 3
        case p5 = 4
        case p6 = 5
        case p7 = 6
        case p8 = 7
        case handheld = 8
        case unknown = 9
        case p1_auto = 10

    }

    struct ControllerKey: OptionSet {

        let rawValue: Int

        // Need to figure out (power) button code
        static let plus = ControllerKey(rawValue: 1 << 10)
        static let minus = ControllerKey(rawValue: 1 << 11)

    }

    struct Info {

        var keysDown: ControllerKey
        var keysUp: ControllerKey
        var keysHeld: ControllerKey

    }

    static func scan(controllerId: ControllerId = .p1_auto) -> Info {

        // let _keyPlus = ControllerKey(rawValue: Int(KEY_PLUS.rawValue))
        // let _keyMinus = ControllerKey(rawValue: Int(KEY_MINUS.rawValue))

        ///////////////////////

        let r_cid: Int = controllerId.rawValue
        let cid = HidControllerID(rawValue: UInt32(r_cid))

        let rawKeysDown: UInt64 = hidKeysDown(cid)
        let rawKeysUp: UInt64 = hidKeysUp(cid)
        let rawKeysHeld: UInt64 = hidKeysHeld(cid)

        let keysDown = ControllerKey(rawValue: Int(rawKeysDown))
        let keysUp = ControllerKey(rawValue: Int(rawKeysUp))
        let keysHeld = ControllerKey(rawValue: Int(rawKeysHeld))

        return Info(keysDown: keysDown, keysUp: keysUp, keysHeld: keysHeld)

    }

}
