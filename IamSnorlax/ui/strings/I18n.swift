//
//  I18n.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 18/05/2020.
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
