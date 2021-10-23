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
        CSS.customLabel(newsTitleLbl, textColor: .black, fontCode: "M", fontSize: 14.0)
        CSS.customLabel(publicationDateLbl, textColor: .gray, fontCode: "I", fontSize: 12.0)
        CSS.customButton(button: readMoreBtn, fontSize: 14.0, titleNormalColor: .white, titleSelectedColor: .white, isRoundCorner: true)
        thumbNailImg.makeRounded(cornerRadius: 15.0)
        backBtn.setTitle("", for: .normal)
    }
    
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
        thumbNailImg.loadURLImage(urlStr: newsDetails?.newsThumbnail ?? "")

    }
    func loadHTMLStringImage() -> Void
    {
        webView.loadHTMLString(newsDetails?.newsBody ?? "", baseURL: nil)
    }
    
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
    
    @IBAction func backBtnAction(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
}
