//
//  NewsListModelView.swift
//  The Guardian
//
//  Created by Pyramid on 23/10/21.
//

import Foundation
import RealmSwift

struct NewsListModelView
{
    
    func getNewList(_ result:@escaping([NewsModel]) -> Void)
    {
        NetworkManager.GETMethodRequestWithKey(CountryName: "Afghanistan") { data in
            
            if let safeData = data
            {
                insertNewData(self.parseJSON(safeData), success: {
                    fetchNewsData { value in
                        result(value)
                    }
                })
            }
        } Failure: { error in
            
            GenericMethod.showAlert("Some error occured. Please try again later")
            
        }
    }
    
    func parseJSON(_ newsData: Data) -> [NewsModel]
    {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(NewsData.self, from: newsData)
            let status = decodedData.response.status
            let result = decodedData.response.results
            
            var newsModelArr: [NewsModel] = []
            if status == "ok"
            {
                _ = result.map { results in
                    
                    newsModelArr.append(NewsModel(id: results.id, publicationDate: results.webPublicationDate, newsTitle: results.webTitle, newsThumbnail: results.fields.thumbnail, newsBody: results.fields.body, newsURL: results.webUrl))
                }
            }
            else
            {
                GenericMethod.showAlert("Some error occured. Please try again later")
            }
            return newsModelArr
            
            
        } catch
        {
            return []
        }
    }
    
    func insertNewData(_ newsData: [NewsModel], success: @escaping ()->Void)
    {
        let realm = try! Realm()
        
        try! realm.write {
            realm.cancelWrite()
        }
        
        
        _ = newsData.map({ result in
                
            var newsObj = NewsListData_Tbl()

            let newsModel = realm.objects(NewsListData_Tbl.self).filter("id = %@ ", result.id)
            
            try! realm.write {
                
                if newsModel.count != 0
                {
                    newsObj = newsModel[0] as NewsListData_Tbl
                }
                else
                {
                    newsObj.MobilePrimaryId = newsObj.incrementMobilePrimaryId()

                }
                
                newsObj.id = result.id
                newsObj.publicationDate = result.publicationDate
                newsObj.newsBody = result.newsBody
                newsObj.newsThumbnail = result.newsThumbnail
                newsObj.newsTitle = result.newsTitle
                newsObj.newsURL = result.newsURL
                
                realm.add(newsObj)
            }
        })
        success()
    }
    
    func fetchNewsData(_ result:@escaping([NewsModel]) -> Void)
    {
        let realm = try! Realm()
        let newsModel = realm.objects(NewsListData_Tbl.self)

        var newsModelArr: [NewsModel] = []

        _ = Array(newsModel).map{ results in
            
            newsModelArr.append(NewsModel(id: results.id, publicationDate: results.publicationDate, newsTitle: results.newsTitle, newsThumbnail: results.newsThumbnail, newsBody: results.newsBody, newsURL: results.newsURL))
        }
        result(newsModelArr)
    }
    
    mutating func getNewsList(_ result:@escaping([NewsModel]) -> Void)
    {
        if ReachabilityManager.shared.isConnectedToNetwork() == false
        {
            fetchNewsData { newsResult in

                result(newsResult)
            }
            
        }
        else
        {
            getNewList { newsResult in
                result(newsResult)
            }
            
        }
    }
}
