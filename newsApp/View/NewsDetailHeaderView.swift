import UIKit

class NewsDetailHeaderView: UIView {
    
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel! {
           didSet {
               titleLabel.numberOfLines = 0
           }
       }
    @IBOutlet weak var infoLabel: UILabel! {
           didSet {
               infoLabel.numberOfLines = 0
           }
       }
    @IBOutlet weak var shareBtn: UIButton!{
        didSet {
            shareBtn.tintColor = .white
        }
    }
    
}
