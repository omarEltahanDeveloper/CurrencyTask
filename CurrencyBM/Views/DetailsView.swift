//
//  DetailsView.swift
//  CurrencyBM
//
//  Created by Omar M1 on 09/06/2023.
//
import SwiftUI
import CoreData
import RxSwift

struct DetailsView: View {
    @State var data: [ChartItem] = []
    
    @State var listOfCurrenciesComparing : [ItemCurrency] = []
    let viewmodel : CurrenciesViewModel = CurrenciesViewModel()
    let disposeBag = DisposeBag()
    var fromValue: String
    @State var errorValue = ""
    @State var showalert = false
    
    var body: some View {
        ZStack {
            VStack {
                BarChartView(data: data)
                    GeometryReader { geometry in
                        HStack(alignment: .top) {
                            ScrollView(showsIndicators: false){
                                VStack {
                                    ForEach(data) { dataitem in
                                        Text(dataitem.date)
                                            .font(.system(size: 14,weight: .semibold))
                                            .foregroundColor(.white)
                                            .padding(.vertical,10)
                                            .frame(maxWidth: .infinity)
                                            .overlay(RoundedRectangle(cornerRadius: 0).stroke(Color.gray, lineWidth: 0.5))
                                            .background(Color.primaryColor)
                                        ForEach(dataitem.listData) { listdataitem in
                                            HStack {
                                                Text(listdataitem.frombase ?? "")
                                                    .font(.system(size: 14,weight: .semibold))
                                                    .foregroundColor(.white)
                                                    .padding(.vertical,10)
                                                    .frame(maxWidth: .infinity)
                                                    .overlay(RoundedRectangle(cornerRadius: 0).stroke(Color.gray, lineWidth: 0.5))
                                                    .background(Color.accentColor)
                                                
                                                Image("transfer")
                                                    .frame(width: 10,height: 10).scaledToFit()
                                                
                                                Text(listdataitem.tosource ?? "")
                                                    .font(.system(size: 14,weight: .semibold))
                                                    .foregroundColor(.white)
                                                    .padding(.vertical,10)
                                                    .frame(maxWidth: .infinity)
                                                    .overlay(RoundedRectangle(cornerRadius: 0).stroke(Color.gray, lineWidth: 0.5))
                                                    .background(Color.accentColor)
                                            }
                                        }
                                    }
                                }
                                .frame(width: (geometry.size.width / 2) - 15)
                            }
                            
                            
                            
                            Divider().background(Color.gray).frame(maxHeight: .infinity)
                            ScrollView(showsIndicators: false){
                                
                                VStack {
                                    Text(fromValue)
                                        .font(.system(size: 14,weight: .semibold))
                                        .foregroundColor(.white)
                                        .padding(.vertical,10)
                                        .frame(maxWidth: .infinity)
                                        .overlay(RoundedRectangle(cornerRadius: 0).stroke(Color.gray, lineWidth: 0.5))
                                        .background(Color.primaryColor)
                                    VStack {
                                        ForEach(listOfCurrenciesComparing) { currency in
                                            Text(currency.name)
                                                .font(.system(size: 14, weight: .medium))
                                                .foregroundColor(.black)
                                                .padding(.vertical,10)
                                                .frame(maxWidth: .infinity)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 0)
                                                        .stroke(Color.accentColor, lineWidth: 0.5)
                                                )
                                        }
                                    }
                                }
                                .frame(width: (geometry.size.width / 2) - 15)
                            }
                            
                        }
                    }
            }.padding(.horizontal)
        }
        .alert(isPresented: self.$showalert) {
            Alert(title: Text(errorValue).foregroundColor(.red),dismissButton: .default(Text("ok")))
        }
        .onAppear{
            var listOfDates : [ChartItem] = []
            let manager = DBManager()
            for index in 0..<4 {
                let dateis = Date().getDateBack(dayback: index)
                let item = ChartItem(date: dateis, listData: manager.fetchAllRelatedToDate(date: dateis))
                listOfDates.append(item)
            }
            self.data = listOfDates
            
            viewmodel.dataObservableListOfAmount
                .subscribe(onNext: { listofamountvalues in
                    self.listOfCurrenciesComparing = listofamountvalues.map { ItemCurrency(name: $0) }
                })
                .disposed(by: disposeBag)
            viewmodel.dataObservableError
                .subscribe(onNext: { error in
                    errorValue = error == "" ? "General error" : error
                    self.showalert = true
                })
                .disposed(by: disposeBag)
            viewmodel.getAllAmountsToCurrency(base: fromValue, target: ["EUR","EGP","USD","SAR","AUD","CAD","GBP","JPY","BHD","BOB"])
        }
    }
}

