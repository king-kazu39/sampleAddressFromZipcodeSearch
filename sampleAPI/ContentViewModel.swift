//
//  ContentViewModel.swift
//  sampleAPI
//
//  Created by kazuya on 2020/11/01.
//

import Foundation
import SwiftUI

class ContentViewModel: ObservableObject {
    var addressResponse = AddressResponse(results: [])
    @Published var addressString: String = ""
    @Published var addressArrayStrings: [String] = []
    @Published var isPresented: Bool = false
    
    /**
     https://qiita.com/shungo_m/items/64564fd822a7558ac7b1
     */
    func getAddress(_ value: String, updateUI: @escaping ()->Void){
        let task = URLSession.shared.dataTask(with: self.makeAPIRequest(value)) { (data, response, error) in
            guard let data = data else { return }
            do {
                self.addressResponse = try JSONDecoder().decode(AddressResponse.self, from: data)
                self.changeResponseValue { updateUI() }
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
    
    func makeAPIRequest(_ value: String) -> URLRequest {
        let url = URL(string: "https://zipcloud.ibsnet.co.jp/api/search")!
        
        let queryStringAddedURL = url.queryItemAdded(name: "zipcode", value: value)!
        
        var request = URLRequest(url: queryStringAddedURL)
        request.httpMethod = "GET"
        return request
    }
    
    func changeResponseValue(_ updateUI: @escaping ()->Void){
        if self.addressResponse.results.count > 1 {
            DispatchQueue.main.async {
                self.isPresented = true
                self.addressArrayStrings = self.makeAddressArrayString()
            }
        } else {
            DispatchQueue.main.async {
                self.addressString = self.makeAddressString() ?? ""
                updateUI()
            }
        }
    }
    
    func makeAddressArrayString() -> [String] {
        var addressStrings = [String]()
        for result in addressResponse.results {
            addressString = result.address1!
                          + result.address2!
                          + result.address3!
            addressStrings.append(addressString)
            addressString = ""
        }
        return addressStrings
    }
    
    func makeAddressString() -> String? {
        return self.addressResponse.results[0].address1!
             + self.addressResponse.results[0].address2!
             + self.addressResponse.results[0].address3!
    }
}

/**
 https://qiita.com/KosukeOhmura/items/8b65bdb63da6df95c7a3
 */
extension URL {
    func queryItemAdded(name: String, value: String?) -> URL? {
        return self.queryItemsAdded([URLQueryItem(name: name, value: value)])
    }
    
    func queryItemsAdded(_ queryItems: [URLQueryItem]) -> URL? {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: nil != self.baseURL) else {
            return nil
        }
        components.queryItems = queryItems + (components.queryItems ?? [])
        return components.url
    }
}
