import SwiftUI

struct ContentView: View {
    @State private var score = 5.0
    @State private var isEditing = false
    @State private var date: Date = Date()
    @State private var inputPixelStory: String = ""
    
    var body: some View {
        VStack {
            Text("\(date, style: .date)")
                .font(.system(size: 30))
                .fontWeight(.semibold)
                .padding(.bottom, 130)
            
            Text("Score Your Pixel")
                .padding(.bottom, 20)
            
            Slider(value: $score, in: 0...10, step: 0.5) {
                Text("Title")
                } minimumValueLabel: {
                  Text("0")
                } maximumValueLabel: {
                  Text("10")
                } onEditingChanged: { editing in
                  isEditing = editing
                }
                .accentColor(.blue)
                .frame(width: 300)
            Text("\(String(format: "%.1f", score))")
                .foregroundColor(isEditing ? .gray : .black)
                .padding(.bottom, 50)
            
            TextField("Record Your Pixel With 10 Words...", text: $inputPixelStory)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .frame(maxWidth: 350)
                .padding(.bottom, 20)
            
            Button(action: {
                print("Your Pixel Is Saved")
                print(score)
                print(inputPixelStory)
            }) {
                Text("Save")
                    .foregroundColor(.blue)
            }
        }
    }
}
