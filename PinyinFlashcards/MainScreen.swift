//
//  ViewController.swift
//  Flashcards
//
//  Created by Michael Norris on 6/6/18.
//  Copyright © 2018 Michael Norris. All rights reserved.
//

import Cocoa

class MainScreen: NSViewController {
    
    let singletonCSV = SingletonCSV()

    override func viewDidLoad () {
        super.viewDidLoad()

        let realPath = "/Users/Michael/Desktop/test.csv"
        let str = readDataFromCSV(path: realPath)
        singletonCSV.csv = csv(data: str)
    }

    func csv (data: String) -> [[String]] {
        var result: [[String]] = []
        let rows = data.components(separatedBy: "\n")
        for row in rows {
            let columns = row.components(separatedBy: ";")
            result.append(columns)
        }
        return result
    }

    func readDataFromCSV (path:String)-> String! {
        do {
            var contents = try String(contentsOfFile: path)
            contents = cleanRows(file: contents)
            return contents
        } catch {
            print("File Read Error for file \(path)")
            return nil
        }
    }


    func cleanRows (file:String)->String {
        var cleanFile = file
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        //        cleanFile = cleanFile.replacingOccurrences(of: ";;", with: "")
        //        cleanFile = cleanFile.replacingOccurrences(of: ";\n", with: "")
        return cleanFile
    }
}

