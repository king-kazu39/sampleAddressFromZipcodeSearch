//
//  AddressResponse.swift
//  sampleAPI
//
//  Created by kazuya on 2020/11/01.
//

import Foundation

struct AddressResponse: Decodable {
    var message: String?
    var results: [Result]?
}

struct Result: Decodable {
    var address1: String?
    var address2: String?
    var address3:String?
    var kana1: String?
    var kana2: String?
    var kana3: String?
    var prefcode: String?
    var zipcode: String?
}
