//
//  Enumeration.swift
//  ChatApplication
//
//  Created by NAM on 01/10/24.
//

import Foundation
import UIKit

enum RootVCType {
    case onboardVC
    case splashVC
    case tabbarVC
    case loginVC
}

enum DateFormate: String {
    case normal = "MMMM dd, yyyy"
    case bithDayServerFormat = "yyyy-MM-dd"
    case chatFormat = "dd MMM yyyy"
    case normalWithTime = "MMM dd, yyyy HH:mm:ss"
    case timestampFormat = "yyyy-MM-dd HH:mm:ss"
    case timeFormat = "hh:mm: a"
    case chatTimeFormate = "hh:mm a"
    case serverTimeFormate = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case secondaryNormalWithTime = "MMM dd, yyyy"
    case messageInfoTime = "dd MMMM, hh:mm a"
    case currentDateFormat = "dd/MM/yyyy HH:mm:ss"
}

enum MessageType: String {
    case IMAGE
    case DOCUMENT
    case VIDEO
    case TEXT
    case START_OF_CHAT
    case DATE

    
}

enum DocumentType: String {
    case pdf
    case excel = "xlsx"
    case word = "docx"
    case other = ""
    case ppt
    
    var image: String {
        switch self {
        case .pdf: return "pdf_doc"
        case .excel: return "excel_doc"
        case .word: return "word_doc"
        case .other: return "other_doc"
        case .ppt: return "ppt_doc"
        }
    }
}


enum Request_Method: String {
    case post = "POST"
    case get = "GET"
    case patch = "PATCH"
    case put = "PUT"
    case delete = "DELETE"
}
