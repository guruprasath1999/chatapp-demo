//
//  ChatVC + Tableview.swift
//  ChatApplication
//
//  Created by NAM on 03/10/24.
//

import Foundation
import UIKit



extension ChatVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataViewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = dataViewModel.getCellViewModel( at: indexPath )
        if IndexPath(row: 0, section: 0) == indexPath {
            if message.createdAt != ""  {
            dateLbl.text = message.createdAt?.getFormattedString() ?? ""
            } else {
                dateView.isHidden = true
            }
        }
        switch dataViewModel.getMessageType(at: indexPath) {
        case .START_OF_CHAT:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatDateTableViewCell", for: indexPath) as! ChatDateTableViewCell
            cell.dateLbl.text = message.message
           
            return cell
        case .DATE:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatDateTableViewCell", for: indexPath) as! ChatDateTableViewCell
            cell.dateLbl.text = message.createdAt?.getFormattedString() ?? ""
            return cell
        case .TEXT:
            let cell = tableView.dequeueReusableCell(withIdentifier: MessageTextTVC.getIdentifier(isSender: true), for: indexPath) as! MessageTextTVC
            cell.configureCell(message: message, sessions: conversation)
            return cell
        case .IMAGE:
            let cell = tableView.dequeueReusableCell(withIdentifier: MessageImageTVC.getIdentifier(isSender: true), for: indexPath) as! MessageImageTVC
            cell.configureCell(message: message, sessions: conversation)
            cell.delegate = self
            return cell
        case .VIDEO:
            let cell = tableView.dequeueReusableCell(withIdentifier: MessageVideoTVC.getIdentifier(isSender: true), for: indexPath) as! MessageVideoTVC
            cell.delegate = self
            cell.configureCell(message: message, sessions: conversation)
            return cell
        case .DOCUMENT:
            let cell = tableView.dequeueReusableCell(withIdentifier: MessageDocumentTVC.getIdentifier(isSender: true), for: indexPath) as! MessageDocumentTVC
            cell.delegate = self
            cell.configureCell(message: message, sessions: conversation)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }

}

extension ChatVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let index = tableView.indexPathsForVisibleRows?.last {
            let message = dataViewModel.cellViewModels[index.row]
            if message.createdAt != ""  {
            dateLbl.text = message.createdAt?.getFormattedString() ?? ""
            } else {
                dateView.isHidden = true
            }
        }
    }
}


