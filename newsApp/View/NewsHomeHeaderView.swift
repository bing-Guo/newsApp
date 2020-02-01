import UIKit

class NewsHomeHeaderView: UIView {
    // https://color.adobe.com/zh/trends
    @IBOutlet weak var homeBtn: UIButton! {
        didSet {
            homeBtn.backgroundColor = UIColor(hex: "#3C56A6")
            homeBtn.tintColor = .white
        }
    }
    @IBOutlet weak var categoryBtn: UIButton! {
        didSet {
            categoryBtn.backgroundColor = UIColor(hex: "#3C56A6")
            categoryBtn.tintColor = .white
        }
    }
    @IBOutlet weak var favoriteBtn: UIButton! {
         didSet {
            favoriteBtn.backgroundColor = UIColor(hex: "#3C56A6")
            favoriteBtn.tintColor = .white
        }
    }
    @IBOutlet weak var userBtn: UIButton! {
         didSet {
            userBtn.backgroundColor = UIColor(hex: "#3C56A6")
            userBtn.tintColor = .white
        }
    }
    
}
