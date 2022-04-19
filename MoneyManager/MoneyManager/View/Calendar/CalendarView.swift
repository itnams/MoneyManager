//
//  CalendarView.swift
//  MoneyManager
//
//  Created by ERM on 19/04/2022.
//

import SwiftUI

struct CalendarView: View{
    @State var currentDate = Date()
    let theme = ThemeColor.theme
    let size = ThemeSize.size
    let style = ThemeStyle.stype
    var body: some View{
        VStack(spacing: 0){
            CustomDatePicker(curentDate: $currentDate)
                .frame(height: size.heightCalendar)
                .background(
                    RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous)
                        .fill(theme.backgroundCalendar)
                )
            Spacer()
        }
        .padding([.horizontal,.top])
    }
}
