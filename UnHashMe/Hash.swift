//
//  Hash.swift
//  UnHashMe
//
//  Created by Alexey on 4/06/2016.
//  Copyright © 2016 Alexey Zhilnikov. All rights reserved.
//

import Foundation

class Hash {
    
    // Set of characters that can be used in hash/unhash
    private let alphabet: [Character]
    
    init(alphabet: String) {
        self.alphabet = Array(alphabet.characters)
    }
    
    // MARK: - Public methods
    
    // Generate hash for a given text string
    func generateFor(text: String, completion: (hash: String?) -> Void) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            
            // Hash function
            var h = 7
            for c in text.characters {
                guard let index = self.alphabet.indexOf(c) else {
                    // The character is not in alphabet, return nil
                    dispatch_async(dispatch_get_main_queue(), {
                        completion(hash: nil)
                    })
                    return
                }
                h = h * 37 + index
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                // Return hash as String
                completion(hash: String(h))
            })
        })
    }
    
    // Find a string with a certain length that would generate given hash value
    func restoreStringWithLength(length: Int, from hash: Int, completion: (text: String?) -> Void) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            
            var result = [Character](count: length, repeatedValue: " ")
            var hashValue = hash
            var found = false
            
            // Unhash function
            for i in 1...length {
                
                found = false
                for characterIndex in 0..<self.alphabet.count {
                    
                    // Find a character in alphabet that suits the condition below
                    if 0 == (hashValue - characterIndex) % 37 {
                        hashValue = (hashValue - characterIndex) / 37
                        // Insert character into array (backwards)
                        result[length - i] = self.alphabet[characterIndex]
                        found = true
                        break
                    }
                }
                
                if !found {
                    // There is no a character in alphabet for such hash value
                    // Unable to restore text string, return nil
                    break
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                found ? completion(text: String(result)) : completion(text: nil)
            })
        })
    }
}
