//
//  CSVPath.swift
//  Flashcards
//
//  Created by Michael Norris on 6/6/18.
//  Copyright © 2018 Michael Norris. All rights reserved.
//

import Cocoa

class CSVPath: NSViewController {
    
    let singletonCSV = SingletonCSV()
    
    @IBOutlet weak var Path: NSTextField!
    
    @IBAction func Go(sender: AnyObject) {
        
//        do {
//            let realPath = "/Users/Michael/Desktop/" + Path.stringValue
//            singletonCSV.csv = try CSV(name: realPath)
//        } catch {
//            // Catch errors or something
//            print(error)
//        }
        
        self.view.window?.close()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
}
