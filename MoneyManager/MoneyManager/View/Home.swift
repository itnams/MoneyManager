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
    var body: some View{
        ZStack{
            if !animatedStates[1]{
                RoundedRectangle(cornerRadius: animatedStates[0] ? 30 : 0, style: .continuous)
                    .fill(Color.gray.opacity(0.4))
                    .matchedGeometryEffect(id: "DATEVIEW", in: animation)
                    .ignoresSafeArea()
            }
            if animatedStates[0]{
                VStack(spacing: 0){
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .fill(Color.gray.opacity(0.4))
                        .matchedGeometryEffect(id: "DATEVIEW", in: animation)
                        .frame(height: 290)
                }
                .padding([.horizontal,.top])
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
