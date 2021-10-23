//
//  Extensions.swift
//  The Guardian
//
//  Created by STS304-ELAVARASAN K on 23/10/21.
//

import UIKit

extension UIImageView
{
    func makeRounded(cornerRadius: CGFloat)
    {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
    
    func loadURLImage(urlStr: String)
    {
        if let url = URL(string: urlStr)
        {
            var data = Data()
            do
            {
                data = try Data(contentsOf: url)
                self.image = UIImage(data: data)
            }
            catch
            {
                print("\(error)")
            }
        }
    }
}

extension NSAttributedString
{
    internal convenience init?(html: String) {
        guard let data = html.data(using: String.Encoding.utf16, allowLossyConversion: false) else {
            // not sure which is more reliable: String.Encoding.utf16 or String.Encoding.unicode
            return nil
        }
        guard let attributedString = try? NSMutableAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) else {
            return nil
        }
        self.init(attributedString: attributedString)
    }
}
