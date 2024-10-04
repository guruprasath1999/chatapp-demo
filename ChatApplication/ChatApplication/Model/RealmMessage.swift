//
//  RealmMessage.swift
//  ChatApplication
//
//  Created by NAM on 02/10/24.
//

import Foundation
import ObjectMapper
import ObjectMapperAdditions
import RealmSwift

class RealmMessage: Object, Mappable {
    @Persisted(primaryKey: true) var tempMessageId: String? = ""
    @Persisted var message: String? = ""
    @Persisted var sessionId: String? = ""
    @Persisted var createdAt: String? = ""
    @Persisted var fileType: String = ""
    @Persisted var isDeleted = false
    @Persisted var quoteMessageId: String? = ""
    @Persisted var userID: String? = ""
    @Persisted var senderId: String? = ""
    @Persisted var messageType: String? = ""
    @Persisted var filePath: String? = ""
        
        // ObjectMapper required initializer
        required convenience init?(map: ObjectMapper.Map) {
            self.init()
        }
    
    var getDocumentType: DocumentType {
        if fileType.lowercased().contains("pdf") {
            return .pdf
        } else if fileType.lowercased().contains("doc") {
            return .word
        } else if fileType.lowercased().contains("xl") {
            return .excel
        } else if fileType.lowercased().contains("ppt") || fileType.lowercased().contains("pptx") {
            return .ppt
        } else {
            return .other
        }
    }
    
    var getImagePathUrl: URL {
        var url = FileManager.getDocumentsDirectory()
        url = url.appendingPathComponent(sessionId ?? "").appendingPathComponent(LocalFileManager.SubFolderType.images.rawValue)
            .appendingPathComponent("\(tempMessageId ?? "").\("png")")
        return url
    }
       
    
    func getVideoPathUrl(isThumbnail: Bool) -> URL {
        var url = FileManager.getDocumentsDirectory()
        url = url.appendingPathComponent(sessionId ?? "").appendingPathComponent(LocalFileManager.SubFolderType.videos.rawValue)
            .appendingPathComponent("\( tempMessageId ?? "").\(isThumbnail ? "png" : fileType)")
        return url
    }
    
    func getDocumentPathUrl(isThumbnail: Bool) -> URL {
        
        var url = FileManager.getDocumentsDirectory()
        url = url.appendingPathComponent(sessionId ?? "").appendingPathComponent(LocalFileManager.SubFolderType.documents.rawValue)
            .appendingPathComponent("\( tempMessageId ?? "").\(isThumbnail ? "png" : fileType)")
        return url
        
    }
    
    
    func mapping(map: ObjectMapper.Map) {
        tempMessageId <- map["tempMessageId"]
        message <- map["message"]
        quoteMessageId <- map["quoteMessageId"]
        senderId <- map["senderId"]
        messageType <- map["messageType"]
        sessionId <- map["sessionId"]
        createdAt <- map["createdAt"]
        isDeleted <- map["isDeleted"]
        
        
    }
}


