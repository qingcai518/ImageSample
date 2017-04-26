//
//  SampleController.swift
//  ImageSample
//
//  Created by 李慶燦 on 2017/04/26.
//  Copyright © 2017年 李慶燦. All rights reserved.
//

import UIKit

class SampleController: UIViewController {
    @IBOutlet weak var imgView : UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let recognizer = UITapGestureRecognizer(target: self, action: #selector(toNext))
        imgView.addGestureRecognizer(recognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func toNext() {
        let storyboard = UIStoryboard(name: "Image", bundle: nil)
        guard let next = storyboard.instantiateInitialViewController() as? ImageController else {
            return
        }
        
        next.image = imgView.image
        present(next, animated: true, completion: nil)
    }
}

