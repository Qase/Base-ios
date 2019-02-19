//
//  URLRequest+logDescription.swift
//  ciggy-time
//
//  Created by Martin Troup on 10/04/2018.
//  Copyright © 2018 ciggytime.com. All rights reserved.
//

import Foundation

extension URLRequest {
	public var logDescription: String {
		return "Request: {url: \(url?.description ?? "nil"), method: \(httpMethod?.description ?? "nil"), headersFields: \(allHTTPHeaderFields?.description ?? "nil")}"
	}
}
