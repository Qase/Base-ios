//
//  HTTPMethod.swift
//  ciggy-time
//
//  Created by Martin Troup on 10/04/2018.
//  Copyright © 2018 ciggytime.com. All rights reserved.
//

import Foundation

public enum HttpMethod: String {
	case get = "GET"
	case head = "HEAD"
	case post = "POST"
	case delete = "DELETE"
	case put = "PUT"
	case patch = "PATCH"
}
