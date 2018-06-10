//
//  Flashcards.swift
//  Flashcards
//
//  Created by Michael Norris on 6/6/18.
//  Copyright © 2018 Michael Norris. All rights reserved.
//

import Cocoa

extension NSImage {
    class func swatchWithColor(color: NSColor, size: NSSize) -> NSImage {
        let image = NSImage(size: size)
        image.lockFocus()
        color.drawSwatch(in: NSMakeRect(0, 0, size.width, size.height))
        image.unlockFocus()
        return image
    }
}

class Flashcards: NSViewController {
    var isChineseToEnglish = true
    
    var seenCards = [BooleanLiteralType]()
    var currentPair = [String]()
    var currentIndex = 0
    
    @IBOutlet weak var word: NSTextField!
    @IBOutlet weak var changeCardButton: NSButton!
    @IBOutlet weak var changeLanguageButton: NSButton!
    @IBOutlet weak var notes: NSTextField!
    @IBOutlet weak var changeLanguageLabel: NSTextField!
    
    @IBAction func ChangeLanguage(_ sender: Any) {
        isChineseToEnglish = !isChineseToEnglish
        updateWord()
    }
    
    @IBAction func ChangeCard(sender: AnyObject) {
        currentIndex = Int(arc4random_uniform(UInt32(SingletonCSV.sharedInstance.csv.count)))
        if (currentIndex == SingletonCSV.sharedInstance.csv.count) {
            currentIndex = currentIndex - 1;
        }
        updateWord()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeCardButton.layer?.backgroundColor = NSColor.white.cgColor
        changeLanguageButton.image = NSImage.swatchWithColor(color: NSColor.white, size: NSMakeSize(643, 159))
        
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
