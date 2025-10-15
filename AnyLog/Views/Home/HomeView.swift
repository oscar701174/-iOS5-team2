import SwiftUI
import SwiftData


struct HomeView: View {
    @State private var selectedDate = Date()
    @State private var showSheet = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 4) {
                    // 오늘의 식단
                   
                    Text("오늘의 식단")
                        .font(.title)
                        .bold()
                        
                    // 큰 달력
                    DatePicker(
                        "",
                        selection: $selectedDate,
                        displayedComponents: .date
                    )
                    .datePickerStyle(.graphical)
                    .labelsHidden()
                    .tint(.main)
                    .background(in: RoundedRectangle(cornerRadius: 15))
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.tertiary)
                   
                    // 날짜 및 기록
                        VStack {
                            // 선택된 날짜 표시,버튼
                            HStack(spacing: 8) {
                                Text(selectedDate.formatted(date: .long, time: .omitted))
                                    .font(.title3).bold()
                                    .foregroundStyle(Color(.label))
                                
                                Spacer()
                                
                                NavigationLink {
                                    ComposeView()
                                } label: {
                                    Image(systemName: "plus")
                                        .tint(.primary)

                                        .font(.system(size: 16, weight: .bold))
                                       // .foregroundStyle(.white)
                                        .frame(width: 36, height: 36)
                                        .background(
                                            Circle().fill(Color.main)
                                        )

                                }
                                
                            }
                            .padding(.top, 30)
                            .padding(.bottom, 10)

                            
                            // 회고/기록
                            VStack(spacing: 12) {
                                
                                // 아침
                                HStack(alignment: .top) {
                                    Circle()
                                        .frame(width: 10)
                                        .foregroundStyle(.breakfast)
                                        .padding(.top, 4)
                                    Button {
                                        showSheet = true
                                    } label: {
                                        HStack {
                                            VStack(alignment: .leading, spacing: 10) {
                                                Text("아침")
                                                    .font(.callout)
                                                Text("시리얼")
                                                    .font(.headline)
                                            }
                                            Spacer()
                                            Text("07:24 am")
                                                .frame(width: 80, alignment: .trailing)
                                                .foregroundStyle(.secondary)
                                                .font(.subheadline)
                                        }
                                        .font(.body)
                                        .contentShape(Rectangle())
                                        .foregroundStyle(.black)
                                        .padding()
                                        .background(
                                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                                .fill(Color(.systemGray6)) // 원하는 배경색
                                        )
                                    }
                                    .sheet(isPresented: $showSheet) {
                                        ComposeView()
                                    }
                                }
                                
                                // 점심
                                HStack(alignment: .top) {
                                    Circle()
                                        .frame(width: 10)
                                        .foregroundStyle(.lunch)
                                        .padding(.top, 4)
                                    Button {
                                        showSheet = true
                                    } label: {
                                        HStack {
                                            VStack(alignment: .leading, spacing: 10) {
                                                Text("점심")
                                                    .font(.callout)
                                                Text("샐러드, 계란")
                                                    .font(.headline)
                                            }
                                            Spacer()
                                            Text("12:44 pm")
                                                .frame(width: 80, alignment: .trailing)
                                                .foregroundStyle(.secondary)
                                                .font(.subheadline)
                                        }
                                        .font(.body)
                                        .contentShape(Rectangle())
                                        .foregroundStyle(.black)
                                        .padding()
                                        .background(
                                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                                .fill(Color(.systemGray6)) // 원하는 배경색
                                        )
                                    }
                                    .sheet(isPresented: $showSheet) {
                                        ComposeView()
                                    }
                                }
                                
                                // 저녁
                                HStack(alignment: .top) {
                                    Circle()
                                        .frame(width: 10)
                                        .foregroundStyle(.dinner)
                                        .padding(.top, 4)
                                    Button {
                                        showSheet = true
                                    } label: {
                                        HStack {
                                            VStack(alignment: .leading, spacing: 10) {
                                                Text("저녁")
                                                    .font(.callout)
                                                Text("파스타")
                                                    .font(.headline)
                                            }
                                            Spacer()
                                            Text("06:34 pm")
                                                .frame(width: 80, alignment: .trailing)
                                                .foregroundStyle(.secondary)
                                                .font(.subheadline)
                                        }
                                        .font(.body)
                                        .contentShape(Rectangle())
                                        .foregroundStyle(.black)
                                        .padding()
                                        .background(
                                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                                .fill(Color(.systemGray6)) // 원하는 배경색
                                        )
                                    }
                                    .sheet(isPresented: $showSheet) {
                                        ComposeView()
                                    }
                                }
                                
                                // 간식
                                HStack(alignment: .top) {
                                    Circle()
                                        .frame(width: 10)
                                        .foregroundStyle(.snack)
                                        .padding(.top, 4)
                                    Button {
                                        showSheet = true
                                    } label: {
                                        HStack {
                                            VStack(alignment: .leading, spacing: 10) {
                                                Text("간식")
                                                    .font(.callout)
                                                Text("초콜렛")
                                                    .font(.headline)
                                            }
                                            Spacer()
                                            Text("07:15 pm")
                                                .frame(width: 80, alignment: .trailing)
                                                .foregroundStyle(.secondary)
                                                .font(.subheadline)
                                        }
                                        .font(.body)
                                        .contentShape(Rectangle())
                                        .foregroundStyle(.black)
                                        .padding()
                                        .background(
                                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                                .fill(Color(.systemGray6)) // 원하는 배경색
                                        )
                                    }
                                    .sheet(isPresented: $showSheet) {
                                        ComposeView()
                                    }
                                }
                                
                                } //VStack
                                
                            }
                        } // vstack
                    .padding()
                }// ScrollView
                .padding(.horizontal)
                
            } // NavigationStack
            
        } // body
        
    } //struct






#Preview {
    HomeView()
}

