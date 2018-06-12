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

extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            // Change `Int` in the next line to `IndexDistance` in < Swift 4.1
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}

class Flashcards: NSViewController {
    var isChineseToEnglish = true
    var shuffled = [[String]]()
    var currentRow = [String]()
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
    
    @IBAction func PreviousCard(_ sender: Any) {
        if currentIndex == 0 {
            self.view.window?.close()
        }
        else {
            repeat {
                currentIndex = currentIndex - 1
            } while (currentIndex > 0 && (shuffled[currentIndex][0]).isEmpty)
            
            updateWord()
        }
    }
    
    @IBAction func ChangeCard(sender: AnyObject) {
        repeat {
            currentIndex = currentIndex + 1
        } while ((shuffled[currentIndex][0]).isEmpty)
        
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
        
        shuffled = SingletonCSV.sharedInstance.csv.shuffled()
        
        word.lineBreakMode = .byWordWrapping
        word.setContentCompressionResistancePriority(NSLayoutConstraint.Priority(rawValue: 250), for: .horizontal)
        word.usesSingleLineMode = false
        word.cell?.wraps = true
        word.cell?.isScrollable = false
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
    
    func updateWord () {
        currentRow = shuffled[currentIndex]
        if (isChineseToEnglish) {
            word.stringValue = currentRow[0]
        }
        else {
            word.stringValue = currentRow[1]
        }
        if currentRow.count > 2 {
            notes.stringValue = "Notes: " + currentRow[2]
        }
    }
}
