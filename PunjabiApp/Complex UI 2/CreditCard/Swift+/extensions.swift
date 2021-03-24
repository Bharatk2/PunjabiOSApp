//
//  extensions.swift
//  Complex UI 2
//
//  Created by Bharat Kumar on 9/10/20.
//  Copyright © 2020 Balaji. All rights reserved.
//

import Foundation


extension String {
    public func toPhoneNumber() -> String {
        return self.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "($1) $2-$3", options: .regularExpression, range: nil)
    }
}


