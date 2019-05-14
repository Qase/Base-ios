//
//  BaseApi.swift
//  ciggy-time
//
//  Created by Martin Troup on 10/04/2018.
//  Copyright © 2018 ciggytime.com. All rights reserved.
//

import Foundation

import RxSwift

open class BaseApi: NSObject {
    public var _session: URLSession {
        return URLSession(configuration: URLSessionConfiguration.default)
    }

    public lazy var session: URLSession = {_session}()
	public let url: URL

	public required init?(url: String) {
		guard let _url = URL(string: url) else {
			print("\(#function) - could not create an URL instance out of provided URL string.")
			return nil
		}

		self.url = _url
	}

    public init(url: URL) {
        self.url = url
    }
}
