//
//  AusbinVcDelegate.swift
//  Ausbin
//
//  Created by bin on 2018/12/24.
//  Copyright © 2018年 BinHuang. All rights reserved.
//
import UIKit
@objc public protocol AusbinVcDelegate : NSObjectProtocol{
    func asb_initViewActions();
    func asb_handleViewActions(_ sender: UIView);
    func asb_refreshViews(fullKeyPath: String?);
}
