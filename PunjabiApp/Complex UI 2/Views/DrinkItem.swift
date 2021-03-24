//
//  DrinkItem.swift
//  CoffeeDBApp
//
//  Created by Brian Advent on 23.06.19.
//  Copyright © 2019 Brian Advent. All rights reserved.
//

import SwiftUI

struct DrinkItem : View {
    
    var drink:Drink
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            Image(drink.imageName)
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 170)
                .cornerRadius(10)
                .shadow(radius: 10)
            VStack(alignment: .leading, spacing: 5.0) {
                HStack {
                Text(drink.name)
                .foregroundColor(.primary)
                .font(.headline)
                    Text("price: $\(drink.price)").bold().font(.caption)
                    .fixedSize(horizontal: false, vertical: true)
                }
                Text(drink.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                    .frame(height: 40)
            }
            
        }
    }
}

#if DEBUG
struct DrinkItem_Previews : PreviewProvider {
    static var previews: some View {
        DrinkItem(drink: drinkData[0])
    }
}
#endif
