import SwiftUI

struct CalendarView: View {
    @State private var date = Date()
    
    var body: some View {
        NavigationStack {
            VStack {
                DatePicker("Date", selection: $date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                
                NavigationLink(destination: DayRatingView(selectedDate: date)) {
                    Text("Go to your pixel of")
                        .foregroundColor(.black)
                    Text("\(date, style: .date)")
                        .foregroundColor(.blue)
                }
                
            }
        }
    }
}

#Preview {
    CalendarView()
}
