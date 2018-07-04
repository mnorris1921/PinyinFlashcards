//
//  ViewController.swift
//  Flashcards
//
//  Created by Michael Norris on 6/6/18.
//  Copyright © 2018 Michael Norris. All rights reserved.
//

import Cocoa

class MainScreen: NSViewController {

    let realPath = "ChineseVocab4.csv"
    
    override func viewDidLoad () {
        super.viewDidLoad()
        let str = readDataFromCSV()
        SingletonCSV.sharedInstance.csv = csv(data: str!)
    }

    func csv (data: String) -> [[String]] {
        var result: [[String]] = []
        let rows = data.components(separatedBy: "\n")
        for row in rows {
            let columns = row.components(separatedBy: ",")
            result.append(columns)
        }
        return result
    }

    func readDataFromCSV () -> String! {
        var contents = ""
        if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.desktopDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first {
            
            let path = NSURL(fileURLWithPath: dir).appendingPathComponent(realPath)
            do {
                contents = try NSString(contentsOf: path!, encoding: String.Encoding.utf8.rawValue) as String
            }
            catch {
                print("could not find file at path")
            }
        }
        return contents
    }


    func cleanRows (file:String) -> String {
        var cleanFile = file
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        //        cleanFile = cleanFile.replacingOccurrences(of: ";;", with: "")
        //        cleanFile = cleanFile.replacingOccurrences(of: ";\n", with: "")
        return cleanFile
    }
}

