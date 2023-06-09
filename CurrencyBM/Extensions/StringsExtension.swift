//
//  StringsExtension.swift
//  CurrencyBM
//
//  Created by Omar M1 on 03/06/2023.
//

import Foundation

extension String {
    func toAmountCorrectFormatToCalculate() -> String {
        var value = self
        value = value.replacingOccurrences(of: ",", with: "")
        return value
    }
}
