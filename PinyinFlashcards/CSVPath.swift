//
//  CSVPath.swift
//  Flashcards
//
//  Created by Michael Norris on 6/6/18.
//  Copyright © 2018 Michael Norris. All rights reserved.
//

import Cocoa

class CSVPath: NSViewController {
    @IBOutlet weak var Path: NSTextField!
    
    @IBAction func Go(sender: AnyObject) {
        
        // todo
        
        self.view.window?.close()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
}
