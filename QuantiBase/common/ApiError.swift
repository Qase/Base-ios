//
//  ApiError.swift
//  ciggy-time
//
//  Created by Martin Troup on 10/04/2018.
//  Copyright © 2018 ciggytime.com. All rights reserved.
//

import Foundation

public typealias ReturnCode = Int

public enum ApiError: Error {
	// 400
	case badRequest(Data)
	// 401
	case unauthorized(Data)
	// 404
	case notFound(Data)
    // 409
    case conflict(Data)
	// 5xx
	case serverFailure(Data)
	// any other status code
	case unspecified(ReturnCode, Data)
	case parsingJsonFailure(Error)

	public static func == (lhs: ApiError, rhs: ApiError) -> Bool {
		switch (lhs, rhs) {
		case (.badRequest, .badRequest),
			 (.unauthorized, .unauthorized),
			 (.notFound, .notFound),
			 (.serverFailure, .serverFailure),
			 (.unspecified, .unspecified),
             (.conflict, .conflict),
			 (.parsingJsonFailure, .parsingJsonFailure):
			return true
		default:
			return false
		}
	}

	public static func === (lhs: ApiError, rhs: ApiError) -> Bool {
		switch (lhs, rhs) {
		case (.badRequest(let a), .badRequest(let b)):
			return a == b
		case (.unauthorized(let a), .unauthorized(let b)):
			return a == b
		case (.notFound(let a), .notFound(let b)):
			return a == b
        case (.conflict(let a), .conflict(let b)):
            return a == b
		case (.serverFailure(let a), .serverFailure(let b)):
			return a == b
		case (.unspecified(let a), .unspecified(let b)):
			return a == b
		case (.parsingJsonFailure, .parsingJsonFailure):
			return true
		default:
			return false
		}
	}
}
