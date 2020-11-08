//
//  APIResponseEdit.swift
//  sampleAPI
//
//  Created by kazuya on 2020/11/07.
//

import Foundation

class APIResponseEdit {
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
    
    func conditionHandleDependsOnCount(count: Int) -> Bool {
        return count > 1 ? true : false
    }
    
    func passValueToMainthread(_ updateUI: @escaping () -> Void) {
        DispatchQueue.main.async {
            updateUI()
        }
    }
    
    func methodHandler(_ condition: Bool, handle: @escaping () -> Void) {
        if condition {
            handle()
            return
        }
    }
    
}
