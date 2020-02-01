import Foundation

class News {
    var title: String
    var content: String
    var image: String
    var url: String
    var source: String
    var publish_date: String
    var isFavorite: Bool
    
    init(title: String, content: String, image: String, url: String, source: String, publish_date: String, isFavorite: Bool) {
        self.title = title
        self.content = content
        self.image = image
        self.url = url
        self.source = source
        self.publish_date = publish_date
        self.isFavorite = isFavorite
    }
    
    convenience init() {
        self.init(title: "", content: "", image: "", url: "", source: "", publish_date: "", isFavorite: false)
    }
}
