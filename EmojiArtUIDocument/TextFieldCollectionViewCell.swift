//
//  TextFieldCollectionViewCell.swift
//  emojiArt
//
//  Created by Alec Charbonneau on 1/16/18.
//  Copyright © 2018 Alec Charbonneau. All rights reserved.
//

import UIKit

class TextFieldCollectionViewCell: UICollectionViewCell, UITextFieldDelegate {
    

    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.delegate = self
        }
    }
    
    var resignationHandler: (() -> Void)?
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        resignationHandler?()
    }
    
    // MARK: UITextFieldDelegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // keyboard dissappears when done using it
        return true
    }
    
    
}
