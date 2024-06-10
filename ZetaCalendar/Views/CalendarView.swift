import SwiftUI

struct CalendarView: View {
    @State private var color: Color = .blue
    @Binding var date: Date //= Date.now
    let daysOfWeek = Date.capitalizedFirstLettersOfWeekdays
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    @State private var days: [Date] = []
    var body: some View {
                VStack {
                    LabeledContent("Date/Time") {
                        DatePicker("", selection: $date)
                    }
                    HStack {
                        ForEach(daysOfWeek.indices, id: \.self) { index in
                            Text(daysOfWeek[index])
                                .fontWeight(.black)
                                .foregroundStyle(color)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    LazyVGrid(columns: columns) {
                        ForEach(days, id: \.self) { day in
                            if day.monthInt != date.monthInt {
                                Text("")
                            } else {
                                Text(day.formatted(.dateTime.day()))
                                    .fontWeight(.bold)
                                    .foregroundStyle(.secondary)
                                    .frame(maxWidth: .infinity, minHeight: 40)
                                    .background(
                                        Circle()
                                            .foregroundStyle(
                                                Date.now.startOfDay == day.startOfDay
                                                ? .red.opacity(0.3)
                                                :  color.opacity(0.3)
                                            )
                                    )
                                    .onTapGesture {
                                        print("test")
                                    }
                            }
                        }
                    }
                }
                .padding()
            .onAppear {
                days = date.calendarDisplayDays
            }
            .onChange(of: date) {
                print(date)
                days = date.calendarDisplayDays
            }
    }
    
}

#Preview {
    CalendarView(date: .constant(.now))
}
