import UIKit

class NewsDetailTextCell: UITableViewCell {

    @IBOutlet weak var detailText: UILabel! {
        didSet{
            detailText.numberOfLines = 0
        }
    }
    @IBOutlet weak var linkBtn: UIButton!
    
}
