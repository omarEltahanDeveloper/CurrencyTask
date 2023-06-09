//
//  ContentView.swift
//  CurrencyBM
//
//  Created by Omar M1 on 03/06/2023.
//

import SwiftUI
import CoreData
import RxSwift


struct ItemCurrency: Identifiable {
    let id = UUID()
    let name: String
}


struct CurrenciesView: View {

    let viewmodel : CurrenciesViewModel = CurrenciesViewModel()
    let disposeBag = DisposeBag()
    @State var listOfCurrencies : [ItemCurrency] = []
    @State var showalert = false
    @State var errorValue = ""
    @State var fromValue = "From:"
    @State var toValue = "To:"
    @State var fromAmountValue = "1"
    @State var toAmountValue = "xxxx"
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .top,spacing: 10) {
                    CurrencySelectionView(listOfCurrencies: listOfCurrencies, editablefield: true, titleValue: "From:", selectedValue: $fromValue, amountValue: $fromAmountValue)
                        .onChange(of: self.fromAmountValue) { value in
                            updateCurrency()
                        }
                    Image("transfer").onTapGesture {
                        if fromValue != "From:" && toValue != "To:" {
                            let fromOldValue = fromValue
                            fromValue = toValue
                            toValue = fromOldValue
                            viewmodel.getAmountValueComparingCurrencies(base: fromValue, target: toValue)
                        }
                    }
                    CurrencySelectionView(listOfCurrencies: listOfCurrencies, editablefield: false, titleValue: "To:", selectedValue: $toValue, amountValue: $toAmountValue)
                        .onChange(of: self.fromValue) { value in
                            updateCurrency()
                        }
                        .onChange(of: self.toValue) { value in
                            updateCurrency()
                        }
                }.padding(.horizontal,20)
                
                
                NavigationLink(destination: DetailsView(fromValue: fromValue)) {
                    Text("Details")
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 18,weight: .semibold))
                        .foregroundColor(.black)
                        .padding(.vertical,7).padding(.horizontal,15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color.gray, lineWidth: 0.5)
                        ).padding(.top)
                }
                
                
                
            }
            .alert(isPresented: self.$showalert) {
                Alert(title: Text(errorValue).foregroundColor(.red),dismissButton: .default(Text("ok")))
            }
            .onAppear{
                listenToObservables()
                viewmodel.getAllAvailableCurrencies()
            }
        }
    }
    
    func listenToObservables() {
        viewmodel.dataObservable
                    .subscribe(onNext: { data in
                        self.listOfCurrencies = data.map { ItemCurrency(name: $0) }
                    })
                    .disposed(by: disposeBag)
        
        viewmodel.dataObservableAmount
                    .subscribe(onNext: { amountvalue in
                        self.toAmountValue =  String(amountvalue * (Double(fromAmountValue) ?? 1.0)).currencyInputFormattingFiled()
                        let db = DBManager()
                        db.checkExistance(from: fromValue, to: toValue)
                    })
                    .disposed(by: disposeBag)
      
        
        viewmodel.dataObservableError
                   .subscribe(onNext: { error in
                       errorValue = error == "" ? "General error" : error
                       self.showalert = true
                   })
                   .disposed(by: disposeBag)
    }
    func updateCurrency() {
        if fromAmountValue.isEmpty {
            toAmountValue = "xxxx"
            return
        }
        if fromValue != "From:" && toValue != "To:" {
            viewmodel.getAmountValueComparingCurrencies(base: fromValue, target: toValue)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CurrenciesView()
    }
}


