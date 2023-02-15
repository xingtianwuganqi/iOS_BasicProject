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
    case thumbHead
}

extension UIImageView: ETExtensionCompatible {
    
}
extension ET where Base: UIImageView {
    
    /// 添加水印
    public func waterMark(_ image: UIImage,mark: String) -> UIImage?{
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
    
    
    /// 图片压缩
    public func compressImage() -> Data {
        let imageSize = self.jpegData(compressionQuality: 1.0)!.count/1024
        var myImage = self
        if imageSize < 300 {
            // 如果小于300k,直接上传
            return myImage.jpegData(compressionQuality: 1.0)!
        } else {
            // 取短边
            let width = myImage.size.width > myImage.size.height ? myImage.size.height:myImage.size.width
            if width <= 1080 {
                // 大于300k短边小于1080，直接上传
                return myImage.jpegData(compressionQuality: 1)!
            } else {
                // 待压缩的Size
                var size: CGSize = CGSize.zero
                // 如果宽大于高
                if myImage.size.width > myImage.size.height {
                    size = CGSize.init(width: myImage.size.width*(1080/myImage.size.height), height: 1080)
                } else {
                    size = CGSize.init(width: 1080, height: myImage.size.height*(1080/myImage.size.width))
                }
                // 尺寸压缩
                UIGraphicsBeginImageContext(size)
                myImage.draw(in: CGRect.init(x: 0, y: 0, width: size.width, height: size.height))
                if let img = UIGraphicsGetImageFromCurrentImageContext() {
                    myImage = img
                }
                UIGraphicsEndImageContext()
                SDJGLog("width:\(myImage.size.width) height:\(myImage.size.height)")
                if myImage.jpegData(compressionQuality: 1.0)!.count/1024 >= 300{
                    // 尺寸压缩后还大于300k
                    for index in 1...7{
                        let rate = CGFloat(1) - 0.1*CGFloat(index)
                        let count = myImage.jpegData(compressionQuality: rate)!.count/1024
                        if count <= 300{
                            return myImage.jpegData(compressionQuality: rate)!
                        }
                        // 系数0.3仍然大于300k上传
                        if index == 7{
                            return myImage.jpegData(compressionQuality: rate)!
                        }
                    }
                }else{
                    // 尺寸压缩后还小于300k
                    return myImage.jpegData(compressionQuality: 1)!
                }
            }
        }
        return myImage.jpegData(compressionQuality: 1)!
    }
    
    /// 图片压缩（文件大小）
    /// - Parameter size: 最大文件大小
    /// - Parameter unit: 大小单位
    public func compressImageWithFileSize(size: Int, unit: String = "b") -> UIImage {
        var maxSize: Int = 0
        switch unit {
        case "b", "B":
            maxSize = size
            break
        case "k", "K":
            maxSize = size * 1000
            break
        case "m", "M":
            maxSize = size * 1000 * 1000
            break
        default:
            maxSize = size
            break
        }
        // 先压图片体积
        var imageData = self.jpegData(compressionQuality: 1.0)!
        var ratio: CGFloat = 1.0
        while imageData.count >= maxSize && ratio >= 0.05 {  //压
            ratio -= 0.05
            let  newImage = UIImage.init(data: imageData)
            imageData = newImage!.jpegData(compressionQuality: ratio)!
        }
        // 如果压图片之后未达到小于maxSize，则采用缩图片size
        if ratio < 0.05 {
            var sizeRatio: Float = 0.95
            while imageData.count >= maxSize && sizeRatio >= 0.5 { //缩
                imageData = UIImage(data: imageData)?.extCompressImage() ?? Data()
                sizeRatio -= 0.05
            }
        }
        return UIImage(data: imageData)!
    }
    
    /// 合成两张图片
    public func compoundImage(otherImage: UIImage)-> UIImage{
        let size = self.size
        let otherBounds = size.width > size.height ? size.height/2 : size.width/2
        UIGraphicsBeginImageContext(size)
        self.draw(in: CGRect.init(x:0, y:0, width:size.width, height:size.height))
        otherImage.draw(in: CGRect.init(x:size.width/2-otherBounds/2, y:size.height/2-otherBounds/2, width:otherBounds, height:otherBounds))
        let resultingImage = UIGraphicsGetImageFromCurrentImageContext()
        return resultingImage!
    }
}
