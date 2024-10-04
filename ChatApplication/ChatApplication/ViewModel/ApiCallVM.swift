//
//  ApiCallVM.swift
//  ChatApplication
//
//  Created by NAM on 04/10/24.
//

import UIKit
import Foundation

class ApiCallVM {
    
    var reloadTableView: (()->())?
    var cellViewModels = [UserModel]()
    var VC = UIViewController()
    
    func getData(){
        NetworkDataManager().callApi(url: "https://dummyjson.com/c/d901-c1f8-4931-b8b5", requestMethod: .get, parameters: [:], controller: VC as? BaseVC, completion: { (data) in

            if let data = data {
                do{

                    let decoder = JSONDecoder()
                    let dataModel = try decoder.decode(ApiResponseModel.self, from: data)
                    self.cellViewModels = dataModel.users ?? []
                    self.reloadTableView?()
                } catch let error{
                    print("Json failed to decode\(String(describing: error))")
                    return
                }
            }
        })
        
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> UserModel {
        return cellViewModels[indexPath.row]
    }
    
}

