//
//  DemoViewController.swift
//  AusbinDemo
//
//  Created by huangzhibin on 2019/07/04
//

import UIKit
import Ausbin

class DemoViewController: UIViewController {

    var vcRouter : AusbinVcRouter!;
    var vcView : DemoVcView!;
    var vcModel : DemoVcModel!;

    override func viewDidLoad() {
        super.viewDidLoad();

        self.view.backgroundColor = UIColor.white;

        self.vcView = DemoVcView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height));
        self.view.addSubview(self.vcView);

        self.vcModel = DemoVcModel();

        self.vcRouter = AusbinVcRouter.init(vcModel: self.vcModel);
        self.vcRouter.delegate = self;
        self.vcRouter.asb_startRouter();
    }

    deinit {
        self.vcRouter.asb_deinitRouter();
    }

}

// MARK: - AusbinVcDelegate
extension DemoViewController: AusbinVcDelegate{
    func asb_initViewActions(){
        self.vcView.button.addTarget(self, action: #selector(self.asb_handleViewActions(_:)), for: .touchUpInside);
    }

    func asb_handleViewActions(_ sender: UIView) {
        if(sender == self.vcView.button){
            self.vcModel.log1 = "It's \(Date().timeIntervalSince1970)";
        }
    }

    func asb_refreshViews(fullKeyPath: String?) {
        if(fullKeyPath == #keyPath(DemoVcModel.log1)){
            self.vcView.button.setTitle(self.vcModel.log1, for: .normal);
        }
    }
}
