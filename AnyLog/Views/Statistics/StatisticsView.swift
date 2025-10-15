import SwiftUI

struct StatisticsView: View {
    @EnvironmentObject var dateHolder: DateHolder
    @State private var segmentedIndex: Int = 0
    
    var PickerView: some View {
        Picker("Mode",selection: $segmentedIndex) {
            Text(SegmentMenu.first.rawValue).tag(0)
            Text(SegmentMenu.second.rawValue).tag(1)
        }.pickerStyle(.segmented)
    }
    
    var DateSelector: some View {
        HStack {
            Button { dateHolder.prevMonthMove()} label: {
                Image(systemName: "chevron.left").font(.system(size: 15)).foregroundStyle(Color.primary)
            }
            Spacer()
            Button { dateHolder.dateSelected = Date() } label: {
                Text(dateHolder.dateSelected.yearMonth)
                    .font(Font.system(size: 15))
                    .bold()
                    .foregroundStyle(Color.primary)
            }
            Spacer()
            Button { dateHolder.nextMonthMove()} label: {
                Image(systemName: "chevron.right").font(.system(size: 15)).foregroundStyle( Color.primary)
            }
        }
    }
    
    var body: some View {
        
        VStack{
         
            Text("이달의 통계").font(.system(size: 20, weight: .bold))
            PickerView.padding(.top, 10)
            DateSelector.padding(.top,20)
            GraphSectorMark()
            
            Spacer()
            
        }.padding(.horizontal, 20)
        
        
    }
}

#Preview {
    StatisticsView()
        .environmentObject(DateHolder())
}

enum SegmentMenu: String{
    case first = "식단비율"
    case second = "식단횟수"
}

