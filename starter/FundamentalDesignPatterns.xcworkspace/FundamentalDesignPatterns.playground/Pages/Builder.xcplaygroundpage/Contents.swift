
/*:
 [Previous](@previous)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Next](@next)

 # Builder
 - - - - - - - - - -
 ![Builder Diagram](Builder_Diagram.png)

 The builder pattern allows complex objects to be created step-by-step instead of all-at-once via a large initializer.

 The builder pattern involves three parts:

 (1) The **product** is the complex object to be created.

 (2) The **builder** accepts inputs step-by-step and ultimately creates the product.

 (3) The **director** supplies the builder with step-by-step inputs and requests the builder create the product once everything has been provided.

 ## Code Example
 */

import Foundation

public struct Hamburger {
    public let meat: Meat
    public let sauce: Sauces
    public let toppings: Toppings
}

extension Hamburger: CustomStringConvertible {
    public var description: String {
        return meat.rawValue + "burger"
    }
}

public enum Meat: String {
    case beef
    case chicken
    case kitten
    case tofu
}

public struct Sauces: OptionSet {
    public static let mayonnnaise = Sauces(rawValue: 1 << 0)
    public static let musturd = Sauces(rawValue: 1 << 1)
    public static let ketchup = Sauces(rawValue: 1 << 2)
    public static let secret = Sauces(rawValue: 1 << 3)

    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

public struct Toppings: OptionSet {
    public static let lattuse = Toppings(rawValue: 1 << 1)
    public static let tomatoes = Toppings(rawValue: 1 << 3)
    public static let cheese = Toppings(rawValue: 1 << 0)
    public static let pickle = Toppings(rawValue: 1 << 2)

    public let rawValue: Int
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

public class HambergerBuilder {
    public enum Error: Swift.Error {
        case soldOut
    }
    public private(set) var meat: Meat = .beef
    public private(set) var sauces: Sauces = []
    public private(set) var toppings: Toppings = []
    private var soldOutMeats: [Meat] = [.kitten]

    public func addSauces(_ sauce: Sauces){
        sauces.insert(sauce)
    }

    public func removeSauces(_ sauce: Sauces){
        sauces.remove(sauce)
    }

    public func addTopping(_ topping: Toppings){
        toppings.insert(topping)
    }

    public func setMeat(_ meat: Meat) throws {
        guard isAvailable(meat) else { throw Error.soldOut}
        self.meat = meat
    }

    public func build() -> Hamburger {
        return Hamburger(meat: meat,
                         sauce: sauces,
                         toppings: toppings)
    }


    public func isAvailable(_ meat: Meat) -> Bool {
        return !soldOutMeats.contains(meat)
    }
}

public class Employee {
    public func createCombo1() throws -> Hamburger {
        let builder = HambergerBuilder()
        try builder.setMeat(.chicken)
        builder.addSauces([.ketchup, .musturd])
        builder.addTopping([.tomatoes, .cheese])
        return builder.build()
    }

    func createKittenSpecial() throws -> Hamburger {
        let builder = HambergerBuilder()
        try builder.setMeat(.kitten)
        builder.addSauces([.secret])
        builder.addTopping([.cheese,.pickle])
        return builder.build()
    }
}

let burgerFlipper = Employee()
if let combo1 = try? burgerFlipper.createCombo1() {
    print("Nom Nom \(combo1.description)")
}

if let kittenBurger = try? burgerFlipper.createKittenSpecial() {
    print("nom nom Kitten \(kittenBurger.description)")
} else {
    print("Sorry no kitten burgers here")
}
