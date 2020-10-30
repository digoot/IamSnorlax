//
//  Log.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 11/05/2020.
//

import Foundation
import SwiftyBeaver

class Log: SwiftyBeaver {
    static let print: SwiftyBeaver.Type = {
        let log = SwiftyBeaver.self
        let console = ConsoleDestination()
        console.format = "$DHH:mm:ss$d $L $N.$F():$l - $M"
        console.levelString.verbose = "[🗣 VERBOSE]"
        console.levelString.debug = "[🐛 DEBUG]"
        console.levelString.info = "[ℹ️ INFO]"
        console.levelString.warning = "[⚠️ WARNING]"
        console.levelString.error = "[🛑 ERROR]"
        log.addDestination(console)
        return log
    }()
}
