//
//  PageTitle.swift
//  DYZB
//
//  Created by Vickey Feng on 2020/6/15.
//  Copyright © 2020 Vickey Feng. All rights reserved.
//

import UIKit

class PageTitleView: UIView {
    
    //MARK: -定义属性
    private var titles : [String]
    
    //MARK：-懒加载属性
    private lazy var titleLabels : [UILabel] = [UILabel]()
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    //MARK: -懒加载滚动横条
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    //MARK: -自定义构造函数
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        
        super.init(frame: frame)
        
        //设置UI界面
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: -设置UI界面
extension PageTitleView {
    private func setUpUI() {
        
        
        //添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //不需要调整UIScrollView的内边距
        scrollView.contentInsetAdjustmentBehavior = .never
        
        //添加title对应的label
        setUpTitleLabels()
        
        //设置底线和滚动滑块
        setUpBottomLineAndScrollLine()
    }
    
    private func setUpTitleLabels() {
        for (index, title) in titles.enumerated() {
            //创建UILabel
            let label = UILabel()
            
            //设置Label属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            //设置label的frame
            let labelW : CGFloat = frame.width / CGFloat(titles.count)
            let labelH : CGFloat = frame.height - 2
            let labelX : CGFloat = labelW * CGFloat(index)
            let labelY : CGFloat = 0
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //将label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
        }
    }
    
    private func setUpBottomLineAndScrollLine() {
        //添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
    
        //添加ScrollLine
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor.orange
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - 2, width: firstLabel.frame.width, height: 2)
    }
    
}
