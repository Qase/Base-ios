//
//  AuthorizedBaseApi.swift
//  2N-mobile-communicator
//
//  Created by Martin Troup on 23/04/2018.
//  Copyright © 2018 quanti. All rights reserved.
//

import Foundation

open class AuthorizedBaseApi: BaseApi {
    override public var _session: URLSession {
        return URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
    }

    let credentials: UserCredentials

    public init?(url: String, userCredentials: UserCredentials) {
        self.credentials = userCredentials
        super.init(url: url)
    }

    public convenience init?(url: String, username: String, password: String) {
        self.init(url: url, userCredentials: UserCredentials(username: username, password: password))
    }

    public convenience init?(with baseURL: URL, authorizeUsing credentials: UserCredentials) {
        self.init(url: baseURL.absoluteString, userCredentials: credentials)
    }

    required public init?(url: String) {
        self.credentials = UserCredentials(username: "", password: "")
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

        completionHandler(.useCredential, URLCredential(user: credentials.username, password: credentials.password, persistence: .forSession))
    }
}

// MARK: - URLSessionTaskDelegate methods to handle HTTP authentication.
extension AuthorizedBaseApi: URLSessionTaskDelegate {
    public func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        urlSession(session, didReceive: challenge, completionHandler: completionHandler)
    }
}
