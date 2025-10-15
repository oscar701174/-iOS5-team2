

import SwiftUI
import SwiftData


struct ComposeView: View {
    @State private var selectedTag: String? = nil
    @State private var date = Date()
    @State private var time = Date()
    @State private var mealText = ""
    @State private var showConfirmAlert = false

    var body: some View {
        
        NavigationStack {
            ScrollView {
                // 식사 종류
                VStack{
                    Text("식사 종류")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .padding(.bottom, 11)
                    
                    HStack(spacing: 8) {
                        TagButton(title: "아침", selectedTag: $selectedTag)
                        TagButton(title: "점심", selectedTag: $selectedTag)
                        TagButton(title: "저녁", selectedTag: $selectedTag)
                        TagButton(title: "간식", selectedTag: $selectedTag)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.bottom, 26)
                
                // 날짜
                VStack(alignment: .leading, spacing: 8) {
                    Text("날짜")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .padding(.bottom, 11)
                    
                    DatePicker("", selection: $date, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .environment(\.locale, Locale(identifier: "ko_KR"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 48)
                        .colorMultiply(.clear)
                        .opacity(0.1)
                        .contentShape(Rectangle())
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                        .overlay(
                            HStack {
                                Text(dateFormatter.string(from: date))
                                    .foregroundColor(.primary)
                                Spacer()
                            }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 14)
                                .allowsHitTesting(false)
                        )
                }
                .padding(.bottom, 26)
                
                // 시간
                VStack {
                    Text("시간")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .padding(.bottom, 11)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    DatePicker("", selection: $time, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .environment(\.locale, Locale(identifier: "ko_KR"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 48)
                        .colorMultiply(.clear)
                        .opacity(0.1)
                        .contentShape(Rectangle())
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                        .overlay(
                            HStack {
                                Text(timeFormatter.string(from: time))
                                    .foregroundColor(.primary)
                                Spacer()
                            }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 14)
                                .allowsHitTesting(false)
                        )
                }
                .padding(.bottom, 26)
                
                // 식사 등록
                VStack {
                    Text("식사 등록")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .padding(.bottom, 11)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ZStack(alignment: .topLeading) {
                        // Placeholder
                        if mealText.isEmpty {
                            Text("오늘 드신 음식을 자세히 적어주세요.")
                                .foregroundColor(.gray)
                                .padding(.top, 12)
                                .padding(.leading, 16)
                        }
                        
                        TextEditor(text: $mealText)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .scrollContentBackground(.hidden)
                            .frame(height: 200)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                    }
                }
            }
            .navigationTitle("식사 등록")
            .navigationBarTitleDisplayMode(.inline)
            
            // 하단 버튼
            .safeAreaInset(edge: .bottom) {
                Button {
                    if selectedTag == nil || mealText.isEmpty {
                        print("123123")
                    } else {
                        showConfirmAlert = true
                    }
                } label: {
                    Text("식단 등록하기")
                        .font(.headline).bold()
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                }
                .foregroundColor(.white)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill((selectedTag == nil || mealText.isEmpty) ? .main.opacity(0.3) : .main
                             )
                    
                )
                .padding(.vertical, 10)
                .ignoresSafeArea(.keyboard, edges: .bottom)
                // 등록 얼럿
                .alert("등록한 내용이 맞습니까?", isPresented: $showConfirmAlert) {
                    Button("취소", role: .cancel) { }
                    Button("등록") {
                        registerMeal()
                    }
                }
                message: {
                    Text("""
                        식사 종류: \(selectedTag ?? "(미선택)")
                        날짜: \(dateFormatter.string(from: date))
                        시간: \(timeFormatter.string(from: time))
                        식사 등록: \(mealText.trimmingCharacters(in: .whitespacesAndNewlines))
                        """)
                }
            }
        }
        .padding(.horizontal, 20)
    }
    
    // 날짜 포맷
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "YYYY년 M월 d일"
        return formatter
    }
    
    // 시간 포맷
    private var timeFormatter: DateFormatter {
        let f = DateFormatter()
        f.locale = Locale(identifier: "ko_KR")
        f.dateFormat = "a hh:mm"
        return f
    }
    
    // 임시.. 프린트 확인용
    private func registerMeal() {
        if let tag = selectedTag {
            print("선택한 식사 종류: \(tag)")
        } else {
            print("선택되지 않았습니다.")
        }
    }
}

#Preview {
    ComposeView()
}


// 태그 버튼
struct TagButton: View {
    var title: String
    
    @Binding var selectedTag: String?
    
    var body: some View {
        
        Button {
            if selectedTag == title {
                selectedTag = nil
            } else {
                selectedTag = title
            }
        } label: {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(selectedTag == title ? .white : .black)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(selectedTag == title ? .black : .gray.opacity(0.3))
                )
        }
    }
}


// 1. 아침, 점심, 저녁 1회만 등록 가능하게
// 2. 식단 등록하기 > 얼럿창 등록 > 목록이동?
