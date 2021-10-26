//
//  TrailImageView.swift
//  Test
//
//  Created by Solution Cat on 26/10/21.
//

import UIKit

protocol TriImageViewDelegate: class {
    func didTapImage(image: UIImage)
}

class TriImageView: UIView {

    //assumption: view width = 2 x view height

    var images = [UIImage]()

    var delegate:TriImageViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        images.append(UIImage(named: "img")!)
        images.append(UIImage(named: "img1")!)
        images.append(UIImage(named: "img2")!)
        //add imageviews
        for i in 1...3 {
            let imageView = UIImageView()
            imageView.tag = i
            //imageView.image = images[i - 1]
            imageView.isUserInteractionEnabled = true
            self.addSubview(imageView)
        }

        //add gesture recognizer
       // self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TriImageView.handleTap(_:))))

    }

    //override drawRect
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        let width = rect.size.width
        let height = rect.size.height
        let frame = CGRect(x: 0, y: 0, width: width, height: height)

        let pointA = CGPoint(x: 0, y: 0)
        let pointB = CGPoint(x: width * 0.79, y: 0)
        let pointC = CGPoint(x: width, y: 0)
        let pointD = CGPoint(x: width * 0.534,y: height * 0.29)
        let pointE = CGPoint(x: 0, y: height * 0.88)
        let pointF = CGPoint(x: 0, y: height)
        let pointG = CGPoint(x: width * 0.874, y: height)
        let pointH = CGPoint(x: width, y: height)

        let path1 = [pointA,pointB,pointD,pointE]
        let path2 = [pointE,pointD,pointG,pointF]
        let path3 = [pointB,pointC,pointH,pointG,pointD]

        let paths = [path1,path2,path3]

        for i in 1...3 {
            let imageView = (self.viewWithTag(i) as! UIImageView)
            imageView.image = images[i - 1]
            imageView.frame = frame
            addMask(view: imageView, points: paths[i - 1])
        }

    }

    //Add mask to the imageview
    func addMask(view: UIView, points:[CGPoint]){

        let maskPath = UIBezierPath()
        maskPath.move(to: points[0])

        for i in 1..<points.count {
            maskPath.addLine(to: points[i])
        }

        maskPath.close()

        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        view.layer.mask = maskLayer

    }

    //handle tap
    func handleTap(recognizer:UITapGestureRecognizer){

        let point = recognizer.location(in: recognizer.view)

        for i in 1...3 {
            let imageView = (self.viewWithTag(i) as! UIImageView)
            let layer = (imageView.layer.mask as! CAShapeLayer)
            let path = layer.path
        }



    }

}
