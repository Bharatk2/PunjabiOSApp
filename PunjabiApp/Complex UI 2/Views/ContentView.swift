//
//  ContentView.swift
//  Complex UI 2
//
//  Created by Balaji on 02/05/20.
//  Copyright © 2020 Balaji. All rights reserved.
//

import SwiftUI
import FirebaseFirestore

struct Home : View {
    
    @EnvironmentObject var order: Order
    var drink:Drink
    var totalPrice: Double {
        let total = Double(drink.price)
        let tipValue = total / 100 *
            Double(Self.tipAmounts[tipAmount])
        return total + tipValue
    }
    static let tipAmounts = [10, 20, 0]
    @State private var tipAmount = 1
    @State var count = 0
    @State var height = UIScreen.main.bounds.height
    @State var isLoading = false
    @State var notLoading = false 
    var body: some View{
        
        ZStack{
            
            Color("Color").edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0){
                
                Image(drink.imageName)
                    .resizable()
                
                ZStack(alignment: .topTrailing) {
                    
                    if self.height > 750 {
                        
                        VStack{
                            
                            HStack{
                                
                                Text("\(drink.name)")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                
                                Spacer()
                                
                            }.padding(.top, 25)
                            
                            HStack{
                                
                                VStack(alignment: .leading, spacing: 15) {
                                    
                                    Text(drink.description)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                        .lineLimit(3)
                                    HStack(spacing: 15){
                                        
                                        Image(systemName: "star")
                                        
                                        Text("4.5")
                                    }
                                    .foregroundColor(.gray)
                                    
                                    HStack(spacing: 15){
                                        
                                        Image(systemName: "icon_tray")
                                        
                                        Text("Tip:")
                                    }
                                    .foregroundColor(.gray)
                                }
                                
                                Spacer()
                            }
                            .padding(.top)
                            
                            HStack(spacing: 18){
                                
                                VStack{
                                    
                                    Text("\(Home.tipAmounts[0])%")
                                    Text("\(Home.tipAmounts[0])%")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 4)
                                
                                VStack{
                                    
                                    Text("\(Home.tipAmounts[1])%")
                                    Text("\(Home.tipAmounts[1])%")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 4)
                                
                                VStack{
                                    
                                    Text("\(Home.tipAmounts[2])%")
                                    Text("\(Home.tipAmounts[2])%")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 4)
                            }
                            .padding(.top)
                            
                            Text("Options")
                                .fontWeight(.bold)
                                .foregroundColor(Color("Color"))
                                .padding(.top)
                            
                            
                            HStack(spacing: 18){
                                
                                Button(action: {
                                    
                                }) {
                                    
                                    VStack{
                                        
                                        Text("Basic")
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 4)
                                }
                                .foregroundColor(.black)
                                
                                Button(action: {
                                    
                                }) {
                                    
                                    VStack{
                                        
                                        Text("Spicy")
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 4)
                                }
                                .foregroundColor(.black)
                                
                            }
                            .padding(.top)
                            
                            Button(action: {
                                
                            }) {
                                
                                Image(systemName: "info")
                                    .foregroundColor(.black)
                                    .padding()
                            }
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                            .padding(.top)
                            
                        }
                        .padding(.bottom, 40)
                        .padding(.horizontal,20)
                        .background(CustomShape().fill(Color.white))
                        .clipShape(Corners())
                    }
                        
                    else{
                        
                        ScrollView(.vertical, showsIndicators: false, content: {
                            
                            VStack{
                                
                                HStack{
                                    
                                    Text(drink.name)
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                    
                                    Spacer()
                                    
                                }.padding(.top, 25)
                                
                                HStack{
                                    
                                    VStack(alignment: .leading, spacing: 15) {
                                        
                                        Text(drink.description)
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                        
                                        HStack(spacing: 15){
                                            
                                            Image(systemName: "star")
                                            
                                            Text("4.5")
                                        }
                                        .foregroundColor(.gray)
                                        
                                        HStack(spacing: 15){
                                            
                                            Image(systemName: "icon_tray")
                                            
                                            Text("Tip:")
                                        }
                                        .foregroundColor(.gray)
                                    }
                                    
                                    Spacer()
                                }
                                .padding(.top)
                                
                                HStack(spacing: 18){
                                    
                                    VStack{
                                        Button(action: {
                                            
                                        }) {
                                            Text("\(Home.tipAmounts[0])")
                                            Text("\(Home.tipAmounts[0])%")
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                                .multilineTextAlignment(.center)
                                        }
                                        
                                        
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 4)
                                    
                                    VStack{
                                        Button(action: {
                                            
                                        }) {
                                        Text("\(Home.tipAmounts[0])")
                                        Text("\(Home.tipAmounts[1])%")
                                            .font(.callout)
                                            .foregroundColor(.gray)
                                        }
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 4)
                                    
                                    VStack{
                                        
                                        Button(action: {
                                            
                                        }) {
                                            Text("\(Home.tipAmounts[0])")
                                            Text("\(Home.tipAmounts[2])%")
                                                .font(.callout)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 4)
                                }
                                .padding(.top)
                                
                                Text("Options")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("Color"))
                                    .padding(.top)
                                
                                
                                HStack(spacing: 18){
                                    
                                    Button(action: {
                                        
                                    }) {
                                        
                                        VStack{
                                            
                                            Text("Basic")
                                        }
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .shadow(radius: 4)
                                    }
                                    .foregroundColor(.black)
                                    
                                    Button(action: {
                                        
                                    }) {
                                        
                                        VStack{
                                            
                                            Text("Spicy")
                                        }
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .shadow(radius: 4)
                                    }
                                    .foregroundColor(.black)
                                    
                                }
                                .padding(.top)
                                
                                Button(action: {
                                    
                                }) {
                                    
                                    Image(systemName: "info")
                                        .foregroundColor(.black)
                                        .padding()
                                }
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                                .padding(.top)
                                
                            }
                        })
                            .padding(.bottom, 40)
                            .padding(.horizontal,20)
                            .background(CustomShape().fill(Color.white))
                            .clipShape(Corners())
                    }
                    
                    VStack(spacing : 15){
                        
                        Button(action: {
                            
                            self.count += 1
                            
                        }) {
                            
                            Image(systemName: "plus.circle")
                                .foregroundColor(.gray)
                                .font(.title)
                        }
                        
                        Text("\(self.count)")
                            .foregroundColor(.yellow)
                            .padding(10)
                            .background(Color.black)
                            .clipShape(Circle())
                        
                        Button(action: {
                            
                            if self.count != 0{
                                
                                self.count -= 1
                            }
                            
                        }) {
                            
                            Image(systemName: "minus.circle")
                                .foregroundColor(.gray)
                                .font(.title)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 4)
                    .padding(.trailing,25)
                    .offset(y: -55)
                }
                .zIndex(40)
                .offset(y: -40)
                .padding(.bottom, -40)
                
                HStack{
                    
                    VStack(alignment: .leading, spacing: 15) {
                        
                        Text("Total Order")
                            .fontWeight(.bold)
                        
                        HStack(spacing : 18){
                            
                            VStack(spacing: 8){
                                
                                Text("\(self.count)")
                                    .fontWeight(.bold)
                                
                                Text("Total Order")
                            }
                            
                            VStack(spacing: 8){
                                
                                Text("$\(self.count * self.drink.price)")
                                    .fontWeight(.bold)
                                
                                Text("Total Price")
                            }
                        }
                    }
                    .foregroundColor(.white)
                    .padding(.leading, 20)
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        if self.count == 0 {
                            self.notLoading = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.notLoading = false
                            }
                        } else {
                        self.isLoading = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.isLoading = false
                        }
                            self.order.add(item: self.drink)
                            let db = Firestore.firestore()
                            db.collection("cart")
                                .document()
                                .setData(["item": self.drink.name, "quantity": self.count, "price": self.count * self.drink.price]) { (error) in
                                    if error != nil {
                                        print((error?.localizedDescription ?? ""))
                                        return
                                    }
                            }
                        }
                 
    
                    }) {
                        
                        VStack{
                            
                            Text("Add")
                                .fontWeight(.bold)
                            Text("To")
                            .fontWeight(.bold)
                            Text("Tray")
                                .fontWeight(.bold)
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 25)
                        .padding(.vertical, 25)
                        .background(Color.yellow)
                        .cornerRadius(15)
                        .shadow(radius: 4)
                    }
                    .padding(.trailing, 25)
                    .offset(y: -55)
                }
                .zIndex(40)
                .padding(.bottom, 10)
                
            }
            .edgesIgnoringSafeArea(.top)
            .animation(.default)
            if self.notLoading {
                CancelView()
            }
            if self.isLoading {
                CheckmarkView()
            }
        }
    }
}



struct CustomShape : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        return Path{path in
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height - 40))
            
        }
    }
}

struct Corners : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 35, height: 35))
        
        return Path(path.cgPath)
    }
}

class Host: UIHostingController<HomeView> {
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        
        return .lightContent
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool{
        
        return true
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
