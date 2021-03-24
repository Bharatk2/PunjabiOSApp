//
//  InitialView.swift
//  Complex UI 2
//
//  Created by Bharat Kumar on 9/10/20.
//  Copyright © 2020 Balaji. All rights reserved.
//


import SwiftUI

struct InitialView: View {
    
    @ObservedObject var paymentContextDelegate = PaymentContextDelegate()
      func listen() {
       
        //MARK: - uncomment the line below to test as a brand new user
     //   UserDefaults.standard.set(nil, forKey: "Customer")
        
        //MARK: - Check to see if there is a registered user or not
       
          
      }
      
      var body: some View {
         NavigationView {

              
                //MARK: - if the user is registered then proceed to the shopping/checkout page
                ShoppingView(paymentContextDelegate: self.paymentContextDelegate)
          

  
        }
      }
}

struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}

