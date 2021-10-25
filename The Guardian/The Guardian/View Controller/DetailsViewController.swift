//
//  DetailsViewController.swift
//  The Guardian
//
//  Created by Pyramid on 23/10/21.
//

import UIKit
import WebKit


class DetailsViewController: UIViewController {
    
    @IBOutlet weak var thumbNailImg: UIImageView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var publicationDateLbl: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var newsTitleLbl: UILabel!
    @IBOutlet weak var readMoreBtn: UIButton!
    
    var newsDetails: NewsModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDesignStyle()
        setupMethod()
        
    }
    
    func setDesignStyle()
    {
        CSS.customLabel(newsTitleLbl, textColor: .black)
        CSS.customLabel(publicationDateLbl, textColor: .gray)
        CSS.customButton(button: readMoreBtn, titleNormalColor: .white, titleSelectedColor: .white, isRoundCorner: true)
        thumbNailImg.makeRounded(cornerRadius: 15.0)
        backBtn.setTitle("", for: .normal)
    }
    
    //MARK: - Initial setup
    func setupMethod()
    {
        loadHTMLStringImage()
        newsTitleLbl.text = newsDetails?.newsTitle ?? "---"
        if let safeDate = newsDetails?.publicationDate
        {
            publicationDateLbl.text = GenericMethod.formatDateStr(dateStr: safeDate, sourceDateFormat: AppConfig.timeStampFormat, destinationDateFormat: "EEEE, MMM d, yyyy").dateStr
        }
        else
        {
            publicationDateLbl.text = "---"
        }
        thumbNailImg.image = UIImage(data: newsDetails!.newsThumbnailImgData)

    }
    
//MARK: - Load HTML String in webview
    func loadHTMLStringImage() -> Void
    {

        let font = "<font face='Helvetica-Light' size=5>%@"
        let html = String(format: font, newsDetails!.newsBody)
        webView.loadHTMLString(html, baseURL: nil)
    }
    
    //MARK: - Read on website button action
    @IBAction func readMoreBtnAction(_ sender: Any)
    {
        if ReachabilityManager.shared.isConnectedToNetwork() == false
        {
            ReachabilityManager.shared.noInternetConnectionAlert()
        }
        else
        {
            if let url = URL(string: newsDetails?.newsURL ?? "https://www.theguardian.com/international")
            {
                UIApplication.shared.open(url)
            }
        }
        
    }
    
    //MARK: - Back to list page button action 
    @IBAction func backBtnAction(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
}

