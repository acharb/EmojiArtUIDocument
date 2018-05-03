//
//  DocumentBrowserViewController.swift
//  EmojiArtUIDocument
//
//  Created by Alec Charbonneau on 1/29/18.
//  Copyright © 2018 Alec Charbonneau. All rights reserved.
//

import UIKit


class DocumentBrowserViewController: UIDocumentBrowserViewController, UIDocumentBrowserViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        allowsDocumentCreation = true
        allowsPickingMultipleItems = false
        
        if UIDevice.current.userInterfaceIdiom == .pad { // if an iPad
            template = try? FileManager.default.url( // getting a URL from directory
                for: FileManager.SearchPathDirectory.applicationSupportDirectory, // Finding a directory we want to access, must be a sandbox directory
                in: .userDomainMask, // always use for iOS
                appropriateFor: nil, // only use if replacing a file
                create: true // create sandbox directory if it doesn't already exist
                ).appendingPathComponent("Untitled.json") // URL method, adds file on to end of url
            
            if template != nil {
                allowsDocumentCreation = FileManager.default.createFile(atPath: template!.path, contents: Data())
            }
        }
    }
    
    var template: URL?
    
    // MARK: UIDocumentBrowserViewControllerDelegate
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didRequestDocumentCreationWithHandler importHandler: @escaping (URL?, UIDocumentBrowserViewController.ImportMode) -> Void) {
        importHandler(template, .copy)
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didPickDocumentURLs documentURLs: [URL]) {
        guard let sourceURL = documentURLs.first else { return }
        
        // Present the Document View Controller for the first document that was picked.
        // If you support picking multiple items, make sure you handle them all.
        presentDocument(at: sourceURL)
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didImportDocumentAt sourceURL: URL, toDestinationURL destinationURL: URL) {
        // Present the Document View Controller for the new newly created document
        presentDocument(at: destinationURL)
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, failedToImportDocumentAt documentURL: URL, error: Error?) {
        // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
    }
    
    // MARK: Document Presentation
    
    func presentDocument(at documentURL: URL) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let documentVC = storyBoard.instantiateViewController(withIdentifier: "DocumentMVC")
        if let emojiArtViewController = documentVC.contents as? EmojiArtViewController {
            emojiArtViewController.document = EmojiArtDocument(fileURL: documentURL)
        }
        
        present(documentVC, animated: true)
    }
}

