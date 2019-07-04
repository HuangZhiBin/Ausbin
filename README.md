# Ausbin
基于数据驱动的Swift框架(KVO)。Ausbin is an Swift KVO-driven framework
PS: 业务再多也不怕啦~

![](http://wxtopik.oss-cn-shanghai.aliyuncs.com/app/images/ausbin.png)

### 推荐使用数据驱动框架的原因
- 在iOS的开发过程中，我们将ViewController（以下简称VC）区分不同的功能页面
- vc的代码包括了view的创建和刷新、数据的访问、以及VC间的跳转
- 为了快速完成业务，将所有view、model的操作写在VC里面，随着业务的深入，代码的维护成本越来越高
- MVC解决了业务分层的需要，但存在的缺点较为明显，view与model之间的操作过于直接，导致业务混杂，还会造成数据不一致的情况
- 前端的VUE/react框架提供了基于数据驱动的框架思想，分离了model和view，引入了中间层，作为model和view之间相互信任的媒介，在model数据更新时通知view进行UI刷新，以及接收view的UI触发事件对model进行数据的更新
- 数据驱动框架的优点在于view、model各司其职，view的代码只需处理前端UI的渲染与交互，而不直接操作model数据。可以由独立的service处理业务逻辑，对model进行数据的更新
- view与model之间动态绑定，由model决定view的显示，而model也可以根据view的交互做出相应的处理，两者的交互由中间件完成，实现业务的解耦

### 系统语言要求
`version >= Swift4.0`

### 基于Ausbin的最简单的例子
以一个最简单的Sample作为例子，分析一下Ausbin的运行过程。下面是Sample这个vc的目录结构（具体参考/Ausbin/Demo）, Demo的文件夹里面有3个文件:

+ **DemoViewController.swift**
	> VC代码

+ **DemoVcModel.swift**
	> VC的model，数据持久层，存储数据

+ **DemoVcView.swift**
	> VC的view，视图层，只负责UI相关的业务

##### 代码分析
###### DemoViewController.swift
ViewController代码简洁，没有额外的特殊操作。
- 在`viewDidLoad()`初始化vcRouter
- 在`deinit()`时清除初始化vcRouter

```swift
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
```

###### （2）DemoVcModel.swift

vcModel需要注意的是，变量需要加入objc特性`@objc dynamic`实现KVC。

```swift
class DemoVcModel: NSObject {
    
    // 必须为变量添加objc特性支持KVC:@objc dynamic
    @objc dynamic var log1 : String! = "这是最初始的值:0";
    
}
```

| Item      | Value |
| --------- | -----:|
| 作者  | **黄智彬** |
| 原创  | **YES** |
| 微信  | **ikrboy** |
| 邮箱  |   **ikrboy@163.com** |
