/*:
 [Previous](@previous)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Next](@next)
 
 # Singleton
 - - - - - - - - - -
 ![Singleton Diagram](Singleton_Diagram.png)
 
 The singleton pattern restricts a class to have only _one_ instance.
 
 The "singleton plus" pattern is also common, which provides a "shared" singleton instance, but it also allows other instances to be created too.
 
 ## Code Example
 */
import UIKit

let app = UIApplication.shared
let app2 = UIApplication() // this give error becuase Apple doesn't allow it

public class MySingleton {
    static let shared = MySingleton()

    private inti() { }
}

let mySingleton = MySingleton.shared

//MARK:- Singleton Plus

let fileManager = FileManager.default
let myFileManager = FileManager()
