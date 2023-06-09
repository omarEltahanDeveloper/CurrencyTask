//
//  CurrenciesViewModel.swift
//  CurrencyBM
//
//  Created by Omar M1 on 03/06/2023.
//

import Foundation
import RxSwift
import RxRelay

class CurrenciesViewModel {
    private let dataSubjectListOfAmount = PublishSubject<[String]>()
    private let dataSubjectAmount = PublishSubject<Double>()
    private let dataSubject = PublishSubject<[String]>()
    private let dataSubjectError = PublishSubject<String>()
    var dataObservable: Observable<[String]> {
        return dataSubject.asObservable()
    }
    var dataObservableAmount: Observable<Double> {
        return dataSubjectAmount.asObservable()
    }
    
    var dataObservableListOfAmount: Observable<[String]> {
        return dataSubjectListOfAmount.asObservable()
    }
    
    var dataObservableError: Observable<String> {
        return dataSubjectError.asObservable()
    }
    
    let currencyUsecase: CurrenciesUseCases

    init() {
        self.currencyUsecase = CurrenciesUseCases()
    }
    
    func getAllAvailableCurrencies() {
        currencyUsecase.getAllCurrencies { result in
            switch result {
            case .success(let items):
                self.dataSubject.onNext(items.sorted { $0 < $1 })
                self.dataSubject.onCompleted()
            case .failure(let error):
                self.dataSubjectError.onNext(error.displayMessage)
            }
        }
            
    }
    
    func getAmountValueComparingCurrencies(base: String, target: String) {
        currencyUsecase.getAmountValueComparingCurrencies(base: base, target: target) { result in
            switch result {
            case .success(let valueamount):
                self.dataSubjectAmount.onNext(valueamount)
            case .failure(let error):
                self.dataSubjectError.onNext(error.displayMessage)
            }
        }
            
    }
    func getAllAmountsToCurrency(base: String, target: [String]) {
        currencyUsecase.getAllAmountsToCurrency(base: base, target: target) { result in
            switch result {
            case .success(let listamounts):
                self.dataSubjectListOfAmount.onNext(listamounts)
            case .failure(let error):
                self.dataSubjectError.onNext(error.displayMessage)
            }
        }
            
    }
    
}
