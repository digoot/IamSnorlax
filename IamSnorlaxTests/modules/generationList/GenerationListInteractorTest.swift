//
//  GenerationListInteractorTest.swift
//  IamSnorlaxTests
//
//  Created by Diego Otero Mata on 22/11/2020.
//

import Cuckoo
import Foundation
import Nimble
import OHHTTPStubs
import Quick
import RxBlocking
import Alamofire
@testable import IamSnorlax

class GenerationListInteractorTest: QuickSpec {
    override func spec() {
        describe("Interactor") {
            let host = "pokeapi.co"
            let encoder = JSONEncoder()
            var interactor: PresenterToInteractorGenerationListProtocol?

            beforeSuite {
                interactor = GenerationListInteractor()
            }

            afterSuite {
                interactor = nil
                HTTPStubs.removeAllStubs()
            }

            describe("fetching data") {
                context("when network is down") {
                    beforeEach {
                        stub(condition: isHost(host)) { _ -> HTTPStubsResponse in
                            let noConnection = AFError.createURLRequestFailed(
                                error: NSError(domain: NSURLErrorDomain, code: URLError.notConnectedToInternet.rawValue)
                            )
                            return HTTPStubsResponse(error: noConnection)
                        }
                    }
                    it("generations ids should be nil") {
                        let result = try? interactor?.fetchGenerations().toBlocking().single()
                        expect(result).to(beNil())
                    }
                    it("generations should be nil") {
                        let result = try? interactor?.fetchGenerationsWith(ids: ["1","2"]).toBlocking().single()
                        expect(result).to(beNil())
                    }
                }

                context("when data is empty") {
                    it("generations ids should be empty") {
                        stub(condition: isHost(host)) { _ -> HTTPStubsResponse in
                            let list = List(count: 0, next: nil, previous: nil, results: [])
                            let data = (try? encoder.encode(list)) ?? Data()
                            return HTTPStubsResponse(data: data, statusCode: 200, headers: nil)
                        }
                        let result = try? interactor?.fetchGenerations().toBlocking().single()
                        expect(result).to(beEmpty())
                    }
                }

                context("when data is not empty") {
                    it ("should fetch generations ids") {
                        stub(condition: isHost(host)) { _ -> HTTPStubsResponse in
                            let results = [
                                DataSet(name: "generation-i", url: URL(string: "https://pokeapi.co/api/v2/generation/1/")!),
                                DataSet(name: "generation-ii", url: URL(string: "https://pokeapi.co/api/v2/generation/2/")!)
                            ]
                            let list = List(count: 0, next: nil, previous: nil, results: results)
                            let data = (try? encoder.encode(list)) ?? Data()
                            return HTTPStubsResponse(data: data, statusCode: 200, headers: nil)
                        }
                        let result = try? interactor?.fetchGenerations().toBlocking().single()
                        expect(result).notTo(beEmpty())
                        expect(result?.count).to(equal(2))
                    }
                    it("should fetch generations") {
                        stub(condition: isHost(host)) { _ -> HTTPStubsResponse in
                            let generation = Generation(id: 1, names: nil, versionGroups: nil)
                            let data = (try? encoder.encode(generation)) ?? Data()
                            return HTTPStubsResponse(data: data, statusCode: 200, headers: nil)
                        }
                        let result = try? interactor?.fetchGenerationsWith(ids: ["1"]).toBlocking().single()
                        expect(result).notTo(beEmpty())
                    }
                }
                
                context("api throws bad request") {
                    beforeEach {
                        stub(condition: isHost(host)) { _ -> HTTPStubsResponse in
                            return HTTPStubsResponse(data: Data(), statusCode: 400, headers: nil)
                        }
                    }
                    it("generations ids should be nil") {
                        let result = try? interactor?.fetchGenerations().toBlocking().single()
                        expect(result).to(beNil())
                    }
                    it("generations should be nil") {
                        let result = try? interactor?.fetchGenerationsWith(ids: ["1"]).toBlocking().single()
                        expect(result).to(beNil())
                    }
                }
                
                context("api throws server error") {
                    beforeEach {
                        stub(condition: isHost(host)) { _ -> HTTPStubsResponse in
                            return HTTPStubsResponse(data: Data(), statusCode: 500, headers: nil)
                        }
                    }
                    it("generations ids should be nil") {
                        let result = try? interactor?.fetchGenerations().toBlocking().single()
                        expect(result).to(beNil())
                    }
                    it("generations should be nil") {
                        let result = try? interactor?.fetchGenerationsWith(ids: ["1"]).toBlocking().single()
                        expect(result).to(beNil())
                    }
                }
            }
            
        }
    }
}
