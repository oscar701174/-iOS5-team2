
import SwiftUI
import SwiftData

struct ContentView: View {
  
    var body: some View {
        
        Text("Project for team2")
        Text("Logging of my daily meal")
    }
    
    }

   

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
