//
//  StringStuff.swift
//
//  Created by Layla Michel
//  Created on 2022-04-07
//  Version 1.0
//  Copyright (c) 2022 IMH. All rights reserved.
//
//  This program takes a file with a bunch of strings and
// returns a blowup version of it in an output file.

import Foundation

var blowupArray: [String] = []

func blowup(strings: String) -> String {
    var newString = ""
    var counter = 1

    // Check if string is empty or not
    if strings != "" {
        for char in strings {
            let charInt = Int(String(char)) ?? -23847125624345235

            // Check if the character at the index is a number
            if charInt == -23847125624345235 {
                // Add the current character to the newString
                newString += String(char)
            } else {
                if counter < strings.count {
                    // Get the character at the next index
                    // if the current index is a number
                    let index = strings.index(strings.startIndex, offsetBy: counter)
                    // Convert the next index to a string
                    let nextIndex = strings[index]
                    // Repeat and add the next index a specific
                    // amount of time to the newString
                    newString += String(repeating: nextIndex, count: charInt)
                } else {
                    break
                }
            }
            counter += 1
        }
    }

    return newString
}

do {
    if CommandLine.argc < 2 {
        // Message if no file is inputted
        print("Error: Text file needed.")
    } else {
        // Read command line arguments for file name
        let arguments = CommandLine.arguments
        let file: String = arguments[1]

        let set = try String(contentsOfFile: file, encoding: String.Encoding.utf8)
        let stringsArray: [String] = set.components(separatedBy: "\n")

        var counter = 0
        // Put each string in the array in the blowup function
        // and insert it to the blowupArray
        for string in stringsArray {
            blowupArray.insert(blowup(strings: string), at: counter)
            counter += 1
        }

        let joined = blowupArray.joined(separator: "\n")
        let saveToPath = "/home/runner/Assign-02-Swift/output.txt"

        do {
            // Put blowupArray into the new file
            try joined.write(toFile: saveToPath, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("Error with 'output.txt'")
        }

        print("Reversed strings added to 'output.txt'")
    }
} catch {
    // Error message if nonexistent file is inputted
    Swift.print("File does not exist.")
}
