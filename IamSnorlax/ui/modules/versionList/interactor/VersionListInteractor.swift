//
//  VersionListInteractor.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 24/10/2020.
//

import Foundation
import RxSwift

class VersionListInteractor: PresenterToInteractorVersionListProtocol {
    func fetchGroupBy(id: Int64) -> ReplaySubject<Group?> {
        return GroupRepository().fetchGroup(id: id)
    }
    
    func fetchVersionBy(id: Int64) -> ReplaySubject<Version?> {
        return VersionRepository().fetchVersion(id: id)
    }
}
