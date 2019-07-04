//
//  DemoVcView.swift
//  AusbinDemo
//
//  Created by huangzhibin on 2019/07/04
//

import UIKit

class DemoVcView: UIView {

    var button : UIButton!;

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.initViews();
    }

    func initViews(){
        self.backgroundColor = UIColor.white;

        let button = UIButton.init(type: .system);
        button.frame = CGRect.init(x: 40, y: 40, width: 260, height: 100);
        button.setTitle("this is button", for: .normal);
        self.addSubview(button);
        self.button = button;
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
