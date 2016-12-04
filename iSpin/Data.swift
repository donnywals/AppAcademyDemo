//
//  Data.swift
//  iSpin
//
//  Created by Donny Wals on 04/12/2016.
//  Copyright © 2016 DonnyWals. All rights reserved.
//

import Foundation

extension Data {
    var hexString: String {
        return map { String(format: "%02.2hhx", arguments: [$0]) }.joined()
    }
}
