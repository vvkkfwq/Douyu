//
//  PageContentView.swift
//  DYZB
//
//  Created by Vickey Feng on 2020/6/15.
//  Copyright © 2020 Vickey Feng. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(contentView : PageContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {

    //MARK: -定义属性
    private var childVcs: [UIViewController]
    private weak var parentViewController : UIViewController?
    private var startOffsetX: CGFloat = 0
    private var isForbidScrollDelegate : Bool = false
    weak var delegate : PageContentViewDelegate?
    
    //MARK: -懒加载属性
    private lazy var collectionView : UICollectionView = {[weak self] in
        //创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout:layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollsToTop = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()
    
    
    //MARK: -自定义函数
    init(frame: CGRect, childVcs : [UIViewController], parentViewController : UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        
        //设置UI
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
	
//MARK:- 设置UI界面
extension PageContentView {
    private func setUpUI(){
        //将所有的子控制器添加到控制器中
        for childVc in childVcs {
            parentViewController?.addChild(childVc)
        }
        
        //添加UICollectionView用于Cell存放控制器View
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

//MARK:-遵守UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        //给cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}

//MARK: -遵守UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isForbidScrollDelegate {return}
        
        //获取需要的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        //判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX { //左滑
            //计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            //计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            //计算targetIndex
            targetIndex = sourceIndex + 1
                if targetIndex >= childVcs.count {
                    targetIndex = childVcs.count - 1
                }
            
            //完全滑过去
            if currentOffsetX - startOffsetX  == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
            
        }else { //右滑
            //计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            //计算sourceIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            //计算targetIndex
            sourceIndex = targetIndex + 1
                if sourceIndex >= childVcs.count {
                    sourceIndex = childVcs.count - 1
                }
        }
        
        //将progress/sourceIndex/targetIndex传递给titleView
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
}

//MARK: -对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentindex : Int) {
        
        isForbidScrollDelegate = true
        let offsetX = CGFloat(currentindex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
