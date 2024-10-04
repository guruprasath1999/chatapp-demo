//
//  OnboardVM.swift
//  ChatApplication
//
//  Created by NAM on 01/10/24.
//

import UIKit

class OnboardViewModel {
    
    var reloadTableView: (()->())?
    var cellViewModels = [Onboard]()
    var currentPage = 0
    
    func getData(){
        createCell()
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> Onboard {
        return cellViewModels[indexPath.row]
    }
    
    func createCell(){
        cellViewModels.removeAll()
        var vms = [Onboard]()
        vms.append(Onboard(title: "WELCOME", subtitle: "The world's fastest messaging app. It is free and secure.", image: UIImage(named: "onboard1") ?? UIImage()))
        vms.append(Onboard(title: "FAST", subtitle: "Chat App delivers messages faster than any other application.",  image: UIImage(named: "onboard2") ?? UIImage()))
        vms.append(Onboard(title: "Free", subtitle: "Chat App is free forever. No ads, No subscription fees.", image: UIImage(named: "onboard3") ?? UIImage()))
        cellViewModels = vms
        self.reloadTableView?()
    }
}

