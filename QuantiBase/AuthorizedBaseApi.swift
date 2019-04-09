//
//  AuthorizedBaseApi.swift
//  2N-mobile-communicator
//
//  Created by Dagy Tran on 16/04/2019.
//  Copyright © 2019 quanti. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public enum SessionDataEvents {
    case didReceiveResponse(session: URLSession,
        dataTask: URLSessionDataTask,
        response: URLResponse,
        completion: (URLSession.ResponseDisposition) -> Void)
    case didReceiveData(session: URLSession, dataTask: URLSessionDataTask, data: Data)
    case didCompleteWithError(session: URLSession, dataTask: URLSessionTask, error: Error?)
    case didBecomeInvalidWithError(session: URLSession, error: Error?)
}

open class AuthorizedBaseApi: BaseApi {
    override public var _session: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 5
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }

    private let urlCredential: URLCredential
    public let sessionEventsSubject = PublishSubject<SessionDataEvents>()

    public var sessionEvents: Observable<SessionDataEvents> {
        return sessionEventsSubject
    }

    // MARK: - Initializers

    public init?(url: String, urlCredential: URLCredential) {
        self.urlCredential = urlCredential
        super.init(url: url)
    }

    public init(with baseURL: URL, authorizeUsing urlCredential: URLCredential) {
        self.urlCredential = urlCredential
        super.init(url: baseURL)
    }

    required public init?(url: String) {
        self.urlCredential = URLCredential(user: "", password: "", persistence: .none)
        super.init(url: url)
    }
}

// MARK: - URLSessionDelegate methods to handle HTTP authentication.
extension AuthorizedBaseApi: URLSessionDelegate {
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            if let serverTrust = challenge.protectionSpace.serverTrust {
                completionHandler(.useCredential, URLCredential(trust: serverTrust))
            } else {
                completionHandler(.cancelAuthenticationChallenge, nil)
            }

            return
        }

        guard challenge.previousFailureCount == 0 else {
            completionHandler(.rejectProtectionSpace, nil)
            return
        }

        completionHandler(.useCredential, urlCredential)
    }
}

// MARK: - URLSessionTaskDelegate methods
extension AuthorizedBaseApi: URLSessionTaskDelegate {
    //  Handle HTTP authentication.
    public func urlSession(_ session: URLSession,
                           task: URLSessionTask,
                           didReceive challenge: URLAuthenticationChallenge,
                           completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        urlSession(session, didReceive: challenge, completionHandler: completionHandler)
    }

    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        sessionEventsSubject.onNext(.didCompleteWithError(session: session, dataTask: task, error: error))
    }
}

extension AuthorizedBaseApi: URLSessionDataDelegate {
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        sessionEventsSubject.onNext(.didReceiveData(session: session, dataTask: dataTask, data: data))
    }

    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        sessionEventsSubject.onNext(.didReceiveResponse(session: session,
                                                        dataTask: dataTask,
                                                        response: response,
                                                        completion: completionHandler))
    }
}
