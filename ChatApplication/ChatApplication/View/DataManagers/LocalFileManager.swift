//
//  LocalFileManager.swift
//  ChatApplication
//
//  Created by NAM on 03/10/24.
//

import Foundation

class LocalFileManager {
    private static let _sharedInstance = LocalFileManager()
    static func sharedInstance() -> LocalFileManager {
        return _sharedInstance
    }

    enum SubFolderType: String {
        case documents = "Documents"
        case images = "Images"
        case videos = "Videos"
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    func createDirectory(url: URL) {
        do {
            try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: [:])
        } catch {
            print(error)
        }
    }

    func saveFile(data: Data,
                  folderName: String,
                  subFolderType: SubFolderType,
                  fileName: String,
                  pathUrl: URL = URL(fileURLWithPath: ""),
                  documentType: String,
                  completionHandler: @escaping (_ errorMessage: String?, _ destinationUrl: URL?, _ tempId: String, _ pathUrl: URL) -> Void) {
        let actualPath = getDocumentsDirectory().appendingPathComponent(folderName).appendingPathComponent(subFolderType.rawValue).appendingPathComponent("\(fileName).\(documentType)")
        createDirectory(url: getDocumentsDirectory().appendingPathComponent(folderName).appendingPathComponent(subFolderType.rawValue))
        do {
            try data.write(to: actualPath, options: .atomic)
            completionHandler(nil, URL(string: actualPath.absoluteString), fileName, pathUrl)
        } catch {
            print("Error found while saving file.")
        }
    }
    
    func copyFile(fromUrl: URL,
                  folderName: String,
                  subFolderType: SubFolderType,
                  fileName: String,
                  filepath: String,
                  documentType: String,
                  completionHandler: @escaping (_ errorMessage: String?, _ destinationUrl: URL?, _ tempId: String, _ filepath: String) -> Void) {
        let actualPath = getDocumentsDirectory().appendingPathComponent(folderName).appendingPathComponent(subFolderType.rawValue).appendingPathComponent("\(fileName).\(documentType)")
        createDirectory(url: getDocumentsDirectory().appendingPathComponent(folderName).appendingPathComponent(subFolderType.rawValue))
        do {
            try FileManager.default.copyItem(at: fromUrl, to: actualPath)
            completionHandler(nil, URL(string: actualPath.absoluteString), fileName, filepath)
        } catch {
            print("Error found while saving file.")
        }
    }
    
    func getFilePath(folderName: String,
                     subFolderType: SubFolderType,
                     fileName: String,
                     documentType: String) -> URL {
        let actualPath = getDocumentsDirectory().appendingPathComponent(folderName)
            .appendingPathComponent(subFolderType.rawValue)
            .appendingPathComponent("\(fileName).\(documentType)")
        return actualPath
    }
}
