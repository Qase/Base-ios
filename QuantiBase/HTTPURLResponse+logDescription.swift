//
//  HTTPURLResponse+logDescription.swift
//  ciggy-time
//
//  Created by Martin Troup on 10/04/2018.
//  Copyright © 2018 ciggytime.com. All rights reserved.
//

import Foundation

extension HTTPURLResponse {
	var logDescription: String {
		return "Response: {url: \(url?.description ?? "nil"), statusCode: \(statusCode), headersFields: \(allHeaderFields)}"
	}
}
