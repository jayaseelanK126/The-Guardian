//
//  ViewController.swift
//  The Guardian
//
//  Created by Pyramid on 23/10/21.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var newsListTblView: UITableView!
    
    
    //MARK:- Initial Declaration
    
    var newsListModelViewObj = NewsListModelView()
    
    var newsListArr: [NewsModel] = []
    
    private var selectedRow:Int?
    
    private let refreshControl = UIRefreshControl()
    var activityView: UIActivityIndicatorView?
    
    
    //MARK:- View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpMethod()
        
    }
    
    //MARK:- Initial setup
    
    func setUpMethod()
    {
        
        newsListTblView.register(UINib(nibName: "NewsListTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsListCell")
        
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching News Data...")
        newsListTblView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshNewsData(_:)), for: .valueChanged)
        
        fetchNewsData(true)
    }
    
    //MARK:- Pull to refresh action method
    
    @objc private func refreshNewsData(_ sender: Any) {
        // Fetch Weather Data
        
        fetchNewsData(false)
    }
    
    //MARK:- Fetching Data from API/Local data base
    
    func fetchNewsData(_ isShowLoader:Bool)
    {
        if isShowLoader
        {
            showActivityIndicator()
        }
        
        newsListModelViewObj.getNewsList{ result in
            
            
            self.newsListArr = result.sorted(by: {$0.publicationDate > $1.publicationDate})
            
            if self.newsListArr.count == 0
            {
                ReachabilityManager.shared.noInternetConnectionAlert()
            }
            else
            {
                DispatchQueue.main.async
                {
                    self.hideActivityIndicator()
                    
                    self.refreshControl.endRefreshing()
                    
                    self.newsListTblView.reloadData()
                    
                }
            }
            
        }
    }
    
    //MARK:- Fetching data activity indicator show/hide
    
    func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.center = self.view.center
        self.view.addSubview(activityView!)
        DispatchQueue.main.async {
            self.activityView?.startAnimating()
        }
    }
    
    func hideActivityIndicator(){
        if (activityView != nil){
            DispatchQueue.main.async {
                self.activityView?.stopAnimating()
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate
{
    //MARK:- TableView DataSources Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return newsListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: NewsListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "NewsListCell", for: indexPath) as! NewsListTableViewCell
        cell.newsTitleLbl.text = newsListArr[indexPath.row].newsTitle
        cell.publicationDateLbl.text = GenericMethod.formatDateStr(dateStr: newsListArr[indexPath.row].publicationDate, sourceDateFormat: AppConfig.timeStampFormat, destinationDateFormat: "EEEE, MMM d, yyyy").dateStr
        cell.selectionStyle = .none
        cell.bodyLbl.attributedText = NSAttributedString(html: newsListArr[indexPath.row].newsBody)
        cell.newsThumbnailImg.loadURLImage(urlStr: self.newsListArr[indexPath.row].newsThumbnail)
        
        return cell
        
    }
    
    //MARK:- TableView Delegate Methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        selectedRow = indexPath.row
        performSegue(withIdentifier: "showDetail", sender: self)
        
    }
    
    //MARK:- Data passing between two views
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"
        {
            let secondViewController = segue.destination as! DetailsViewController
            secondViewController.newsDetails = newsListArr[selectedRow!]
        }
    }
    
}


