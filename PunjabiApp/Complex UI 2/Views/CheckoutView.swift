//
//  CheckoutView.swift
//  iDine
//
//  Created by Bharat Kumar on 8/2/20.
//  Copyright © 2020 Bharat Kumar. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    var totalPrice: Double {
        let total = Double(order.total)
        let tipValue = total / 100 *
            Double(Self.tipAmounts[tipAmount])
        return total + tipValue
    }
    @State private var showingPaymentAlert = false
    static let tipAmounts = [10, 15, 20, 25, 0]
    @State private var tipAmount = 1
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumber = ""
    @State var areYouGoingToSecondView: Bool
    @EnvironmentObject var order: Order
    @State private var paymentType = 0
    static let paymentTypes = ["Cash", "Credit Card", "Punjabi Points"]
    var body: some View {
        Form {
            NavigationLink(destination: PaymentView(), isActive: $areYouGoingToSecondView) { EmptyView() }
            Toggle(isOn: $addLoyaltyDetails.animation()) {
                Text("Add Punjabi loyal card")
            }
            if addLoyaltyDetails {
                TextField("Enter your Punjabi ID", text: $loyaltyNumber)
            }
            Section {
                Picker("Comó lo quiere pagar?", selection: $paymentType) {
                    ForEach(0 ..< Self.paymentTypes.count, id: \.self) {
                        Text(Self.paymentTypes[$0])
                    }
                }
            }
            Section(header: Text("Add a tip?")) {
                Picker("Percentage:", selection: $tipAmount) {
                    ForEach(0 ..< Self.tipAmounts.count) {
                        Text("\(Self.tipAmounts[$0])%")
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("TOTAL: $\(totalPrice, specifier: "%.2f")")
                .font(.largeTitle)
            ) {
                
                Button(action: {
                    self.areYouGoingToSecondView = true
                }) {
                    Text("Confirm Order")
                }
               
            }
        }
        .navigationBarTitle(Text("Payment"), displayMode: .inline)
        .alert(isPresented: $showingPaymentAlert) {
            Alert(title: Text("Order confirmed"), message: Text("Your total was $\(totalPrice, specifier: "%2f")- Thank you!"), dismissButton: .default(Text("OK")))
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static let order = Order()
    static var previews: some View {
        CheckoutView(areYouGoingToSecondView: false).environmentObject(order)
    }
}
