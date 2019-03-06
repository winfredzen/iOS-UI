# UIPresentationController

一般的present某个控制器时，动画效果总是从上到下，非常的单一

通过使用UIPresentationController可以创造出非常酷的动画

[UIPresentationController](https://developer.apple.com/documentation/uikit/uipresentationcontroller)用来管理presention控制的过渡动画

一个控制器被presented直至dismissed，UIKit使用一个presentation控制器来管理该控制器展示过程的各个方面。presentation控制器可以添加动画、可以响应size改变

当设置控制器的`modalPresentationStyle`属性为[`UIModalPresentationStyle.custom`](https://developer.apple.com/documentation/uikit/uimodalpresentationstyle/custom)时，可以提供一个自定义的presentation控制器



## 自定义Presentation

- 当一个控制器即将被presented，UIKit调用presentation控制器的 [`presentationTransitionWillBegin()`](https://developer.apple.com/documentation/uikit/uipresentationcontroller/1618330-presentationtransitionwillbegin)方法。可以使用这个方法将view添加到view层级中，并设置相关的动画
- 在presentation结束的时候，UIKit调用[`presentationTransitionDidEnd(_:)`](https://developer.apple.com/documentation/uikit/uipresentationcontroller/1618327-presentationtransitiondidend) 方法



## 响应Size Class改变

各种设备的Size Class可参考:[Adaptivity and Layout](https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/)



## 继承

继承UIPresentationController，在初始化的过程中需要调用[`init(presentedViewController:presenting:)`](https://developer.apple.com/documentation/uikit/uipresentationcontroller/1618328-init) 方法，这是这个类的指定初始化器

可重写的方法：

-  [`presentationTransitionWillBegin()`](https://developer.apple.com/documentation/uikit/uipresentationcontroller/1618330-presentationtransitionwillbegin)添加自定义的view到view层级中。如果view controller 不能被展示，可以在 [`presentationTransitionDidEnd(_:)`](https://developer.apple.com/documentation/uikit/uipresentationcontroller/1618327-presentationtransitiondidend)中移除
- [`dismissalTransitionWillBegin()`](https://developer.apple.com/documentation/uikit/uipresentationcontroller/1618342-dismissaltransitionwillbegin)方法执行dismissal动画，在[`dismissalTransitionDidEnd(_:)`](https://developer.apple.com/documentation/uikit/uipresentationcontroller/1618323-dismissaltransitiondidend) 方法中移除自定义的view
- 使用[`viewWillTransition(to:with:)`](https://developer.apple.com/documentation/uikit/uicontentcontainer/1621466-viewwilltransition) 方法执行size-related的改变

也可以重写 [`shouldPresentInFullscreen`](https://developer.apple.com/documentation/uikit/uipresentationcontroller/1618336-shouldpresentinfullscreen) 或者[`frameOfPresentedViewInContainerView`](https://developer.apple.com/documentation/uikit/uipresentationcontroller/1618337-frameofpresentedviewincontainerv) 方法，返回非默认值

使用的时候，一般要设置被展示view controller的transitioningDelegate和modalPresentationStyle属性，如下的例子：

```swift
      //设置transitioningDelegate代理
      controller.transitioningDelegate = slideInTransitioningDelegate
      controller.modalPresentationStyle = .custom
```

[UIViewControllerTransitioningDelegate](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioningdelegate)代理的方法：

```swift
func presentationController(forPresented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController?
```

在这个方法中返回自定义的UIPresentationController

```
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?
  
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
```

上面的2个方法，定义了present和dismiss动画

如果要自定义动画，要实现[UIViewControllerAnimatedTransitioning](https://developer.apple.com/documentation/uikit/uiviewcontrolleranimatedtransitioning)协议



## Demo例子

1.[UIPresentationController Tutorial: Getting Started](https://www.raywenderlich.com/915-uipresentationcontroller-tutorial-getting-started)

![效果1](https://github.com/winfredzen/iOS-UI/blob/master/images/007.gif)

2.[THE ROLE OF THE PRESENTATION CONTROLLER](https://www.shinobicontrols.com/blog/ios8-day-by-day-day-24-presentation-controllers/)

![效果1](https://github.com/winfredzen/iOS-UI/blob/master/images/008.gif)