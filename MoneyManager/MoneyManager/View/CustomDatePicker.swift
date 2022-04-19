//
//  CustomDatePicker.swift
//  MoneyManager
//
//  Created by ERM on 13/04/2022.
//

import SwiftUI

struct CustomDatePicker: View {
    @Binding var curentDate: Date
    @State var currentMonth: Int = 0
    @State var animatedStates: [Bool] = Array(repeating: false, count: 2)
    var body: some View {
        VStack(spacing: 30){
            HStack(alignment: .center,spacing: 20){
                Button {
                    curentDate = Date()
                    currentMonth = 0
                } label: {
                    Text("To day")
                }
                Spacer()
                HStack{
                    Button {
                        currentMonth -= 1
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                    }
                    Text(extracDate()[0] + " " + extracDate()[1])
                        .font(.callout)
                        .fontWeight(.semibold)
                    Button {
                        currentMonth += 1
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(.title2)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 16)
            .foregroundColor(Color.white)
            .frame(height: 40)
            Rectangle()
                .fill(.white.opacity(0.4))
                .frame(width: animatedStates[0] ? nil : 0,height: 1)
                .frame(maxWidth:.infinity, alignment: .leading)
            let colums = Array(repeating: GridItem(.flexible()), count: 7)
            VStack{
                LazyVGrid(columns: colums, spacing: 8) {
                    ForEach(extractDate()){ value in
                        CardView(value: value)
                            .background(
                                Capsule()
                                    .fill(Color.gray)
                                    .padding(.horizontal,8)
                                    .opacity(isSameDay(date1: value.date, date2: curentDate) ? 1 : 0 )
                            )
                            .onTapGesture {
                                curentDate = value.date
                            }
                    }
                }
                Spacer()
            }
            .frame(height: .infinity)
        }
        .onChange(of: currentMonth) { newValue in
            curentDate = getCurrentMonth()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                withAnimation(.easeInOut(duration: 0.3)){
                    animatedStates[0] = true
                }
            }
        }
    }
    
    @ViewBuilder
    func CardView(value: DateValue) -> some View{
        VStack{
            if value.day != -1 {
                Text("\(value.day)")
                    .font(.title3.bold())
                    .foregroundColor(isSameDay(date1: value.date, date2: curentDate) ? Color.white : Color.primary)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical,8)
        .frame(height: 40,alignment: .top)
    }
    
    func isSameDay(date1: Date, date2: Date) -> Bool{
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    func extracDate() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        let date = formatter.string(from: curentDate)
        return date.components(separatedBy: " ")
    }
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date())
        else {
            return Date()
        }
        return currentMonth
    }
    
    func extractDate() -> [DateValue] {
        let calendar = Calendar.current
        let currentMonth = getCurrentMonth()
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
        }
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        for _ in 0..<firstWeekday - 1  {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        return days
    }
}

extension Date {
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: self)!
        return range.compactMap{ day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}
