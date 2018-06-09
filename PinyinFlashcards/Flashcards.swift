//
//  Flashcards.swift
//  Flashcards
//
//  Created by Michael Norris on 6/6/18.
//  Copyright © 2018 Michael Norris. All rights reserved.
//

import Cocoa

class Flashcards: NSViewController {
    
    let singletonCSV = SingletonCSV()
    var isChineseToEnglish = true
    
    var seenCards = [BooleanLiteralType]()
    var currentPair = ["" : ""]
    var currentIndex = 0
    
    @IBOutlet weak var word: NSTextField!
    
    @IBOutlet weak var changeCardButton: NSButton!
    
    @IBAction func ChangeCard(sender: AnyObject) {
        changeCardButton.layer?.backgroundColor = NSColor.lightGray.cgColor
        currentIndex = Int(arc4random_uniform(UInt32(singletonCSV.csv.rows.count)) - 1)
        currentPair = singletonCSV.csv.rows[currentIndex]
        updateWord()
    }
    
    @IBAction func ChineseToEnglish(sender: AnyObject) {
        isChineseToEnglish = true
        updateWord()
    }
    
    @IBAction func EnglishToChinese(sender: AnyObject) {
        isChineseToEnglish = false
        updateWord()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        word.font = NSFont(name: word.font!.fontName, size: 40)
        
        seenCards = [Bool](count: singletonCSV.csv.rows.count, repeatedValue: false)
        currentIndex = 0
        currentPair = singletonCSV.csv.rows[currentIndex]
        updateWord()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
    }
    
    func updateWord () {
        if (isChineseToEnglish) {
            word.stringValue = currentPair.values.first!
        }
        else {
            word.stringValue = currentPair.keys.first!
        }
    }
}
