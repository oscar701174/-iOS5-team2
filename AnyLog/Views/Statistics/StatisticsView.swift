import SwiftUI

struct StatisticsView: View {
    @Namespace var ID1
    @Namespace var ID2
    @State private var position = ScrollPosition(idType: Namespace.ID.self)
    @EnvironmentObject var dateHolder: DateHolder
    @State private var segmentedIndex: Int = 0

    
    var pickerView: some View {
        Picker("Mode",selection: $segmentedIndex) {
            Text(SegmentMenu.first.rawValue).tag(0)
            Text(SegmentMenu.second.rawValue).tag(1)
        }.pickerStyle(.segmented)
    }
    
    var dateSelector: some View {
        HStack {
            Button { dateHolder.prevMonthMove()} label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 15))
                    .foregroundStyle(Color.primary)
            }
            Spacer()
            Button { dateHolder.dateSelected = Date(); segmentedIndex = 0 } label: {
                Text(dateHolder.dateSelected.yearMonth)
                    .font(Font.system(size: 15))
                    .bold()
                    .foregroundStyle(Color.primary)
            }
            Spacer()
            Button { dateHolder.nextMonthMove()} label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 15))
                    .foregroundStyle( Color.primary)
            }
        }
    }
    
    var graphContainer: some View {
        ScrollViewReader { proxy in
            GeometryReader { geo in
                let width = geo.size.width
                let height = geo.size.height
                
                ScrollView(.horizontal) {
                    LazyHStack{
                        GraphSectorMark().id(ID1).frame(minWidth:width, minHeight: height)
                        GraphBarMark().id(ID2).frame(minWidth:width ,minHeight: height)
                    }
                    .scrollTargetLayout()
                }
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.paging)
                .scrollPosition($position)
                .onChange(of: segmentedIndex){ prev, newValue in
                    withAnimation{ newValue == 0 ? proxy.scrollTo(ID1) : proxy.scrollTo(ID2) }
                }
                .onChange(of: position) { prev, newValue in
                    guard let scrollID = newValue.viewID(type: Namespace.ID.self) else {return}
                    withAnimation{
                        scrollID == ID1 ? (segmentedIndex = 0) : (segmentedIndex = 1) }
                }
            }
            .padding(.bottom,30)
        }
        
        
    }
    
    var body: some View {
        VStack{
            VStack{
                Text("이달의 통계").font(.system(size: 20, weight: .bold)).padding(.top,20)
                pickerView.frame(maxWidth: 400).padding(.top, 10)
                dateSelector.frame(maxWidth: 400).padding(.top,20)
            }.padding(.horizontal, 20)
            graphContainer
            Spacer()
        }
    } //body
}

#Preview {
    StatisticsView()
        .environmentObject(DateHolder())
}

enum SegmentMenu: String{
    case first = "식단비율"
    case second = "시간대별 횟수"
}
