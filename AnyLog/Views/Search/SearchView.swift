//
//  SearchView.swift
//  AnyLog
//
//  Created by 조영준 on 10/14/25.
//

import SwiftUI
import SwiftData

struct SearchView: View {
    @State var searchText: String = ""
    
    @Query(sort: [SortDescriptor(\Meal.date, order: .reverse)])
    var meals: [Meal]
    
    var body: some View {
        NavigationStack {
            List {
                Section("ㅇㅇ") {
                    Text("test")
                    Text("test")
                    Text("test")
                    Text("test")
                    Text("test")
                }
                
                Section("ㅇㅇ") {
                    Text("test")
                    Text("test")
                    Text("test")
                    Text("test")
                    Text("test")
                }
                
                Section("ㅇㅇ") {
                    Text("test")
                    Text("test")
                    Text("test")
                    Text("test")
                    Text("test")
                }
            }
        }
        .searchable(text: $searchText, prompt: "검색")
        
        
        
            
    }
}

#Preview {
    SearchView()
}
