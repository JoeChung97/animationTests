//
//  User.swift
//  TesterApp
//
//  Created by Joseph Chung on 4/2/21.
//

import Foundation

public class User {
    
    var id: String
    var email: String
    var firstName: String
    var lastName: String
    var gender: String
    var ageRange: String
    var age: Int
    
    init(id: String, email: String, firstName: String, lastName: String, gender: String, ageRange: String, age: Int) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.ageRange = ageRange
        self.age = age
    }
    
    public class func generateRandomUser() -> User {
        
        let ageRange1 = Int.random(in: 18 ..< 78)
        let ageRange2 = Int.random(in: (ageRange1 + 1) ..< 80)
        
        let id = Utils.generateRandomString(length: 15)
        let firstName = Utils.generateRandomName(length: Int.random(in: 3 ..< 10))
        let lastName = Utils.generateRandomName(length: Int.random(in: 3 ..< 10))
        let email = firstName + "_" + lastName + "@gmail.com"
        let gender = Utils.makeRandomSelection(arr: ["Male", "Female"])
        let ageRange = String(ageRange1) + "-" + String(ageRange2)
        let age = Int.random(in: 18 ..< 60)
        
        let user = User(id: id, email: email, firstName: firstName, lastName: lastName, gender: gender, ageRange: ageRange, age: age)
        
        return user
    }
    
    public func printed() -> String {
        return "ID: " + id + "\n"
                + "Email: " + email + "\n"
                + "First Name: " + firstName + "\n"
                + "Last Name: " + lastName + "\n"
                + "Gender: " + gender + "\n"
                + "Age Range: " + ageRange + "\n"
                + "Age: " + String(age)
    }
    
}
