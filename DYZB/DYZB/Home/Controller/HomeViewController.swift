//
//  HomeViewController.swift
//  DYZB
//
//  Created by Vickey Feng on 2020/6/14.
//  Copyright © 2020 Vickey Feng. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK：-懒加载属性
    private lazy var pageTitleView: PageTitleView = {
        let titleFrame = CGRect(x: 0, y: 90, width: kScreenW, height: 40)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    private lazy var pageContentView : PageContentView = {[weak self] in
        
        //确定内容的frame
        let contentFrame = CGRect(x: 0, y: 130, width: kScreenW, height: kScreenH - kStatusBarh - kNavigationBarh - 150)
        
        //确定所有的子控制器
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        for _ in 0..<3 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()
    
    //MARK：-系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置UI界面
        setUpUI()
        
    }

}

//MARK:- 设置UI界面
extension HomeViewController {
    private func setUpUI(){
        
        //设置导航栏
        setUpNavigationBar()
        
        //设置TitleView
        view.addSubview(pageTitleView)
        
        //添加ContentView
        view.addSubview(pageContentView)
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

//MARK: -遵守PageTileViewDelegate协议
extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentindex: index)
    }
}

//MARK: -遵守PageContentViewDelegate协议
extension HomeViewController : PageContentViewDelegate {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex : sourceIndex, targetIndex: targetIndex)
    }
}
