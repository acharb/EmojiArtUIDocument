//
//  EmojiArt.swift
//  emojiArt
//
//  Created by Alec Charbonneau on 1/29/18.
//  Copyright © 2018 Alec Charbonneau. All rights reserved.
//

import Foundation


struct EmojiArt: Codable { // codable so can archive (persistence)
    
    
    var url: URL
    var emojis = [EmojiInfo]()
    
    struct EmojiInfo: Codable {
        let x: Int
        let y: Int
        let text: String
        let size: Int
    }
    
    var json: Data? {
        return try? JSONEncoder().encode(self) // returning json string of self
    }
    
    
    init?(json: Data) { // creating model from json data, failable initializer
        if let newValue = try? JSONDecoder().decode(EmojiArt.self, from: json) {
            self = newValue
        } else {
            return nil
        }
    }
    
    init(url: URL, emojis: [EmojiInfo]) {
        self.url = url
        self.emojis = emojis
    }
    
    
    
    
    
}
