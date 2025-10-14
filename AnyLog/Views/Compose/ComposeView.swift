//
//  ComposeView.swift
//  AnyLog
//
//  Created by 조영준 on 10/14/25.
//

import SwiftUI

struct ComposeView: View {
    var body: some View {
        
        VStack {
            // 식사 종류
            VStack{
                Text("식사 종류")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 6) {
                    Button {
                        
                    } label: {
                        Text("아침")
                    }
                    
                    Button {
                        
                    } label: {
                        Text("점심")
                    }
                    
                    Button {
                        
                    } label: {
                        Text("저녁")
                    }
                    
                    Button {
                        
                    } label: {
                        Text("간식")
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
        }
    }
}

#Preview {
    ComposeView()
}
