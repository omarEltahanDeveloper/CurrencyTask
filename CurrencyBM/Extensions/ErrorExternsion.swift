//
//  ErrorExternsion.swift
//  CurrencyBM
//
//  Created by Omar M1 on 04/06/2023.
//

import Foundation
extension Error {
    var displayMessage: String {
        if let error = self as? APIError {
            switch error {
            case .parsingError:
                return "Error while parsing"
            case .invalidResponse:
                return "Response is invalid"
            case .requestFailed(let des):
                return des
            case .requestError(let err):
                return err.localizedDescription
            default:
                return "General error"
            }
        } else {
            return self.localizedDescription
        }
    }
}
