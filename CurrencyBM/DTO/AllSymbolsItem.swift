//
//  AllSymbolsItem.swift
//  CurrencyBM
//
//  Created by Omar M1 on 03/06/2023.
//

import Foundation
class AllSymbolsItem: Codable {
    var success: Bool
    var error: ErrorResponse?
    var symbols: [String: String]?
}


class AllRatesItem: Codable {
    var success: Bool
    var error: ErrorResponse?
    var rates: [String: Double]?
}
