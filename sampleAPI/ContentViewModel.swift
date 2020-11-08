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
    @Published var alertStruct: AlertStruct = AlertStruct(showAlert: false,
                                                          alertMsg: "",
                                                          alertTitle: "")
    
    struct AlertStruct {
        var showAlert: Bool
        var alertMsg: String
        var alertTitle: String
    }
    
    /**
     https://qiita.com/shungo_m/items/64564fd822a7558ac7b1
     */
    func getAddress(_ value: String, updateUI: @escaping ()->Void){
        let task = URLSession.shared.dataTask(with: self.makeAPIRequest(value)) { (data, response, error) in
            guard let data = data else { return }
            do {
                self.addressResponse = try JSONDecoder().decode(AddressResponse.self, from: data)
                self.changeResponseValue(self.addressResponse.results?.count ?? 0,
                                         self.addressResponse.message ?? "") { updateUI() }
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
    
    func changeResponseValue(_ count: Int, _ message: String, _ updateUI: @escaping ()->Void) {
        switch count {
        case 1:
            DispatchQueue.main.async {
                self.addressString = APIResponseEdit.makeAddressString(self.addressResponse.results ?? []) ?? ""
                updateUI()
            }
        case 0:
            if message != "" {
                DispatchQueue.main.async {
                    self.alertStruct = AlertStruct(showAlert: true,
                                                   alertMsg: message,
                                                   alertTitle: "警告")
                }
                return
            }
            DispatchQueue.main.async {
                self.alertStruct = AlertStruct(showAlert: true,
                                               alertMsg: "検索結果が見つかりませんでした",
                                               alertTitle: "結果")
            }
        default:
            DispatchQueue.main.async {
                self.isPresented = true
                self.addressArrayStrings = APIResponseEdit.makeAddressArrayString(self.addressResponse.results ?? [])
            }
        }
    }
    
}
