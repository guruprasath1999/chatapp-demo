//
//  NetworkDataManager.swift
//  ChatApplication
//
//  Created by NAM on 04/10/24.
//

import Foundation
import UIKit

class NetworkDataManager {
    static let shared = NetworkDataManager()
    
    func callApi(url: String,requestMethod: Request_Method, parameters: [String : Any]?, controller: BaseVC?, completion: @escaping (_ data: Data?) -> Void) {
        
        guard let url = URL(string: url ) else{
            completion(nil)
            return
        }
        
        print(url)
        
        var request =  URLRequest(url: url)
        request.httpMethod = requestMethod.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if let parameters = parameters, requestMethod != .get && requestMethod != .delete {
            print("*******************")
            print(parameters)
            print("*******************")
            request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        }
        
        controller?.showLoader()
        URLSession.shared.dataTask(with: request) { data, response, error in
            //            controller?.stopLoader()
            DispatchQueue.main.async {
                controller?.stopLoader()
                if let error = error {
                    if let controller = controller {
                        Utils.showAlert(title: "", message: error.localizedDescription, viewController: controller)
                    }
                } else if let data = data {
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print(json)

                        let decoder = JSONDecoder()
                        let dataModel = try decoder.decode(ResponseBaseModel.self, from: data)

                        if dataModel.code == 401 {
                            Utils.setRootController(rootVCType: .loginVC)
                        }
                    } catch let error {
                        print("Json failed to decode\(String(describing: error))")
                    }
                    
                    completion(data)
                }
            }
        }.resume()
    }
    
}
