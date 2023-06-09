//
//  CurrenciesUseCases.swift
//  CurrencyBM
//
//  Created by Omar M1 on 03/06/2023.
//

import Foundation

public class CurrenciesUseCases {
    private var cRepository: CurrenciesRepository
    init() {
        self.cRepository = CurrenciesRepository()
    }
    
    func getAllCurrencies(onComplete: @escaping (Result<[String],Error>) -> Void) {
        self.cRepository.getAllCurrencies(onComplete: onComplete)
    }
    
    func getAmountValueComparingCurrencies(base: String, target: String, onComplete: @escaping (Result<Double,Error>) -> Void) {
        self.cRepository.getAmountValueComparingCurrencies(base: base, target: target, onComplete: onComplete)
    }
    func getAllAmountsToCurrency(base: String, target: [String], onComplete: @escaping (Result<[String],Error>) -> Void) {
        self.cRepository.getAllAmountsToCurrency(base: base, target: target, onComplete: onComplete)
    }
}
