//
//  ContentView.swift
//  CoffeeDBApp
//
//  Created by Brian Advent on 23.06.19.
//  Copyright © 2019 Brian Advent. All rights reserved.
//

import SwiftUI

struct HomeView : View {
    

    var body: some View {
        HomeBackground()
            .preferredColorScheme(.dark)
    }
}

#if DEBUG
struct HomeView_Previews : PreviewProvider {
    var loginHome1: Login
    static var previews: some View {
        HomeView()
        
    }
}

struct HomeBackground: View {
    @State var isLoading = false
    var categories:[String:[Drink]] {
        .init(
            grouping: drinkData,
            by: {$0.category.rawValue }
            
        )
        
    }
    
    var body: some View{
        
        GeometryReader {_ in
            NavigationView {
                    
                    List (self.categories.keys.sorted(), id:\.self) {key in
                        DrinkRow(categoryName: "\(key)".uppercased(), drinks: self.categories[key]!)
                            .frame(height: 306.0)
                            
                            .padding(.bottom)
                    }
                    
                    
            }
            if self.isLoading {
                LoadingView()
            }
        }
  
        .background(Color(.black).edgesIgnoringSafeArea(.all))
    }
}

extension HomeView {
    func addLogoToNavigationBarItem() {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Punjabi")
        //imageView.backgroundColor = .lightGray
        
        // In order to center the title view image no matter what buttons there are, do not set the
        // image view as title view, because it doesn't work. If there is only one button, the image
        // will not be aligned. Instead, a content view is set as title view, then the image view is
        // added as child of the content view. Finally, using constraints the image view is aligned
        // inside its parent.
        let contentView = UIView()
        
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
}
#endif


