//
//  BaseResponse.swift
//  CurrencyBM
//
//  Created by Omar M1 on 03/06/2023.
//

import Foundation


class BaseResponse : Codable {
    var success: Bool
    var error: ErrorResponse?
}

class ErrorResponse : Codable {
    var info: String?
    var type: String?
}
