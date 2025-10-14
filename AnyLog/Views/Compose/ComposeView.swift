

import SwiftUI

struct ComposeView: View {
    @State private var SelectedTag: String? = nil
    @State private var date = Date()
    @State private var time = Date()
    
    @State private var mealText = ""

    
    
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
                        TagButton(title: "아침")
                        TagButton(title: "점심")
                        TagButton(title: "저녁")
                        TagButton(title: "간식")
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
                        .environment(\.locale, Locale(identifier: "ko_KR")) // 한국식 (오전/오후)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 14)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
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
                Button(action: registerMeal) {
                    Text("식단 등록하기")
                        .font(.headline).bold()
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                }
                .foregroundColor(.white)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color(red: 0.12, green: 0.13, blue: 0.25)) // 진한 네이비
                )
                .padding(.vertical, 10)
                .ignoresSafeArea(.keyboard, edges: .bottom)
            }
        }
        .padding(.horizontal, 20)
    }
    
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "YYYY년 M월 d일"
        return formatter
    }
    
    private func registerMeal() {
        print("식단 등록 완료!")
    }
}

#Preview {
    ComposeView()
}


// 태그 버튼
struct TagButton: View {
    var title: String
    
    @State private var isSelected = false
    
    var body: some View {
        
        Button {
            isSelected.toggle()
        } label: {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(isSelected ? .white : .black)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(isSelected ? .black : .gray.opacity(0.3))
                )
        }
    }
}
