import UIKit

class newsDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: NewsDetailHeaderView!
    
    var news = News()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never

        let image = news.image
        headerView.headerImage.kf.indicatorType = .activity
        headerView.headerImage.kf.setImage(with: URL(string: image), completionHandler: { (result) in
            switch result{
                case .success( _): break
                case .failure( _): self.headerView.headerImage.image = UIImage(named: "no image available.001")
            }
            
        })
        
        headerView.titleLabel.text = news.title
        headerView.infoLabel.text = news.source + ", " + news.publish_date
        
        headerView.shareBtn.addTarget(self,
                                      action: #selector(shareAction),
                                      for: .touchUpInside)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsDetailTextCell.self), for: indexPath) as! NewsDetailTextCell
            
            cell.detailText.text = news.content
            cell.linkBtn.accessibilityIdentifier = news.url
            cell.linkBtn.addTarget(self,
                                   action: #selector(openURL),
                                   for: .touchUpInside)
            
            return cell
        default:
            fatalError("Failed to instantiate the table view cell for detail view controller")
        }
    }
    @objc func openURL(sender: UIButton) {
        guard let urlString = sender.accessibilityIdentifier else {
            return
        }
        guard let url = URL(string: urlString) else {
            return
        }
        
        UIApplication.shared.open(url)
    }
    @objc func shareAction(sender: UIButton) {
        let defaultText = "\(self.news.title) \n\(self.news.url)"
        let activityController: UIActivityViewController
        
        let imageToShare = UIImageView()
        imageToShare.kf.setImage(with: URL(string: self.news.image))
        
        if imageToShare.image == nil{
            activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
        } else  {
            activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
        }

        self.present(activityController, animated: true, completion: nil)
    }
}
