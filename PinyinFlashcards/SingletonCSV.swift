//
//  SingletonCSV.swift
//  Flashcards
//
//  Created by Michael Norris on 6/7/18.
//  Copyright © 2018 Michael Norris. All rights reserved.
//

import Cocoa

class SingletonCSV {
    static let sharedInstance = SingletonCSV()
    var csv : [[String]]!
}
