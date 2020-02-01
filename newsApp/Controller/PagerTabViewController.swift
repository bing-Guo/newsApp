import UIKit
import XLPagerTabStrip

class PagerTabViewController: ButtonBarPagerTabStripViewController {
    
    var magentaView = UIView()
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        
        loadDesignSetting()

        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        self.containerView.contentInsetAdjustmentBehavior = .never
        
        navigationItem.title = "焦點新聞"
        
        self.definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.definesPresentationContext = true

    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child0 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsTableViewController") as! NewsTableViewController
        child0.navTitle = "首頁"
        child0.cateId = 0
        
        let child1 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsTableViewController") as! NewsTableViewController
        child1.navTitle = "國際"
        child1.cateId = 1
        
        let child2 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsTableViewController") as! NewsTableViewController
        child2.navTitle = "社會"
        child2.cateId = 2
        
        let child3 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsTableViewController") as! NewsTableViewController
        child3.navTitle = "運動"
        child3.cateId = 3
        
        return [child0, child2, child3, child1]
    }

    // MARK: - Configuration
    func loadDesignSetting() {

        self.settings.style.buttonBarItemFont = .systemFont(ofSize: 14)
        self.settings.style.buttonBarItemTitleColor = UIColor(red:0.86, green:0.72, blue:0.44, alpha:1.0)
        self.settings.style.buttonBarHeight = 40
        self.settings.style.buttonBarBackgroundColor = UIColor.white
        self.settings.style.buttonBarItemBackgroundColor = UIColor.white
        self.settings.style.selectedBarHeight = 2
        self.settings.style.selectedBarBackgroundColor = UIColor(hex: "#3C56A6")
        self.settings.style.buttonBarItemsShouldFillAvailableWidth = false
        self.settings.style.buttonBarItemLeftRightMargin = 30
        
        changeCurrentIndexProgressive = {
            (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in

            guard changeCurrentIndex == true else { return }

            oldCell?.label.textColor = .black
            newCell?.label.textColor = UIColor(hex: "#F27405")

            if animated {
                UIView.animate(withDuration: 0.1, animations: { () -> Void in
                    newCell?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    oldCell?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                })
            }
            else {
                newCell?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                oldCell?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
