//
//  CurrenciesRepository.swift
//  CurrencyBM
//
//  Created by Omar M1 on 03/06/2023.
//

import Foundation

final class CurrenciesRepository {
    private var service: AppCurrenciestService
    init() {
        self.service = AppCurrenciestService()
    }
    
    func getAllCurrencies(onComplete: @escaping (Result<[String],Error>) -> Void) {
        service.getAllCurrencies { result in
            switch result {
            case .success(let model):
                if model.success {
                    onComplete(.success(Array((model.symbols ?? [:]).keys)))
                }
                else {
                    onComplete(.failure(APIError.requestFailed(model.error?.info ?? model.error?.type ?? "")))
                }
            case .failure(let error):
                onComplete(.failure(error))
            }
        }
    }
    
    func getAmountValueComparingCurrencies(base: String, target: String, onComplete: @escaping (Result<Double,Error>) -> Void) {
        service.getAmountValueComparingCurrencies(base: base, target: [target]) { result in
            switch result {
            case .success(let model):
                if model.success {
                    if let firstValue = (model.rates ?? [:]).values.first {
                        onComplete(.success(firstValue))
                    }
                    else {
                        onComplete(.failure(APIError.invalidResponse))
                    }
                }
                else {
                    onComplete(.failure(APIError.requestFailed(model.error?.info ?? model.error?.type ?? "")))
                }
                
            case .failure(let error):
                onComplete(.failure(error))
            }
        }
    }
    
    func getAllAmountsToCurrency(base: String, target: [String], onComplete: @escaping (Result<[String],Error>) -> Void) {
        service.getAmountValueComparingCurrencies(base: base, target: target) { result in
            switch result {
            case .success(let model):
                if model.success {
                    var arrVals = Array<String>()
                    for (key,value) in (model.rates ?? [:]) {
                        arrVals.append("\(value)\(key)")
                    }
                    onComplete(.success(arrVals))
                }
                else {
                    onComplete(.failure(APIError.requestFailed(model.error?.info ?? model.error?.type ?? "")))
                }
                
            case .failure(let error):
                onComplete(.failure(error))
            }
        }
    }
}
