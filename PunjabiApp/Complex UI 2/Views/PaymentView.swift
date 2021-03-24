//
//  PaymentView.swift
//  Complex UI 2
//
//  Created by Bharat Kumar on 8/27/20.
//  Copyright © 2020 Balaji. All rights reserved.
//

import SwiftUI

struct PaymentView: View {
    var body: some View {
        TypeCardScene(drink: drinkData[0], paymentContextDelegate: PaymentContextDelegate()).padding(.top, -2)
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView()
    }
}
