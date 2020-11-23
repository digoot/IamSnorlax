//
//  GenerationListPresenterTest.swift
//  IamSnorlaxTests
//
//  Created by Diego Otero Mata on 22/11/2020.
//

import Alamofire
import Cuckoo
import Foundation
import Nimble
import OHHTTPStubs
import Quick
import RxBlocking
import RxSwift
@testable import IamSnorlax

class GenerationListPresenterTest: QuickSpec {
    override func spec() {
        describe("Presenter") {
            let host = "pokeapi.co"
            let encoder = JSONEncoder()
            var presenter: ViewToPresenterGenerationListProtocol?
            var interactor: PresenterToInteractorGenerationListProtocol?
            var router: MockGenerationListRouter?
            var view: MockGenerationListViewController?

            beforeEach {
                presenter = GenerationListPresenter()
                interactor = GenerationListInteractor()
                router = MockGenerationListRouter()
                view = MockGenerationListViewController()
                presenter?.interactor = interactor
                presenter?.router = router
                presenter?.view = view
            }

            afterEach {
                presenter = nil
                HTTPStubs.removeAllStubs()
            }

            describe("view is ready") {
                describe("loading ids and generations") {
                    context("when connection is down") {
                        it("result should be nil") {
                            stub(condition: isHost(host)) { _ -> HTTPStubsResponse in
                                let noConnection = AFError.createURLRequestFailed(
                                    error: NSError(domain: NSURLErrorDomain, code: URLError.notConnectedToInternet.rawValue)
                                )
                                return HTTPStubsResponse(error: noConnection)
                            }
                            expect(presenter?.generations).notTo(beNil())
                            presenter?.viewIsReady()
                            let results = try? presenter?.generations.toBlocking().first()
                            expect(results).to(beNil())
                        }
                    }
                    
                    context("when data fetched is empty") {
                        it("result should be nil") {
                            stub(condition: isHost(host)) { _ -> HTTPStubsResponse in
                                let list = List(count: 0, next: nil, previous: nil, results: [])
                                let data = (try? encoder.encode(list)) ?? Data()
                                return HTTPStubsResponse(data: data, statusCode: 200, headers: nil)
                            }
                            expect(presenter?.generations).notTo(beNil())
                            presenter?.viewIsReady()
                            let results = try? presenter?.generations.toBlocking().first()
                            expect(results).to(beNil())
                        }
                    }
                    
                    context("when data fetched isn't nil") {
                        it("result shouldn't be nil") {
                            var callCounter = 0
                            stub(condition: isHost(host)) { _ -> HTTPStubsResponse in
                                callCounter += 1
                                if callCounter < 2 {
                                    let results = [
                                        DataSet(name: "generation-i", url: URL(string: "https://pokeapi.co/api/v2/generation/1/")!)
                                    ]
                                    let list = List(count: 2, next: nil, previous: nil, results: results)
                                    let data = (try? encoder.encode(list)) ?? Data()
                                    return HTTPStubsResponse(data: data, statusCode: 200, headers: nil)
                                } else {
                                    let generation = Generation(id: 1, names: nil, versionGroups: nil)
                                    let data = (try? encoder.encode(generation)) ?? Data()
                                    return HTTPStubsResponse(data: data, statusCode: 200, headers: nil)
                                }
                            }
                            expect(presenter?.generations).notTo(beNil())
                            presenter?.viewIsReady()
                            let results = try? presenter?.generations.toBlocking().last()
                            expect(results).notTo(beNil())
                            expect(results??.count).to(equal(1))
                            expect(results??.first?.id).to(equal(1))
                        }
                    }
                }
            }
        }
    }
}
