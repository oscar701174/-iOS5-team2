

import SwiftUI
import SwiftData


struct ComposeView: View {
    @State private var selectedMealType: MealType?
    @State private var date = Date.now
    @State private var time = Date.now
    @State private var mealEditorText = ""
    
    @FocusState var textEditorFocus
    
    @Environment(\.modelContext) var modelContext
    
    

    var body: some View {
        VStack(spacing: 36) {
            Text("등록 페이지") // TODO: 페이지 타입에 따라 대응하기
                .font(.title2)
                .bold()
            
            MealTypeButtonView(selectedMealType: $selectedMealType)
            
            DatePickerView(date: $date)
            
            TimePickerView(time: $time)
            
            MealEditorView(mealText: $mealEditorText, textEditorFocus: $textEditorFocus)
            
            SubmitButton()
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
        
        
    }
}

#Preview {
    ComposeView()
}


struct MealTypeButton: View {
    let mealType: MealType
    @Binding var selectedMealType: MealType?
    
    var body: some View {
        if selectedMealType == mealType {
            Button(mealType.rawValue) {
                selectedMealType = mealType
            }
            .buttonStyle(.borderedProminent)
            .tint(.main)
        } else {
            Button(mealType.rawValue) {
                selectedMealType = mealType
            }
            .buttonStyle(.bordered)
            .tint(.main)
        }
    }

}

struct MealTypeButtonView: View {
    @Binding var selectedMealType: MealType?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("식사 종류")
                .font(.subheadline)
                .fontWeight(.medium)
            
            HStack(spacing: 12) {
                ForEach(MealType.allCases) { mealType in
                    MealTypeButton(mealType: mealType, selectedMealType: $selectedMealType)
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
            Text("식사 내용") // TODO: 페이지 타입에 따라 대응하기
                .font(.subheadline)
                .fontWeight(.medium)
            
            TextEditor(text: $mealText)
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray.opacity(0.3))
                        .overlay(alignment: .topLeading) {
                            if !mealText.isEmpty || textEditorFocus == false {
                                Text("오늘 드신 음식을 적어주세요.")
                                    .foregroundStyle(.secondary)
                                    .padding()
                            }
                        }
                }
                .focused($textEditorFocus)
            
                
        }
        
    }
}

struct SubmitButton: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button {
            dismiss()
        } label: {
            RoundedRectangle(cornerRadius: 16)
                .fill(.main)
                .frame(width: .infinity, height: 56)
                .overlay {
                    Text("식단 등록하기")
                        .foregroundStyle(.white)
                        .bold()
                }
        }

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


// 1. 아침, 점심, 저녁 1회만 등록 가능하게
// 2. 식단 등록하기 > 얼럿창 등록 > 목록이동?
