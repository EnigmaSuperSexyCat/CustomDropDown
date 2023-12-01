//
//  SelfResizingTableView.swift
//  DropDown
//
//  Created by 임현규 on 2023/12/01.
//  Copyright © 2023 Kevin Hirsch. All rights reserved.
//

import UIKit

open class SelfResizingTableView: UITableView {
    public var tableViewSizeUpdated: ((CGFloat) -> ())?
    public var beforeHeight: Int = 0
    
    /**
     컨텐츠의 크기가 변경되었을 때 호출되는 프로퍼티입니다.
     */
    public override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
            self.setNeedsLayout()
            DispatchQueue.main.async {
                if self.beforeHeight != Int(self.contentSize.height) {
                    self.beforeHeight = Int(self.contentSize.height)
                    self.tableViewSizeUpdated?(self.contentSize.height)
                    return
                }
            }
        }
    }
    
    /**
     인트린직 컨텐츠 크기를 반환하는 프로퍼티입니다.
     */
    public override var intrinsicContentSize: CGSize {
        return self.contentSize
    }
}


