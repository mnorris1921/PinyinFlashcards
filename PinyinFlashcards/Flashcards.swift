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
    var shuffled = [[String]]()
    var currentPair = [String]()
    var currentIndex = 0
    
    let NUM_COLUMNS = 2
    
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
        currentIndex = currentIndex + 1
        if (currentIndex == shuffled.count) {
            self.view.window?.close()
        }
        else {
            updateWord()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeCardButton.layer?.backgroundColor = NSColor.white.cgColor
        changeLanguageButton.image = NSImage.swatchWithColor(color: NSColor.white, size: NSMakeSize(643, 159))
        
        shuffled = shuffle(csv: SingletonCSV.sharedInstance.csv)
        
        word.font = NSFont(name: word.font!.fontName, size: 40)
        word.alignment = NSTextAlignment.center
        
        currentIndex = 0
        updateWord()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
    }
    
    func shuffle (csv: [[String]]) -> [[String]] {
        let size = csv.count
        // 2 is the number of columns
        //var shuffled = [[String]](repeating: [String](repeating: "", count: NUM_COLUMNS), count: size)
        var shuffled = csv
        for (i, row) in shuffled.enumerated() {
            var randNdx = Int(arc4random_uniform(UInt32(size)))
            if (randNdx == size) {
                randNdx = randNdx - 1;
            }
            
            let temp = shuffled[randNdx]
            shuffled[randNdx] = row
            shuffled[i] = temp
        }
        return shuffled
    }
    
    func updateWord () {
        currentPair = shuffled[currentIndex]
        if (isChineseToEnglish) {
            word.stringValue = currentPair[0]
        }
        else {
            word.stringValue = currentPair[1]
        }
    }
}
