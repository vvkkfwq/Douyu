//
//  HomeViewController.swift
//  DYZB
//
//  Created by Vickey Feng on 2020/6/14.
//  Copyright © 2020 Vickey Feng. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //设置UI界面
        setUpUI()
    }

}

//MARK:- 设置UI界面
extension HomeViewController {
    private func setUpUI(){
        //1.设置导航栏
        setUpNavigationBar()
    }
    
    private func setUpNavigationBar(){
        
        //设置logo
        let btn = UIButton()
        btn.setImage(UIImage(named: "logo"), for: .normal)
        btn.sizeToFit()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        
        //设置右侧icon
        let size = CGSize(width: 40, height: 40)
        
        let historyItem = UIBarButtonItem(imageName: "image_my_history", hightImageName: "image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", hightImageName: "btn_search_click", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", hightImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
        
    }
}
