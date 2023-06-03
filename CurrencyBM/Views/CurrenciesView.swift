//
//  ContentView.swift
//  CurrencyBM
//
//  Created by Omar M1 on 03/06/2023.
//

import SwiftUI
import CoreData


struct ItemCurrency: Identifiable {
    let id = UUID()
    let name: String
}



struct CurrenciesView: View {
    @State var fromValue = "From:"
    @State var toValue = "To:"
    @State var fromAmountValue = "01.00"
    @State var toAmountValue = "xxxx"
    var body: some View {
        VStack {
            HStack(alignment: .top,spacing: 10) {
                CurrencySelectionView(editablefield: true, titleValue: "From:", selectedValue: $fromValue, amountValue: $fromAmountValue)
                    .onChange(of: self.fromAmountValue) { value in
                        self.fromAmountValue = value.currencyInputFormattingFiledTF()
                        self.toAmountValue = String((Double(value.currencyInputFormattingFiledTF().toAmountCorrectFormatToCalculate()) ?? 0.0) * 2.0).currencyInputFormattingFiledTF()
                    }
                Image("transfer").onTapGesture {
                    if fromValue != "From:" && toValue != "To:" {
                        let fromOldValue = fromValue
                        fromValue = toValue
                        toValue = fromOldValue
                    }
                }
                CurrencySelectionView(editablefield: false, titleValue: "To:", selectedValue: $toValue, amountValue: $toAmountValue)
            }.padding(.horizontal,20)
            
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
        .onAppear{
            NetworkManager.shared.makeRequest(with: Constants.urlSession(urlvalue: "symbols")) { data, response, error in
                // Handle the response and error
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CurrenciesView()
    }
}




struct CurrencySelectionView: View {
    let listOfCurrencies = ["EUR","USD","EGP","SAR"].map { ItemCurrency(name: $0) }
    var editablefield : Bool
    var titleValue : String
    @Binding var selectedValue : String
    @Binding var amountValue : String
    var body: some View {
        VStack{
            Menu {
                ForEach(listOfCurrencies) { item in
                    Button {
                        self.selectedValue = item.name
                    } label: {
                        Text(item.name)
                    }
                }
            } label: {
                Text(selectedValue)
                    .font(.system(size: 18,weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.vertical,7).padding(.horizontal,15)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(Color.gray, lineWidth: 0.5)
                    )
                    .background(Color.primaryColor)
            }
            if editablefield {
                TextField("x.xx", text: self.$amountValue)
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(.black)
                    .keyboardType(.asciiCapableNumberPad)
                    .padding(.vertical,7).padding(.horizontal,15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(Color.primaryColor, lineWidth: 0.5)
                    )
            }
            else {
                Text(self.amountValue)
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(.black)
                    .padding(.vertical,7).padding(.horizontal,15)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(Color.primaryColor, lineWidth: 0.5)
                    )
            }
        }
    }
}
