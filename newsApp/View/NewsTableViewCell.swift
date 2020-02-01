import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsImage: UIImageView!{
        didSet {
            newsImage.layer.cornerRadius = 5.0
            newsImage.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var maskImage: UIView!{
        didSet {
            maskImage.layer.cornerRadius = 5.0
            maskImage.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var newsTitle: UILabel! {
        didSet {
            newsTitle.numberOfLines = 0
        }
    }
    
    @IBOutlet weak var newsInfo: UILabel! {
       didSet {
           newsInfo.numberOfLines = 0
       }
   }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
