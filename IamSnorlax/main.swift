//
//  Main.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/11/2020.
//

import UIKit

let appDelegateClass: AnyClass = NSClassFromString("TestingAppDelegate") ?? AppDelegate.self

UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(appDelegateClass))
