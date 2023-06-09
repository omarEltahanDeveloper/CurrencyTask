//
//  CurrenciesService.swift
//  CurrencyBM
//
//  Created by Omar M1 on 03/06/2023.
//

import Foundation
protocol CurrenciesService {
    func getAllCurrencies(completion: @escaping (Result<AllSymbolsItem, Error>) -> Void)
}

public class AppCurrenciestService: CurrenciesService {
    let router: Router
    init() {
        self.router = Router()
    }

    func getAllCurrencies(completion: @escaping (Result<AllSymbolsItem, Error>) -> Void) {
        return router.request(endpoint: .getAllSymbols, completion: completion)
    }
    func getAmountValueComparingCurrencies(base: String, target: [String], completion: @escaping (Result<AllRatesItem, Error>) -> Void) {
        return router.request(endpoint: .getAmountValueComparingCurrencies(base: base, target: target), completion: completion)
    }
}
