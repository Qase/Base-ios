//
//  ApiError.swift
//  ciggy-time
//
//  Created by Martin Troup on 10/04/2018.
//  Copyright © 2018 ciggytime.com. All rights reserved.
//

import Foundation

enum ApiError: Error {
	case unknownSession
	// 400
	case badRequest
	// 401
	case unauthorized
	// 404
	case notFound
	// 5xx
	case serverFailure
	// any other status code
	case unspecified(Int)
	case parsingJsonFailure
	case invalidRequest

	static func == (lhs: ApiError, rhs: ApiError) -> Bool {
		switch (lhs, rhs) {
		case (.unknownSession, .unknownSession),
			 (.badRequest, .badRequest),
			 (.unauthorized, .unauthorized),
			 (.notFound, .notFound),
			 (.serverFailure, .serverFailure),
			 (.unspecified(_), .unspecified(_)),
			 (.parsingJsonFailure, .parsingJsonFailure),
			 (.invalidRequest, .invalidRequest):
			return true
		default:
			return false
		}
	}

	static func === (lhs: ApiError, rhs: ApiError) -> Bool {
		switch (lhs, rhs) {
		case (.unspecified(let a), .unspecified(let b)):
			return a == b
		case (.unknownSession, .unknownSession),
			 (.badRequest, .badRequest),
			 (.unauthorized, .unauthorized),
			 (.notFound, .notFound),
			 (.serverFailure, .serverFailure),
			 (.parsingJsonFailure, .parsingJsonFailure),
			 (.invalidRequest, .invalidRequest):
			return true
		default:
			return false
		}
	}
}
