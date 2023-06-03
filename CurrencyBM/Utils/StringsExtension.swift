//
//  StringsExtension.swift
//  CurrencyBM
//
//  Created by Omar M1 on 03/06/2023.
//

import Foundation

extension String {
    func currencyInputFormattingFiledTF() -> String {
        var amountWithPrefix: String = self
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.locale = Locale(identifier: "EN")
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: self.count), withTemplate: "")
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        return formatter.string(from: number)!.replacingOccurrences(of: "$", with: "")
    }
    func toAmountCorrectFormatToCalculate() -> String {
        var value = self
        value = value.replacingOccurrences(of: ",", with: "")
        return value
    }
}
