//
//  TypeYourCardScene.swift
//  TypeYourCard
//
//  Created by alexej_ne on 24.06.2019.
//  Copyright © 2019 Alexej Nenastev. All rights reserved.
//

import SwiftUI
import Stripe
import Alamofire
import SimpleCCForm
extension PayCardField {
  
    var isFirstInput: Bool {
        self == PayCardField.allCases.first
    }
    
    var isLastInput: Bool {
        self == PayCardField.allCases.last
    }
    
    var buttonTitle: String {
        isLastInput ? "DONE" : "Next"
    }
    
    var nextForInput: PayCardField? {
        PayCardField.allCases.after(self)
    }
    
    var prevForInput: PayCardField? {
        PayCardField.allCases.before(self)
    }
    
}

struct TypeCardScene : View {
      @EnvironmentObject var order: Order
        var drink:Drink
    @ObservedObject var paymentContextDelegate: PaymentContextDelegate
    let config = STPPaymentConfiguration.shared()
    @State private var paymentContext: STPPaymentContext!
    @ObservedObject var environment = TypeCardEnvironment()
  @State var simpleForm = SimpleCCForm()
    private var textFieldBinding: Binding<String> {
        switch environment.currentInputField {
        case .number: return $environment.number
        case .holder: return $environment.holderName
        case .cvv: return $environment.cvv
        case .validThru: return $environment.validThru
        }
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
     
            HStack {
                Text("Type in you card details:")
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                Spacer()
            }
            VStack(alignment: .trailing, spacing: 8) {
                PayCardFieldInputView(field: environment.currentInputField,
                                      binding: textFieldBinding,
                                      isFirstResponder: true)
                    .transition(.slideRightToLeft)
                HStack {
                    Button(action: goNext) {  ActionButton(title: self.paymentContextDelegate.paymentMethodButtonTitle) }
                    
                    if self.paymentContextDelegate.paymentMethodButtonTitle != "Select Payment Method" {
                              Button(action: {
                                  
                                  self.paymentContext.requestPayment()
                              }) {
                                  Text("Pay Now").frame(width: UIScreen.main.bounds.width - 30, height: 50)
                              }.foregroundColor(.white).background(Color.red).cornerRadius(10).padding(.top, 15)
                              }
                              
                              Spacer()
                
                }
            }
            Spacer()
        }.padding(20)
            .preferredColorScheme(.dark)
        .environmentObject(environment).onAppear {
                self.environment.clear()
        }
        .onAppear {
         
          
         
            self.paymentContextConfiguration()
        
            
        }
        
    }
    
    private func goNext() {
self.paymentContext.presentPaymentOptionsViewController()
        
    }
    
    func paymentContextConfiguration() {
         let customerContext = STPCustomerContext(keyProvider: MyAPIClient())
         self.config.shippingType = .shipping
         self.config.requiredBillingAddressFields = .full
         
         self.config.requiredShippingAddressFields = [.postalAddress, .emailAddress]
         
         self.config.companyName = "Testing"
         
         self.paymentContext = STPPaymentContext(customerContext: customerContext, configuration: self.config, theme: .default())
         
         self.paymentContext.delegate = self.paymentContextDelegate
         
         let keyWindow = UIApplication.shared.connectedScenes
                         .filter({$0.activationState == .foregroundActive})
                         .map({$0 as? UIWindowScene})
                         .compactMap({$0})
                         .first?.windows
             .filter({$0.isKeyWindow}).first
         
         self.paymentContext.hostViewController = keyWindow?.rootViewController
        self.paymentContext.paymentAmount = self.drink.price
     }
}


#if DEBUG
struct TypeYourCardScene_Previews : PreviewProvider {
    static var environment:  TypeCardEnvironment {
        let env = TypeCardEnvironment()
        env.number = "4124"
        return env
    }
    
    
    static var previews: some View {
        TypeCardScene(drink:  drinkData[0], paymentContextDelegate: PaymentContextDelegate(), environment: environment)
            .padding(20)
    }
}
#endif
