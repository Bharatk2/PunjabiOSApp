//
//  AppView.swift
//  iDine
//
//  Created by Bharat Kumar on 8/2/20.
//  Copyright © 2020 Bharat Kumar. All rights reserved.
//

import SwiftUI


struct AppView: View {
    
    @EnvironmentObject var order: Order
    @State private var badgeCount: Int = 1
    private var badgePosition: CGFloat = 2
    private var tabsCount: CGFloat = 3
    
    init() {
           UIView.appearance().backgroundColor = UIColor(named: "backgroundColor")
       }
    var body: some View {
        GeometryReader { geometry in
           
                TabView {
                    HomeView()
                        .tabItem {
                            Image(systemName: "list.dash")
                            Text("Menu")
                    }
                    
                    OrderView()
                        .tabItem {
                            Image(systemName: "square.and.pencil")
                            Text("Order")
                    }
                
                }
            
            
            ZStack {
                             Circle()
                               .foregroundColor(.red)

                               Text("\(self.order.items.count)")
                               .foregroundColor(.white)
                               .font(Font.system(size: 12))
                           }
                           .frame(width: 15, height: 15)
            .offset(x: ( ( 2 * self.badgePosition) - -0.45) * ( geometry.size.width / ( 2 * self.tabsCount ) ) + 2, y: 685)
                           .opacity(self.order.items.count == 0 ? 0 : 1.0)

        }
        .preferredColorScheme(.dark)
        .background(Color("BlackColor").edgesIgnoringSafeArea(.all))
    }
}

struct AppView_Previews: PreviewProvider {
    static let order = Order()
    static var previews: some View {
        
        AppView().environmentObject(order)
    }
}


