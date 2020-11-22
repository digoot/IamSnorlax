//
//  GenerationListInteractorTest.swift
//  IamSnorlaxTests
//
//  Created by Diego Otero Mata on 22/11/2020.
//

import Foundation
import Nimble
import Quick
import Cuckoo
import RxBlocking
@testable import IamSnorlax

class GenerationListInteractorTest: QuickSpec {
    
    var interactor: GenerationListInteractor?
    var repository: MockGenerationRepository?

    override func spec() {
        describe("Interactor") {
            beforeSuite {
                self.interactor = GenerationListInteractor()
                self.repository = MockGenerationRepository()
            }
            
            afterSuite {
                self.interactor = nil
                self.repository = nil
            }
            
            context("blah blah") {
                it("meh") {
                    
                }
            }
        }
    }
    
}
