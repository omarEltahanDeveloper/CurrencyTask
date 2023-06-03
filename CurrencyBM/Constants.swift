//
//  Constants.swift
//  CurrencyBM
//
//  Created by Omar M1 on 03/06/2023.
//

import Foundation
struct Constants {
    static let access_key = "3780f889717bf9d604fcfbd00f029224"
    static let baseURL = "http://data.fixer.io/api/"
    static func urlSession(urlvalue: String) -> URL {
        return URL(string: baseURL + urlvalue + "?access_key=\(access_key)")!
    }
}
