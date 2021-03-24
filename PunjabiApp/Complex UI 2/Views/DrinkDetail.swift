//
//  DrinkDetail.swift
//  CoffeeDBApp
//
//  Created by Brian Advent on 23.06.19.
//  Copyright © 2019 Brian Advent. All rights reserved.
//

import SwiftUI

struct DrinkDetail : View {
    
    var drink:Drink
    @EnvironmentObject var order: Order
    var body: some View {
        Home(drink: self.drink)
    }
}


struct OrderButton : View {
    var drink:Drink
    @EnvironmentObject var order: Order
    @State var isLoading = false
    var body: some View {
        
        VStack {
          
        Button(action: {
            
         
            self.order.add(item: self.drink)}) {
                
            Text("Order Now")
            }.frame(width: 200, height: 50)
            .foregroundColor(.white)
            .font(.headline)
        .background(Color.blue)
        .cornerRadius(10)
        
            if self.isLoading {
                LoadingView()
            }
        }
    }
}


#if DEBUG
struct DrinkDetail_Previews : PreviewProvider {
    var loginHome1: Login
    static var previews: some View {
        
        DrinkDetail(drink: drinkData[3])
            
    }
}
#endif
