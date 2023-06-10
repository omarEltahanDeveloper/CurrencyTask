//
//  CurrenciesSelectionView.swift
//  CurrencyBM
//
//  Created by Omar M1 on 09/06/2023.
//


import SwiftUI
import CoreData
import RxSwift

struct CurrencySelectionView: View {
    let listOfCurrencies : [ItemCurrency]
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
