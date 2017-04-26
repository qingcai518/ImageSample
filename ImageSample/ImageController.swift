//
//  ImageController.swift
//
//  Created by 李慶燦 on 2017/04/26.
//  Copyright © 2017年 李慶燦. All rights reserved.
//

import UIKit

class ImageController: UIViewController {
	@IBOutlet var scrollView: UIScrollView!

	var image: UIImage?
	var imageView = UIImageView()
    let screenSize = UIScreen.main.bounds.size

	override func viewDidLoad() {
		super.viewDidLoad()

		setScrollInfo()
		setImageInfo()
	}

	private func setScrollInfo() {
		scrollView.delegate = self
		scrollView.minimumZoomScale = 1
		scrollView.maximumZoomScale = 3
		scrollView.showsHorizontalScrollIndicator = false
		scrollView.showsVerticalScrollIndicator = false
		scrollView.isScrollEnabled = true
	}

	private func setImageInfo() {
		imageView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
		imageView.contentMode = .scaleAspectFit
		imageView.clipsToBounds = true
		imageView.backgroundColor = UIColor.black
		imageView.isUserInteractionEnabled = true
		imageView.image = image

		// 双击图片扩大.
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(doDoubleTap(recognizer :)))
		doubleTapGesture.numberOfTapsRequired = 2

		// 点击图片关闭.
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(doClose))
		singleTapGesture.numberOfTapsRequired = 1

		// 允许点双击混在.
		singleTapGesture.require(toFail: doubleTapGesture)

		imageView.addGestureRecognizer(doubleTapGesture)
		imageView.addGestureRecognizer(singleTapGesture)

		scrollView.addSubview(imageView)
	}

    func doDoubleTap(recognizer: UITapGestureRecognizer) {
		if (scrollView.zoomScale < scrollView.maximumZoomScale) {
			let centerPoint = CGPoint(x: screenSize.width / 2, y: screenSize.height / 2)
			let zoomRect: CGRect = self.zoomRectForScale(scale: scrollView.zoomScale * 3, center: centerPoint)
			scrollView.zoom(to: zoomRect, animated: true)
		} else {
			scrollView.setZoomScale(1.0, animated: true)
		}
	}
    
    func doClose() {
        self.dismiss(animated: true, completion: nil)
    }

	private func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
		var zoomRect: CGRect = CGRect()
		zoomRect.size.height = scrollView.frame.size.height / scale
		zoomRect.size.width = scrollView.frame.size.width / scale

		zoomRect.origin.x = center.x - zoomRect.size.width / 2.0
		zoomRect.origin.y = center.y - zoomRect.size.height / 2.0

		return zoomRect
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
}

extension ImageController: UIScrollViewDelegate {
	func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
		return imageView
	}
}
