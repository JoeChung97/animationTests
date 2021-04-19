//
//  Utils.swift
//  TesterApp
//
//  Created by Joseph Chung on 4/2/21.
//

import Foundation

public class Utils {
    
    public class func generateRandomString(length: Int) -> String {
        
        var randomString = ""
        let choiceString = "abcdefghijklmnopqrstuvwxyABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        for _ in 0 ..< length {
            let c = choiceString.randomElement()!
            randomString += String(c)
        }
        
        return randomString
    }
    
    public class func makeRandomSelection(arr: [String]) -> String {
        let selection = arr[Int.random(in: 0 ..< arr.count)]
        return selection
    }
    //TODO: Can't have 2 of same consonant in a row (Ex. jj)
    //Certain letter order rules
    //
    public class func generateRandomName(length: Int) -> String {
        let vowels = "aeiou"
        let consonants = "qwrtypsdfghjklzxcvbnm"
        let fullAlphabet = "abcdefghijklmnoprstuvwxyz"
        
        var name = ""
        
        var prev = ""
        for x in 0 ..< length {
            
            if(x == 0) {
                let element = (fullAlphabet.randomElement() ?? "A").uppercased()
                name += String(element)
                prev += String(element)
            }else{
                
                if(consonants.contains(prev)) {
                    let element = vowels.randomElement()!
                    name += String(element)
                    prev = String(element)
                }else{
                    let element = fullAlphabet.randomElement()!
                    name += String(element)
                    prev = String(element)
                }
                
            }
            
        }
        
        return name
    }
    
}
