//
//  ImageExtension.swift
//  LoveCat
//
//  Created by jingjun on 2020/12/11.
//

import Foundation
import UIKit
extension UIImage {
    /// 将颜色转换为图片
    ///
    /// - Parameter color: 需要转换的颜色
    /// - Returns: 返回一个UIImage 对象
    public class func image(_ color: UIColor) ->UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

}

public enum ImageType {
    case origin
    case thumbSeven
    case thumbFour
    case thumbnail
    case thumbThree
}

extension UIImageView: ETExtensionCompatible {

}
extension ET where Base: UIImageView {
    
    /// 添加水印
    func waterMark(_ image: UIImage,mark: String) -> UIImage?{
        let w = image.size.width
        let h = image.size.height
        UIGraphicsBeginImageContext(image.size)
        image.draw(in: CGRect(x: 0, y: 0, width: w, height: h))
        let att = NSAttributedString.init(string: mark, attributes: [NSAttributedString.Key.font : UIFont.et.font(size: 12),NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        let attSize = att.boundingRect(with: CGSize(width: CGFloat.infinity, height: 16), options: [.usesLineFragmentOrigin,.usesFontLeading], context: nil)
        att.draw(in: CGRect(x: w - (attSize.width + 10), y: h - (attSize.height + 10), width: attSize.width, height: attSize.height))
        let img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img
    }
}
