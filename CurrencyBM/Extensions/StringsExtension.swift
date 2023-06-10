//
//  StringsExtension.swift
//  CurrencyBM
//
//  Created by Omar M1 on 03/06/2023.
//

import Foundation

extension String {
    func currencyInputFormattingFiled() -> String {
        var amountWithPrefix: String = self
        if self.contains(".") {
            let splitStr = self.split(separator: ".")
            if splitStr[1].count == 1 {
                amountWithPrefix = self.appending("0")
            } else if splitStr[1].count >= 3 {
                let numberFormatter = NumberFormatter()
                numberFormatter.minimumFractionDigits = 2
                numberFormatter.maximumFractionDigits = 2
                numberFormatter.locale = Locale(identifier: "EN")
                numberFormatter.roundingMode = .down
                amountWithPrefix = numberFormatter.string(from: NSNumber(value: Double(self) ?? 0.0)) ?? "0.0"
            }
        }
        else {
            amountWithPrefix = self.appending("00")
        }
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.locale = Locale(identifier: "EN")
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: amountWithPrefix.count), withTemplate: "")
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
