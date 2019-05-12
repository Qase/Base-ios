//
//  ApiFactory.swift
//  ciggy-time
//
//  Created by Martin Troup on 10/04/2018.
//  Copyright © 2018 ciggytime.com. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

/// A class that provides static methods that make API request/response communication easier.
public class ApiFactory {
}

// MARK: - Set of static methods that enable building URLRequest instances.
extension ApiFactory {
	/// Method to build a specific URL request with URL parameters.
	///
	/// - Parameters:
	///   - baseUrl: Base URL of the request.
	///   - pathComponent: Specific path compoment that gets appended to the base URL.
	///   - method: HTTP method of the request.
	///   - params: Dictionary with parameters that should be added to the URL.
	/// - Returns: URLRequest instance if the method succeeds to create it, nil otherwise.
	public static func buildRequest(baseUrl: URL, pathComponent: String, method: HttpMethod, withUrlParams params: [(String, String)]) -> URLRequest? {
		let urlRequest = buildRequest(baseUrl: baseUrl, pathComponent: pathComponent, method: method)

		guard var _urlRequest = urlRequest else {
			print("\(#function) - urlRequest is nil.")
			return nil
		}

		guard let _url = _urlRequest.url else {
			print("\(#function) - could not get url property from urlRequest.")
			return nil
		}

		let urlComponents = URLComponents(url: _url, resolvingAgainstBaseURL: true)

		guard var _urlComponents = urlComponents else {
			print("\(#function) - could not construct urlComponents based on url.")
			return nil
		}

		_urlComponents.queryItems = params.map { URLQueryItem(name: $0.0, value: $0.1) }

		_urlRequest.url = _urlComponents.url

		return _urlRequest
	}

	/// Method to build a specific URL request with JSON data within the body of the request.
	///
	/// - Parameters:
	///   - baseUrl: Base URL of the request.
	///   - pathComponent: Specific path compoment that gets appended to the base URL.
	///   - method: HTTP method of the request.
	///   - data: JSON data (Data instance) to be added to the body of the request.
	/// - Returns: URLRequest instance if the method succeeds to create it, nil otherwise.
	public static func buildRequest(baseUrl: URL, pathComponent: String, method: HttpMethod, withJsonBody data: Data) -> URLRequest? {
		var urlRequest = buildRequest(baseUrl: baseUrl, pathComponent: pathComponent, method: method)
		urlRequest?.httpBody = data

		return urlRequest
	}

    /// Method to build a specific URL request with JSON data within the body of the request.
    ///
    /// - Parameters:
    ///   - baseUrl: Base URL of the request.
    ///   - pathComponent: Specific path compoment that gets appended to the base URL.
    ///   - method: HTTP method of the request.
    ///   - encodable: JSON data (Anything that implements Encodable protocol) to be added to the body of the request.
    /// - Returns: URLRequest instance if the method succeeds to create it, nil otherwise.
    public static func buildRequest<Object: Encodable>(baseUrl: URL, pathComponent: String, method: HttpMethod, withJsonBody encodable: Object) -> URLRequest? {
        do {
            let jsonData = try JSONEncoder().encode(encodable)
            return buildRequest(baseUrl: baseUrl, pathComponent: pathComponent, method: method, withJsonBody: jsonData)
        } catch let error {
            print("\(#function) - failed to encode Encodable instance to JSON: \(error).")
            return nil
        }
    }

	/// Method to build a specific URL request.
	///
	/// - Parameters:
	///   - baseUrl: Base URL of the request.
	///   - pathComponent: Specific path compoment that gets appended to the base URL.
	///   - method: HTTP method of the request.
	/// - Returns: URLRequest instance if the method succeeds to create it, nil otherwise.
	public static func buildRequest(baseUrl: URL, pathComponent: String, method: HttpMethod) -> URLRequest? {
		let url = baseUrl.appendingPathComponent(pathComponent)

		var urlRequest = URLRequest(url: url)
		urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
		urlRequest.httpMethod = method.rawValue

		// Handling caches, Etag in our case
		urlRequest.cachePolicy = .useProtocolCachePolicy
		urlRequest.timeoutInterval = 60

		return urlRequest
	}
}

// MARK: - Set of static methods that enable sending requests and receiving appropriate responses on a specific API.
extension ApiFactory {
	/// Method to receive a response based on a provided URL request.
	///
	/// - Parameters:
	///   - request: URL request.
	///   - session: Session in which the request should be sent.
	/// - Returns: Data instance if received as a part of HTTP body, nil if not, ApiError instance otherwise.
	public static func data(`for` request: URLRequest, `in` session: URLSession) -> Observable<Data> {
		print("\(#function) - \(request.logDescription)")

		return session.rx.response(request: request)
			.do(onNext: { (response, data) in
				print("\(#function) - \(response.logDescription) + data: \(data)")
			}, onError: { (error) in
				print("\(#function) - error occured: \(error).")
			})
			.flatMap { (response, data) -> Observable<Data> in
				Observable.deferred {
					switch response.statusCode {
					case 200..<300:
						return .just(data)
					case 400:
						return .error(ApiError.badRequest(data))
					case 401:
						return .error(ApiError.unauthorized(data))
					case 404:
						return .error(ApiError.notFound(data))
					case 500..<600:
						return .error(ApiError.serverFailure(data))
					default:
						return .error(ApiError.unspecified(response.statusCode, data))
					}
				}
		}
	}

	/// Method to receive a response based on a provided URL request - used for no response body requests.
	///
	/// - Parameters:
	///   - request: URL request.
	///   - session: Session in which the request should be sent.
	/// - Returns: .completed if request success, ApiError otherwise.
	public static func noData(`for` request: URLRequest, `in` session: URLSession) -> Observable<Void> {
		return data(for: request, in: session).flatMap { _ in Observable.just(()) }
	}

	/// Method to receive a JSON response based on a provided URL request.
	///
	/// - Parameters:
	///   - request: URL request.
	///   - session: Session in which the request should be sent.
	/// - Returns: JSON data if received and parsed successfully, ApiError instance otherwise.
	public static func json<T: Decodable>(`for` request: URLRequest, `in` session: URLSession, using jsonDecoder: JSONDecoder? = nil) -> Observable<T> {
		return data(for: request, in: session)
			.flatMap { data -> Observable<T> in
				Observable.deferred {
					do {
						return try .just((jsonDecoder ?? JSONDecoder()).decode(T.self, from: data))
					} catch let error {
						return .error(ApiError.parsingJsonFailure(error))
					}
				}
		}
	}
}
