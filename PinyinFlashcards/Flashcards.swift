//
//  Flashcards.swift
//  Flashcards
//
//  Created by Michael Norris on 6/6/18.
//  Copyright © 2018 Michael Norris. All rights reserved.
//

import Cocoa

class Flashcards: NSViewController {
    var isChineseToEnglish = true
    
    var seenCards = [BooleanLiteralType]()
    var currentPair = [String]()
    var currentIndex = 0
    
    @IBOutlet weak var word: NSTextField!
    
    @IBOutlet weak var changeCardButton: NSButton!
    @IBOutlet weak var englishToChinese: NSButton!
    @IBOutlet weak var chineseToEnglish: NSButton!
    
    @IBAction func ChangeCard(sender: AnyObject) {
        currentIndex = Int(arc4random_uniform(UInt32(SingletonCSV.sharedInstance.csv.count)) - 1)
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
        changeCardButton.layer?.backgroundColor = NSColor.white.cgColor
        changeCardButton.layer?.backgroundColor = NSColor.magenta.cgColor
        changeCardButton.layer?.backgroundColor = NSColor.magenta.cgColor
        word.font = NSFont(name: word.font!.fontName, size: 40)
        word.alignment = NSTextAlignment.center
        
        seenCards = [Bool](repeating: false, count: SingletonCSV.sharedInstance.csv.count)
        currentIndex = 0
        updateWord()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
    }
    
    func updateWord () {
        currentPair = SingletonCSV.sharedInstance.csv[currentIndex]
        if (isChineseToEnglish) {
            word.stringValue = currentPair[0]
        }
        else {
            word.stringValue = currentPair[1]
        }
    }
}
