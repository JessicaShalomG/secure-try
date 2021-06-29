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


                 let gradient: CAGradientLayer = CAGradientLayer()

                 let to = UIColor(red: 0.07, green: 0.11, blue: 0.26, alpha: 1.00)
                 let color = UIColor(red: 0.24, green: 0.29, blue: 0.46, alpha: 1.00)

                 gradient.colors = [color.cgColor, to.cgColor]
                 gradient.locations = [0.0 , 1.0]
                 gradient.startPoint = CGPoint(x : 0.0, y : 0)
                 gradient.endPoint = CGPoint(x :0.0, y: 0.90)
                 gradient.frame = view.bounds

                 view.layer.insertSublayer(gradient, at: 0)


                 let yourLabel = UILabel(frame: CGRect(x: 80, y: 200, width: 100, height: 300))
                   yourLabel.textColor = UIColor(white: 1, alpha: 1)
                   yourLabel.font = UIFont(name: "Roboto-Regular", size: 50)
                   //yourLabel.text = "CUENCA LA ÚNICA CUENTA QUE NECESITAS"

                let paragraphStyle = NSMutableParagraphStyle()
                let stringValue = "CUENCA\nLA ÚNICA CUENTA\nlQUE NECESITAS"

                let attributedString = NSMutableAttributedString(string: stringValue)
                paragraphStyle.lineSpacing = 2 // Whatever line spacing you want in points
                attributedString.addAttribute(.paragraphStyle, value:paragraphStyle, range: NSRange(location: 0, length: stringValue.count))
                yourLabel.attributedText = attributedString;





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
