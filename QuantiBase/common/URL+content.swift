//
//  URL+content.swift
//  QuantiBase
//
//  Created by Martin Troup on 07/02/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

import Foundation

extension URL {
	/// Gets string value stored within file described by the URL.
	public var content: String? {
		do {
			let archiveData = try Data(contentsOf: self)
			return archiveData.base64EncodedString(options: Data.Base64EncodingOptions.init(rawValue: 0))
		} catch let error {
            QuantiBaseEnv.current.logger.log("\(#function) - failed to get Data instance from logFilesArchive with \(error).", onLevel: .error)
			return nil
		}
	}
}
