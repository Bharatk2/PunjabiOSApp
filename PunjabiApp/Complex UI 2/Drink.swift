//
//  Drink.swift
//  CoffeeDBApp
//
//  Created by Brian Advent on 23.06.19.
//  Copyright © 2019 Brian Advent. All rights reserved.
//

import SwiftUI

struct Drink: Hashable, Codable, Equatable, Identifiable {
    var id:Int
    var name:String
    var price:Int
    var imageName:String
    var category:Category
    var description:String
    
    enum Category: String, CaseIterable, Codable, Hashable {
        case vegeterian = "vegeterian"
        case nonvegeterian = "non-vegeterian"
        case appetizers = "appetizers"
        case drinks = "drinks"
    }
    
}
