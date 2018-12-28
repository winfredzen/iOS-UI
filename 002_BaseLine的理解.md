# Baseline的理解

在Interface Builder中的对齐中，有个`First BaseLines`的对齐

![First BaseLines](https://github.com/winfredzen/iOS-UI/blob/master/images/002.png)

创建2个UILabel，设置label2的First BaseLines对齐label1的First BaseLine，效果如下：

![First BaseLines - First BaseLine](https://github.com/winfredzen/iOS-UI/blob/master/images/003.png)

设置label2的Last BaseLines对齐label1的First BaseLine，效果如下：

![Last BaseLines - First BaseLine](https://github.com/winfredzen/iOS-UI/blob/master/images/004.png)

设置label2的Last BaseLines对齐label1的Last BaseLine，效果如下：

![Last BaseLines - LastBaseLine](https://github.com/winfredzen/iOS-UI/blob/master/images/005.png)



在开发的过程中，经常有不同的Font，需要底部对齐的情况，参考：[Align two labels vertically with different font size](https://stackoverflow.com/questions/30455159/align-two-labels-vertically-with-different-font-size)，可以使用2中方式解决：

- 属性字符串
- BaseLine对齐

其它参考：

- [Set top alignment for labels with different font sizes, Swift 3](https://stackoverflow.com/questions/45249666/set-top-alignment-for-labels-with-different-font-sizes-swift-3)



另外可参考：[Understanding “firstBaseLine” vs. “baseLine” AutoLayout Constraint](https://stackoverflow.com/questions/36188488/understanding-firstbaseline-vs-baseline-autolayout-constraint)

> NSLayoutAttributeBaseline
> The object’s baseline.
> Available in iOS 6.0 and later.
>
> NSLayoutAttributeFirstBaseline
> The object’s baseline. For objects with more than one line of text, this is the baseline for the topmost line of text.
> Available in iOS 8.0 and later.

![006](https://github.com/winfredzen/iOS-UI/blob/master/images/006.png)



在UIStackView中，也有这样的描述，参考：[First Baseline and Last Baseline Properties in UIStackView](https://stackoverflow.com/questions/33932846/first-baseline-and-last-baseline-properties-in-uistackview)



