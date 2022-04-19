//
//  Theme.swift
//  MoneyManager
//
//  Created by ERM on 19/04/2022.
//

import Foundation
import SwiftUI

public final class ThemeColor{
    public static let theme = ThemeColor()
    public let backgroundColor: Color = .white
    public let backgroundCalendar: Color = .gray.opacity(0.4)
}

public final class ThemeSize{
    public static let size = ThemeSize()

    public let heightCalendar: CGFloat = 400
}

public final class ThemeStyle{
    public static let stype = ThemeStyle()

    public let cornerRadius: CGFloat = 30
}
