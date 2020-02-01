import UIKit
import Alamofire
import XLPagerTabStrip
import Kingfisher

class NewsTableViewController: UITableViewController, IndicatorInfoProvider{
    
    var newsArray = [News]()
    var navTitle: String = ""
    var cateId: Int = 0
    var limit: Int = 10
    var offset: Int = 0
    var url: String {
        return "http://localhost:8000/api/news/\(self.cateId)/\(self.limit)/\(self.offset)"
    }
    var reachedEndOfItems = false
    
    var filteredArray = [News]()
    var shouldShowSearchResult = false
    
    override func viewDidLoad() {
        
        getNews()
        
        // implement pull to refresh
        refreshControl = UIRefreshControl()
        self.tableView.refreshControl = refreshControl
        refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: UIControl.Event.valueChanged)
        
        self.title = "首頁"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: "#3C56A6")
        
        super.viewDidLoad()
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "\(navTitle)")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResult {
            return filteredArray.count
        }
        else{
            return newsArray.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let isLastRow = (indexPath.row == self.newsArray.count - 1)
        if isLastRow {
            loadMore()
        }
        
        let cellIdentifer = "dataCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath) as! NewsTableViewCell
        
        var image, source, title, publishDate:String
        
        if shouldShowSearchResult {
            image = filteredArray[indexPath.row].image
            title = filteredArray[indexPath.row].title
            source = filteredArray[indexPath.row].source
            publishDate = filteredArray[indexPath.row].publish_date
        }
        else{
            image = newsArray[indexPath.row].image
            title = newsArray[indexPath.row].title
            source = newsArray[indexPath.row].source
            publishDate = newsArray[indexPath.row].publish_date
        }
        
        cell.newsImage?.kf.indicatorType = .activity
        cell.newsImage?.kf.setImage(with: URL(string: image), completionHandler: { (result) in
            switch result {
                case .success( _): return
                case .failure( _): cell.newsImage.image = UIImage(named: "no image available.001")
            }
        })
        cell.newsTitle?.text = title
        cell.newsInfo?.text = source + ", " + publishDate.prefix(10)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNewsDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! newsDetailViewController
                
                // 傳遞news物件給detail view controller
                destinationController.news = newsArray[indexPath.row]
            }
        }
    }
    
    // 用alamofire套件接laravel寫的新聞資料API，並解析回傳的json，存入陣列當中
    @objc func getNews() {
        var count = 0
        AF.request(self.url)
          .responseJSON(completionHandler: { response in
                switch response.result {
                    case .success(let json):
                        
                        if let dict = json as? [String: Any]{
                            
                            if let rows = dict["data"] as? [[String: Any]]{
                                for row in rows{
                                    let title = row["title"] as! String
                                    let content = row["content"] as! String
                                    let image = row["image"] as! String
                                    
                                    let url = row["url"] as! String
                                    let source = row["source"] as! String
                                    let publish_date = row["publish_date"] as! String
                                    
                                    let newsRow = News(title: title, content: content, image: image, url: url, source: source, publish_date: publish_date, isFavorite: false)
                                    
                                    self.newsArray.append(newsRow)
                                    count += 1
                                }
                            }
                            self.offset += self.limit
                            if count < self.limit {
                                self.reachedEndOfItems = true
                            }
                            // important: reload data
                            self.tableView.reloadData()
                        }
                    case .failure(let error):
                        print(error)
                }
        })
    }
    
    @objc func pullToRefresh() {
        self.newsArray = [News]()
        self.offset = 0
        self.reachedEndOfItems = false
        getNews()
        self.refreshControl?.endRefreshing()
    }
    
    @objc func loadMore() {
        guard !self.reachedEndOfItems else {
            return
        }

        // query the db on a background thread
        DispatchQueue.global(qos: .background).async {
            self.getNews()
        }
    }
}
