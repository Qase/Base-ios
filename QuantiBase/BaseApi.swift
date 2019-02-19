//
//  BaseApi.swift
//  ciggy-time
//
//  Created by Martin Troup on 10/04/2018.
//  Copyright © 2018 ciggytime.com. All rights reserved.
//

import Foundation

import RxSwift

public class BaseApi: NSObject {
	public let session: URLSession = URLSession(configuration: URLSessionConfiguration.default)
	public let url: URL

	required init?(url: String) {
		guard let _url = URL(string: url) else {
			print("\(#function) - could not create an URL instance out of provided URL string.")
			return nil
		}

		self.url = _url
	}
}
