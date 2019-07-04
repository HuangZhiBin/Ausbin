//
//  AusbinVcRouter.swift
//  Ausbin
//
//  Created by bin on 2018/12/27.
//  Copyright © 2018年 BinHuang. All rights reserved.
//

import UIKit

@objc public class AusbinVcRouter: NSObject{
    
    private var isDebug : Bool = true;//是否显示log
    
    private var vcData : Any!;
//    private weak var vcService : NSObject!;
//    private weak var vcView : UIView!;//vcView实例，定义为weak防止强制持有
    
    public weak var delegate : AusbinVcDelegate?{
        didSet{
            self.delegate?.asb_initViewActions();
        }
    }
    
    @objc public init(vcModel: NSObject) {
        super.init();
        
        self.vcData = vcModel;
    }
    
    required init(coder aDecoder: NSCoder?) {
        super.init();
    }
    
    //MARK: - 开始监听vcModel的数据改变(-KVC)
    @objc public func asb_startRouter(){
        //MARK: - 开始监听vcModel的数据改变(+KVC)
        self.addRouterObserver(vcModel: self.vcData as AnyObject);
    }
    
    //MARK: - 解除监听vcModel的数据改变(-KVC)
    @objc public func asb_deinitRouter(){
        self.removeRouterObserver(vcModel: self.vcData as AnyObject);
    }
    
    //MARK: - KVC 监听Model变化->刷新View
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //print(keyPath);
        //self.asb_handleKeyPathChange(keyPath: keyPath, object: object);
        
        let fullKeyPath = (self.vcData as! NSObject).asb_vc_model_getFullKeyPath(object: object, keyPath: keyPath);
        
        if((self.delegate) != nil){
            (self.delegate)?.asb_refreshViews(fullKeyPath: fullKeyPath);
        }
        else{
            fatalError("VC is not implemented to AusbinVcDelegate");
        }
    }
    
    private func addRouterObserver(vcModel : AnyObject){
        let obj = vcModel;
        if(obj is NSNull){
            return;
        }
//        print("ProjectName="+ProjectName);
        let properties : [String:String] = (obj as! NSObject).asb_getProperties() ?? [:];
        for property in properties{
            let propertyName = property.key;
            let typeName = property.value;
            
            //print("> [propertyName]="+propertyName + " [typeName]="+typeName);
            if(AusbinModelUtil.isModel(typeName: typeName)){
                //print("<=====");
                self.addRouterObserver(vcModel: obj.value(forKey: propertyName) as AnyObject);
            }
            obj.addObserver(self, forKeyPath:propertyName , options: .new, context: nil);
            if(isDebug){
                print("[Ausbin] ⭕️ add Observer for propertyName [" + propertyName + "]");//➕➖♥️
            }
        }
    }
    
    private func removeRouterObserver(vcModel : AnyObject){
//        let ProjectName : String = Bundle.main.infoDictionary!["CFBundleExecutable"]! as! String;
        let obj = vcModel;
        if(obj is NSNull){
            return;
        }
        let properties : [String:String] = (obj as! NSObject).asb_getProperties() ?? [:];
        for property in properties{
            let propertyName = property.key;
            let typeName = property.value;
            if(AusbinModelUtil.isModel(typeName: typeName)){
                //print("<=====");
                self.removeRouterObserver(vcModel: obj.value(forKey: propertyName) as AnyObject);
            }
            obj.removeObserver(self, forKeyPath:propertyName , context: nil);
            if(isDebug){
                print("[Ausbin] ❌ remove Observer for propertyName [" + propertyName + "]");
            }
            
        }
    }

}
