//
//  VersionListInteractor.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 24/10/2020.
//

import Foundation
import RxSwift

class VersionListInteractor: PresenterToInteractorVersionListProtocol {
    func fetchGroupBy(id: String) -> PublishSubject<Group?> {
        return GroupRepository().fetchGroup(id: id)
    }
    
    func fetchVersionBy(id: String) -> PublishSubject<Version?> {
        return VersionRepository().fetchVersion(id: id)
    }
}
