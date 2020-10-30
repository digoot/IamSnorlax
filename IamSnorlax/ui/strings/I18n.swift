//
//  I18n.swift
//  Dogoplay
//
//  Created by Carlos Pérez Ponce on 18/08/2020.
//  Copyright © 2020 Cleventy. All rights reserved.
//

import Foundation

struct I18n {
    
    private static let tableName = "Localizable"
    
    static func getString(_ key: String, _ params: CVarArg...) -> String {
        let t = localizer()
        return withVaList(params) { t(key, $0) }
    }
    
    private static func localizer() -> (_ key: String, _ params: CVaListPointer) -> String {
        return { (key: String, params: CVaListPointer) in
            let content = NSLocalizedString(key, tableName: tableName, comment: "")
            return NSString(format: content, arguments: params) as String
        }
    }
}
