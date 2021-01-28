//
//  AddressHelper.swift
//  sampleAPI
//
//  Created by kazuya on 2020/11/07.
//

import Foundation

class AddressHelper {
    static func makeAddressArrayString(_ arrayAddress: [Result]) -> [String] {
        var addressStrings = [String]()
        for result in arrayAddress {
        var addressString = result.address1!
                          + result.address2!
                          + result.address3!
            addressStrings.append(addressString)
            addressString = ""
        }
        return addressStrings
    }
    
    static func makeAddressString(_ arrayAddress: [Result]) -> String? {
        return arrayAddress[0].address1!
             + arrayAddress[0].address2!
             + arrayAddress[0].address3!
    }
    
    
}
