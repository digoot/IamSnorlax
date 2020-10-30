//
//  ApiRestManager.swift
//  Dogoplay
//
//  Created by Diego Otero Mata on 12/05/2020.
//  Copyright © 2020 Cleventy. All rights reserved.
//

import Alamofire
import Foundation

enum HTTPMessages: Int {
    case UNAUTHORIZED
    case FORBIDDEN
    case SUCCESS
    case SERVERERROR

    var range: Range<Int> {
        switch self {
        case .UNAUTHORIZED: return 401 ..< 402
        case .FORBIDDEN: return 403 ..< 404
        case .SUCCESS: return 200 ..< 300
        case .SERVERERROR: return 500 ..< 600
        }
    }
}

class ApiRestManager {
    // MARK: - Variables

    fileprivate var urlEndpoint: String
    fileprivate var session: Session
    fileprivate var sessionDelegate: SessionDelegate
    fileprivate var rootQueue: DispatchQueue
    fileprivate var requestQueue: DispatchQueue
    fileprivate var serializationQueue: DispatchQueue
    fileprivate var interceptor: Interceptor

    // MARK: - Constructor

    init(endpoint: String) {
        urlEndpoint = endpoint
        sessionDelegate = SessionDelegate()
        interceptor = Interceptor()
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = BusinessConstants.shared.timeoutForRequest
        configuration.timeoutIntervalForResource = BusinessConstants.shared.timeoutForResource
        rootQueue = DispatchQueue(label: "com.cleventy.Dogoplay.rootQueue")
        requestQueue = DispatchQueue(label: "com.cleventy.Dogoplay.requestQueue")
        serializationQueue = DispatchQueue(label: "com.cleventy.Dogoplay.serializationQueue")
        session = Session(configuration: configuration, delegate: sessionDelegate, rootQueue: rootQueue,
                          startRequestsImmediately: true, requestQueue: requestQueue,
                          serializationQueue: serializationQueue, interceptor: interceptor, serverTrustManager: nil,
                          redirectHandler: nil, cachedResponseHandler: nil, eventMonitors: [])
    }

    // MARK: - Internal methods

    internal func get(service: String, parameters: Parameters? = nil,
                      encoding: ParameterEncoding = URLEncoding.queryString, headers: HTTPHeaders? = nil,
                      requestModifier: Session.RequestModifier? = nil,
                      completionHandler: @escaping (Bool, AFDataResponse<Any>?) -> Void) {
        request(service: service, method: .get, parameters: parameters, encoding: encoding, headers: headers,
                requestModifier: requestModifier, completionHandler: completionHandler)
    }

    internal func get(service: String, parameters: Parameters? = nil,
                      encoding: ParameterEncoding = URLEncoding.queryString, headers: HTTPHeaders? = nil,
                      requestModifier: Session.RequestModifier? = nil) -> DataRequest {
        return request(service: service, method: .get, parameters: parameters, encoding: encoding, headers: headers,
                       requestModifier: requestModifier)
    }

    internal func post(service: String, parameters: Parameters? = nil,
                       encoding: ParameterEncoding = URLEncoding.httpBody, headers: HTTPHeaders? = nil,
                       requestModifier: Session.RequestModifier? = nil,
                       completionHandler: @escaping (Bool, AFDataResponse<Any>?) -> Void) {
        request(service: service, method: .post, parameters: parameters, encoding: encoding, headers: headers,
                requestModifier: requestModifier, completionHandler: completionHandler)
    }

    internal func post(service: String, parameters: Parameters? = nil,
                       encoding: ParameterEncoding = URLEncoding.httpBody, headers: HTTPHeaders? = nil,
                       requestModifier: Session.RequestModifier? = nil) -> DataRequest {
        return request(service: service, method: .post, parameters: parameters, encoding: encoding, headers: headers,
                       requestModifier: requestModifier)
    }

    internal func put(service: String, parameters: Parameters? = nil,
                      encoding: ParameterEncoding = URLEncoding.httpBody, headers: HTTPHeaders? = nil,
                      requestModifier: Session.RequestModifier? = nil,
                      completionHandler: @escaping (Bool, AFDataResponse<Any>?) -> Void) {
        request(service: service, method: .put, parameters: parameters, encoding: encoding, headers: headers,
                requestModifier: requestModifier, completionHandler: completionHandler)
    }

    internal func put(service: String, parameters: Parameters? = nil,
                      encoding: ParameterEncoding = URLEncoding.httpBody, headers: HTTPHeaders? = nil,
                      requestModifier: Session.RequestModifier? = nil) -> DataRequest {
        return request(service: service, method: .put, parameters: parameters, encoding: encoding, headers: headers,
                       requestModifier: requestModifier)
    }

    // MARK: - Private methods

    fileprivate func request(service: String, method: HTTPMethod, parameters: Parameters?,
                             encoding: ParameterEncoding, headers: HTTPHeaders?,
                             requestModifier: Session.RequestModifier?,
                             completionHandler: @escaping (Bool, AFDataResponse<Any>?) -> Void) {
        session.request(buildURLRequest(service), method: method, parameters: parameters, encoding: encoding,
                        headers: headers, interceptor: interceptor, requestModifier: requestModifier)
            .validate().responseJSON { (dataResponse: AFDataResponse<Any>) in
                if dataResponse.result is Error {
                    self.proccessAFDataResponse(success: false, dataResponse: dataResponse,
                                                completionHandler: completionHandler)
                } else {
                    if self.checkAuthorizationResponse(dataResponse: dataResponse) {
                        self.proccessAFDataResponse(success: self.checkResponseSuccesfull(dataResponse: dataResponse),
                                                    dataResponse: dataResponse, completionHandler: completionHandler)
                    }
                }
            }
    }

    fileprivate func request(service: String, method: HTTPMethod, parameters: Parameters?,
                             encoding: ParameterEncoding, headers: HTTPHeaders?,
                             requestModifier: Session.RequestModifier?) -> DataRequest {
        return session.request(buildURLRequest(service), method: method, parameters: parameters, encoding: encoding,
                               headers: headers, interceptor: interceptor, requestModifier: requestModifier).validate()
    }

    fileprivate func buildURLRequest(_ service: String) -> String {
        return urlEndpoint + service
    }

    fileprivate func proccessAFDataResponse(success: Bool, dataResponse: AFDataResponse<Any>,
                                            completionHandler: @escaping (Bool, AFDataResponse<Any>?) -> Void) {
        completionHandler(success, dataResponse)
    }

    fileprivate func checkAuthorizationResponse(dataResponse: AFDataResponse<Any>) -> Bool {
        guard let httpResponse = dataResponse.response else { return false }
        if HTTPMessages.UNAUTHORIZED.range.contains(httpResponse.statusCode) ||
            HTTPMessages.FORBIDDEN.range.contains(httpResponse.statusCode) {
            return false
        } else {
            return true
        }
    }

    fileprivate func checkResponseSuccesfull(dataResponse: AFDataResponse<Any>) -> Bool {
        guard let httpResponse = dataResponse.response else { return false }
        if HTTPMessages.SUCCESS.range.contains(httpResponse.statusCode) {
            return true
        } else {
            return false
        }
    }
}
