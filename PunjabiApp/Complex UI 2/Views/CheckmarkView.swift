//
//  CheckmarkView.swift
//  Complex UI 2
//
//  Created by Bharat Kumar on 8/26/20.
//  Copyright © 2020 Balaji. All rights reserved.
//

import SwiftUI

struct CheckmarkView: View {
    var body: some View {
        VStack {
            LottieView(filename: "done")
                
                .frame(width: 200, height: 200, alignment: .center )
                .offset(x: 1, y: -100)
        }
    }
}

struct CheckmarkView_Previews: PreviewProvider {
    static var previews: some View {
        CheckmarkView()
    }
}
