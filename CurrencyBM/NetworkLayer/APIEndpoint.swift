//
//  APIEndpoint.swift
//  CurrencyBM
//
//  Created by Omar M1 on 04/06/2023.
//

import Foundation
enum APIEndpoint {
    case getAllSymbols
    case getAmountValueComparingCurrencies(base: String, target: [String])
    var path: String {
        switch self {
            case .getAllSymbols:
                return "symbols"
            case .getAmountValueComparingCurrencies(_,_):
                return "latest"
        }
    }
    
    var parameters: [String: String] {
        switch self {
            case .getAllSymbols:
                return [:]
        case .getAmountValueComparingCurrencies(base: let base, target: let target):
            let separator = ","
            let combinedString = target.joined(separator: separator)
            return ["base" : base, "symbols" : combinedString]
        }
    }

    var httpMethod: String {
        return "GET"
    }
}
