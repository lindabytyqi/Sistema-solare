import SwiftUI

struct InfoView: View {
    var body: some View {
        VStack {
            Text("Curiosità del giorno")
                .font(.largeTitle)
                .padding()
            
            Text("Qui apparirà la curiosità del giorno dal tuo file JSON.")
                .padding()
            
            Spacer()
        }
        .navigationTitle("Info del giorno")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
            }
        }
    }
}
