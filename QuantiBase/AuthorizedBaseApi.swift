//
//  AuthorizedBaseApi.swift
//  2N-mobile-communicator
//
//  Created by Martin Troup on 23/04/2018.
//  Copyright © 2018 quanti. All rights reserved.
//

import Foundation

class AuthorizedBaseApi: BaseApi {
    override var _session: URLSession {
        return URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
    }

    private let urlCredential: URLCredential

    init?(url: String, userCredentials: UserCredentials) {
        self.urlCredential = URLCredential(user: userCredentials.username, password: userCredentials.password, persistence: .none)
        super.init(url: url)
    }

    convenience init?(url: String, username: String, password: String) {
        self.init(url: url, userCredentials: UserCredentials(username: username, password: password))
    }

    required init?(url: String) {
        self.urlCredential = URLCredential(user: "", password: "", persistence: .none)
        super.init(url: url)
    }
}

// MARK: - URLSessionDelegate methods to handle HTTP authentication.
extension AuthorizedBaseApi: URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
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
    func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        urlSession(session, didReceive: challenge, completionHandler: completionHandler)
    }
}
