//
//  Home.swift
//  MoneyManager
//
//  Created by ERM on 12/04/2022.
//

import Foundation
import SwiftUI

struct Home: View{
    @State var animatedStates: [Bool] = Array(repeating: false, count: 3)
    @Namespace var animation
    @State var selection = 0
    
    var body: some View{
        ZStack(alignment: .top){
            if !animatedStates[1]{
                RoundedRectangle(cornerRadius: animatedStates[0] ? 30 : 0, style: .continuous)
                    .fill(Color.gray.opacity(0.4))
                    .ignoresSafeArea()
            }
            if animatedStates[0]{
                TabView(selection: $selection) {
                    CalendarView().tabItem {
                        Image(systemName: "calendar")
                        Text("Calendar")
                    }.tag(0).clipped()
                    InputView().tabItem {
                        Image(systemName: "pencil")
                        Text("Input")
                    }.tag(1).clipped()
                    StatisticsView().tabItem {
                        Image(systemName: "chart.xyaxis.line")
                        Text("Statistics")
                    }.tag(2).clipped()
                    MoreView().tabItem {
                        Image(systemName: "gearshape")
                        Text("Calendar")
                    }.tag(3).clipped()
                }
                
            }
        }
        .onAppear(perform: startAnimation)
    }
    func startAnimation(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            withAnimation(.interactiveSpring(response: 0.8,dampingFraction: 0.7,blendDuration: 0.7)){
                animatedStates[0] = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                animatedStates[1] = true
            }
        }
    }
}




