//
//  NewsModel.swift
//  The Guardian
//
//  Created by Pyramid on 23/10/21.
//

import Foundation

//MARK: - Model
struct NewsModel
{
    let id: String
    let publicationDate: String
    let newsTitle: String
    let newsThumbnail: String
    let newsBody: String
    let newsURL: String
    let newsThumbnailImgData: Data
}
