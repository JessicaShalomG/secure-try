import Flutter
import UIKit

public class SwiftSecureApplicationPlugin: NSObject, FlutterPlugin {
    var secured = false;
    var opacity: CGFloat = 0.2;
    internal let registrar: FlutterPluginRegistrar
    
    init(registrar: FlutterPluginRegistrar) {
        self.registrar = registrar
      super.init()
      registrar.addApplicationDelegate(self)
    }
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "secure_application", binaryMessenger: registrar.messenger())
    let instance = SwiftSecureApplicationPlugin(registrar: registrar)
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func applicationWillResignActive(_ application: UIApplication) {
    if ( secured ) {
        if let window = UIApplication.shared.windows.filter({ (w) -> Bool in
                   return w.isHidden == false
        }).first {
            if let existingView = window.viewWithTag(99699) {
                window.bringSubviewToFront(existingView)
                return
            } else {
                let view = UIView(frame: window.frame)
                view.tag = 99699
                // 1
                view.backgroundColor = UIColor(red: 0.33, green: 0.00, blue: 0.92, alpha: 1.00);
                // 2
                //let blurEffect = UIBlurEffect(style: .extraLight)
                // 3
               // let blurView = UIVisualEffectView(effect: blurEffect)
                // 4
                let imageName = "cuenca_icon.png"
                let image = UIImage(named: imageName)
                let imageView = UIImageView(image: image!)

                 let yourLabel = UILabel(frame: CGRect(x: 100, y: 200, width: 200, height: 200))
                   yourLabel.textColor = UIColor(white: 1, alpha: opacity)
                   yourLabel.numberOfLines = 3
               
                   yourLabel.text = "CUENCALA ÚNICA CUENTA QUE NECESITAS"


                imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 200)

                view.addSubview(yourLabel)

                //blurView.frame = view.bounds
                //view.addSubview(blurView)
                window.addSubview(view)
                window.bringSubviewToFront(view)
            }
        }
    }
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if (call.method == "secure") {
        secured = true;
        if let args = call.arguments as? Dictionary<String, Any>,
        let opacity = args["opacity"] as? NSNumber {
            self.opacity = opacity as! CGFloat
        }
    } else if (call.method == "open") {
        secured = false;
    } else if (call.method == "unlock") {
        if let window = UIApplication.shared.windows.filter({ (w) -> Bool in
                   return w.isHidden == false
        }).first, let view = window.viewWithTag(99699) {
            view.removeFromSuperview()
        }
    }
  }
}
