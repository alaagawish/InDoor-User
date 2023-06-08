//
//  Splitter.swift
//  InDoor-User
//
//  Created by Alaa on 09/06/2023.
//

import Foundation
class Splitter {
    
    func splitName(text: String, delimiter: String ) -> String{
        let substrings = text.components(separatedBy: delimiter)
        return substrings[substrings.count-1]
    }
}
