//
//  AuthorizedBaseApi.swift
//  2N-mobile-communicator
//
//  Created by Dagy Tran on 16/04/2019.
//  Copyright © 2019 quanti. All rights reserved.
//

import Foundation

open class AuthorizedBaseApi: BaseApi {
    override public var _session: URLSession {
        return URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
    }

    private let urlCredential: URLCredential

    public var didReceiveDataCompletionHandler: ((URLSession, URLSessionDataTask, Data) -> Void)?
    public var didReceiveResponseCompletionHandler: ((URLSession, URLSessionDataTask, URLResponse, (URLSession.ResponseDisposition) -> Void) -> Void)?

    // MARK: - Initializers

    public init?(url: String, urlCredential: URLCredential) {
        self.urlCredential = urlCredential
        super.init(url: url)
    }

    public convenience init?(url: String, username: String, password: String, persistance: URLCredential.Persistence = .none) {
        guard let baseURL = URL(string: url) else { return nil}

        self.init(with: baseURL, authorizeUsing: URLCredential(user: username, password: password, persistence: persistance))
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

// MARK: - URLSessionTaskDelegate methods to handle HTTP authentication.
extension AuthorizedBaseApi: URLSessionTaskDelegate {
    public func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        urlSession(session, didReceive: challenge, completionHandler: completionHandler)
    }
}

extension AuthorizedBaseApi: URLSessionDataDelegate {
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        self.didReceiveDataCompletionHandler?(session, dataTask, data)
    }

    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        self.didReceiveResponseCompletionHandler?(session, dataTask, response, completionHandler)
    }
}
