//
//  Resource.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 13/05/2020.
//

import Alamofire
import Foundation
import RxSwift

struct IASError: Error {
    var title: String?
    var messages: [Int: String]?
    var code: Int?
}

public enum ReadType {
    case all, onlyDataBase, onlyWebService
}

public protocol NetworkResourceProtocol {
    associatedtype Result

    func fetchFrom() -> ReadType
    func fetchFromDataBase() -> Result
    func fetchFromWebService() -> DataRequest?
    func saveWebServiceResult(with data: AFDataResponse<Any>)
    func convertToObject(with data: AFDataResponse<Any>) -> Result
}

class Resource<ResultType>: NetworkResourceProtocol {
    // MARK: - Variables

    typealias Result = ResultType?

    let messages = [
        0: "Unknown error",
        1: "No web service specified",
        2: "There's no status code",
        3: "Impossible to get data"
    ]
    let result = ReplaySubject<ResultType?>.createUnbounded()

    // MARK: - Constructor

    init() {
        call()
    }

    // MARK: - Functions

    fileprivate func call() {
        let dbResult = fetchFromDataBase()
        if fetchFrom() == .onlyDataBase {
            completed(data: dbResult)
        } else {
            callWebService(with: dbResult)
        }
    }

    fileprivate func callWebService(with data: ResultType?) {
        guard let request = fetchFromWebService() else {
            error(IASError(messages: messages, code: 1))
            return
        }
        request.responseJSON { response in
            guard let code = response.response?.statusCode else {
                guard data != nil else {
                    self.error(IASError(messages: self.messages, code: 2))
                    return
                }
                self.completed(data: data)
                return
            }
            switch code {
                case 200 ..< 300:
                    if self.fetchFrom() == .onlyWebService {
                        let data = self.convertToObject(with: response)
                        self.completed(data: data)
                        return
                    }
                    self.saveWebServiceResult(with: response)
                    if let d = self.fetchFromDataBase() {
                        self.completed(data: d)
                    } else if let x = data {
                        self.completed(data: x)
                    } else {
                        self.error(IASError(messages: self.messages, code: 3))
                    }
                case 400 ..< 600:
                    self.error(
                        IASError(code: response.error?.responseCode)
                    )
                    guard let errorMessage = response.error?.errorDescription else { return }
                    Log.print.warning(errorMessage)
                    request.cURLDescription { curl in
                        Log.print.info(curl)
                }
                default:
                    self.error(IASError(messages: self.messages, code: 0))
            }
        }
    }

    func fetchFrom() -> ReadType {
        return .all
    }

    func fetchFromDataBase() -> ResultType? {
        return nil
    }

    func fetchFromWebService() -> DataRequest? {
        return nil
    }

    func saveWebServiceResult(with data: AFDataResponse<Any>) {}

    func convertToObject(with data: AFDataResponse<Any>) -> ResultType? {
        return nil
    }

    fileprivate func completed(data: ResultType?) {
        result.onNext(data)
        result.onCompleted()
    }

    fileprivate func error(_ error: IASError) {
        result.onError(error)
    }
}
