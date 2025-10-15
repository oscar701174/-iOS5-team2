

import SwiftUI
import SwiftData


struct ComposeView: View {
    var mealItem: Meal?
    var todayMeals: [Meal] = []
    
    @State private var selectedMealType: MealType?
    @State private var date = Date.now
    @State private var time = Date.now
    @State private var mealEditorText = ""
    
    @FocusState var textEditorFocus: Bool
    
    @Environment(\.modelContext) var modelContext
    
    // popover 진입이므로 backButton 구현하지 않음
    var body: some View {
        ScrollView {
            VStack(spacing: 36) {
                // Title
                Text(mealItem == nil ? "식단 등록" : "식단 수정")
                    .font(.title2)
                    .bold()
                
                MealTypeButtonView(selectedMealType: $selectedMealType, todayMeals: todayMeals)
                
                DatePickerView(date: $date)
                
                TimePickerView(time: $time)
                
                MealEditorView(mealText: $mealEditorText, textEditorFocus: $textEditorFocus)
                    .padding(.bottom)
            }
            .safeAreaInset(edge: .bottom, content: {
                SubmitButton(
                    mealItem: mealItem,
                    selectedMealType: $selectedMealType,
                    mealEditorText: $mealEditorText,
                    date: date,
                    time: time
                )
            })
            
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
        .onTapGesture {
            textEditorFocus = false
        }
        .onAppear {
            if let mealItem {
                selectedMealType = mealItem.mealType
                date = mealItem.date
                time = mealItem.time
                mealEditorText = mealItem.content
            }
        }
    }
}

#Preview {
    ComposeView(
        mealItem: Meal(
            mealType: MealType.breakfast,
            content: "test",
            date: Date.now,
            time: Date.now
        ),
    
        todayMeals: [
            Meal(
                mealType: MealType.lunch,
                content: "test2",
                date: Date.now,
                time: Date.now
            )
        ]
    ).modelContainer(for: Meal.self, inMemory: true)
}


struct MealTypeButton: View {
    let mealType: MealType
    @Binding var selectedMealType: MealType?
    let todayMeals: [Meal]
    @State var showAlert = false
    
    var body: some View {
        if selectedMealType == mealType {
            Button(mealType.rawValue) {
                selectedMealType = mealType
            }
            .buttonStyle(.borderedProminent)
            .tint(.main)
        } else {
            Button(mealType.rawValue) {
                for todayMeal in todayMeals {
                    guard todayMeal.mealType != mealType else {
                        showAlert.toggle()
                        return
                    }
                }
                selectedMealType = mealType
            }
            .buttonStyle(.bordered)
            .tint(.main)
            .foregroundStyle(.darkmodeBlack)
            .alert("알림", isPresented: $showAlert) {
                Button("확인") {
                    
                }
            } message: {
                Text("이미 \(mealType.rawValue)이 등록되어 있습니다.\n\(mealType.rawValue) 내용을 수정해주세요")
            }
        }
    }

}

struct MealTypeButtonView: View {
    @Binding var selectedMealType: MealType?
    let todayMeals: [Meal]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("식사 종류")
                .font(.subheadline)
                .fontWeight(.medium)
            
            HStack(spacing: 12) {
                ForEach(MealType.allCases) { mealType in
                    MealTypeButton(mealType: mealType, selectedMealType: $selectedMealType, todayMeals: todayMeals)
                }
                
                Spacer()
            }
        }
    }
}

struct DatePickerView: View {
    @Binding var date: Date
    
    var body: some View {
        /// 개선점
        /// 1. 박스 전체가 DatePicker 선택영역으로 지정될 수 있게
        /// 2. DatePicker 날짜 선택 감지 (onChange 말고 같은날짜 선택된것도 감지
        /// 3. DatePicker 날짜 선택 감지 후 Foucs 제거
        ///
        VStack(alignment: .leading, spacing: 16) {
            Text("날짜")
                .font(.subheadline)
                .fontWeight(.medium)
            
            Text(dateFormat(date))
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray.opacity(0.3))
                }
                .overlay(alignment: .leading) {
                    DatePicker("", selection: $date, displayedComponents: .date)
                    .labelsHidden()
                    .colorMultiply(.clear)
                    .environment(\.locale, Locale(identifier: "ko_KR"))
                }
        }
    }
}

struct TimePickerView: View {
    @Binding var time: Date
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("시간")
                .font(.subheadline)
                .fontWeight(.medium)
            
            Text(timeForamt(time))
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray.opacity(0.3))
                }
                .overlay(alignment: .leading) {
                    DatePicker("", selection: $time, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .colorMultiply(.clear)
                        .environment(\.locale, Locale(identifier: "ko_KR"))
                }
        }
    }
}

struct MealEditorView: View {
    @Binding var mealText: String
    @FocusState.Binding var textEditorFocus: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("식사 내용")
                .font(.subheadline)
                .fontWeight(.medium)
            
            TextEditor(text: $mealText)
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray.opacity(0.3))
                        .overlay(alignment: .topLeading) {
                            if mealText.isEmpty && textEditorFocus == false {
                                Text("오늘 드신 음식을 적어주세요.")
                                    .foregroundStyle(.secondary)
                                    .padding()
                            }
                        }
                }
                .frame(height: 240)
                .focused($textEditorFocus)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
        }
        
    }
}

struct SubmitButton: View {
    var mealItem: Meal?
    @Binding var selectedMealType: MealType?
    @Binding var mealEditorText: String
    var date: Date
    var time: Date
    
    @State var showAlert = false
    @State var alertMessage = ""
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        Button {
            print("MealType : ", selectedMealType ?? "선택값 없음")
            print("MealEditorText : ", mealEditorText)
            print("Date : ", date)
            print("Time : ", time)
            
            guard let selectedMealType else {
                alertMessage = "식사 종류를 선택해주세요."
                print("here")
                showAlert.toggle()
                return
            }
            
            guard !mealEditorText.isEmpty else {
                alertMessage = "식사 내용을 입력해주세요."
                showAlert.toggle()
                return
            }
            
            modelContext.insert(
                Meal(
                    mealType: selectedMealType,
                    content: mealEditorText,
                    date: date,
                    time: time
                )
            )
            
            // TODO: 저장 실패했을 때 예외처리?
            try? modelContext.save()
            
//            dismiss()
            
        } label: {
            RoundedRectangle(cornerRadius: 16)
                .fill(.main)
                .frame(height: 56)
                .overlay {
                    Text("식단 \(mealItem == nil ? "등록" : "수정")하기")
                        .foregroundStyle(.white)
                        .bold()
                }
        }
        .alert("알림", isPresented: $showAlert) {
            Button("확인") {
                alertMessage = ""
            }
        } message: {
            Text(alertMessage)
                .frame(alignment: .center)
            
        }
        .padding(.bottom)
    }
}

func dateFormat(_ date: Date) -> String {
    let f = DateFormatter()
    f.locale = Locale(identifier: "ko_KR")
    f.dateFormat = "YYYY년 M월 d일"
    
    return f.string(from: date)
}

func timeForamt(_ time: Date) -> String {
    let f = DateFormatter()
    f.locale = Locale(identifier: "ko_KR")
    f.dateFormat = "a hh:mm"
    
    return f.string(from: time)
}
