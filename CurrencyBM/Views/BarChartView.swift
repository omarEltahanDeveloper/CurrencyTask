import SwiftUI
import Charts
import CoreData

struct ChartItem: Identifiable {
    var date: String
    var listData: [Currencies]
    var id = UUID()
}

struct BarChartView: View {
    var data: [ChartItem]
    var chartviewheight = UIScreen.main.bounds.height / 6
    var body: some View {
        ZStack {
            HStack(alignment: .bottom) {
                let largest = getLargestCount()
                ForEach(data) { datum in
                    VStack {
                        Text(String(datum.listData.count)).font(.system(size: 8)).foregroundColor(.gray)
                        Rectangle().fill(Color.primaryColor)
                            .frame(width: 30,height: largest > 0 ? (chartviewheight * CGFloat(Double(datum.listData.count)/Double(largest))) : chartviewheight)
                        Text(datum.date).font(.system(size: 9))
                    }
                }
            }
        }.padding()
        .frame(maxWidth: .infinity).overlay(
            RoundedRectangle(cornerRadius: 0)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
    
    
    func getLargestCount() -> Int {
        var largestNumber : Int = 0
        for itemdata in data {
            if itemdata.listData.count > largestNumber {
                largestNumber = itemdata.listData.count
            }
        }
        
        return largestNumber
    }
}
