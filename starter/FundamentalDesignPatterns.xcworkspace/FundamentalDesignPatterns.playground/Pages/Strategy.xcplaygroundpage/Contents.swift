/*:
 [Previous](@previous)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Next](@next)
 
 # Strategy
 - - - - - - - - - -
 ![Strategy Diagram](Strategy_Diagram.png)
 
 The strategy pattern defines a family of interchangeable objects.
 
 This pattern makes apps more flexible and adaptable to changes at runtime, instead of requiring compile-time changes.
 
 ## Code Example
 */

import UIKit


public protocol MovieRatingStrategy {
    var ratingServiceName: String { get }
    func fetchRating(for movieTitle: String, success: (_ rating: String, _ review: String) -> Void)
}

public class RottenTomatoesClient: MovieRatingStrategy {
    public let ratingServiceName: String = "Rotten Tomatoes"

    public func fetchRating(for movieTitle: String, success: (String, String) -> Void) {
        let rating = "95%"
        let review = "Awesome!"
        success(rating, review)
    }
}


public class IMDBClient: MovieRatingStrategy {
    public let ratingServiceName: String = "IMDB"

    public func fetchRating(for movieTitle: String, success: (String, String) -> Void) {
        let rating = "7/10"
        let review = "Entertain it"
        success(rating,review)
    }
}

public class MovieRatingViewController: UIViewController {

    // MARK: - Properties
    public var movieRatingClient: MovieRatingStrategy!

    //MARK: - IBOutlets
    @IBOutlet public var movieTitleTextField: UITextField!
    @IBOutlet public var ratingServiceNameLabel: UILabel!
    @IBOutlet public var ratingLabel: UILabel!
    @IBOutlet public var reviewLabel: UILabel!

    //MARK: - View lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        ratingServiceNameLabel.text = movieRatingClient.ratingServiceName
    }

    //MARK: - IBActions
    @IBAction public func searchButtonPressed(_ sender: UIButton) {
        guard let movieTitle = movieTitleTextField.text else {
            return
        }
        movieRatingClient.fetchRating(for: movieTitle) { (rating, review) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.ratingLabel.text = rating
                self.reviewLabel.text = review
            }
        }
    }


}

