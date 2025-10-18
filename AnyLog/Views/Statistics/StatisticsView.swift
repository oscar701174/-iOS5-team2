import SwiftUI

struct StatisticsView: View {
    @Namespace var ID1
    @Namespace var ID2
    @EnvironmentObject var dateHolder: DateHolder
    @State private var position = ScrollPosition(idType: Namespace.ID.self)
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
                    .font(.subheadline)
                    .foregroundStyle(Color.primary)
            }
            Spacer()
            Button { dateHolder.dateSelected = Date(); segmentedIndex = 0 } label: {
                Text(dateHolder.dateSelected.yearMonth)
                    .font(.subheadline)
                    .bold()
                    .foregroundStyle(Color.primary)
            }
            Spacer()
            Button { dateHolder.nextMonthMove()} label: {
                Image(systemName: "chevron.right")
                    .font(.subheadline)
                    .foregroundStyle( Color.primary)
            }
        }
    }
    
    var graphContainer: some View {
        ScrollViewReader { proxy in
            
            GeometryReader { geo in
                let width = geo.size.width
                let height = geo.size.height
                let isLandscapeH = width > height
                ScrollView(.horizontal) {
                    HStack{
                        if isLandscapeH {
                            GraphSectorMarkH().id(ID1).frame(minWidth:width)
                        } else {
                            GraphSectorMark().id(ID1).frame(minWidth:width)
                        }
                        
                        GraphBarMark().id(ID2).frame(minWidth:width)
                        
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
            
        }
        
        
    }
    
    var body: some View {
        VStack{
            
            VStack{
                Text("이달의 통계")
                    .font(.title3)
                    .bold()
                    .padding(.top,20)
                pickerView.frame(maxWidth: 400).padding(.top, 10)
                dateSelector.frame(maxWidth: 400).padding(.top,20)
            }.padding(.horizontal, 20)
            graphContainer.padding(5)
            
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
