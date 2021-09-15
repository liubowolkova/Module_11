#  Skillbox iOS - 1 level - module 11 
![Swift](https://img.shields.io/badge/Swift-FA7343?style=for-the-badge&logo=swift&logoColor=white) ![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white) ![Git](https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white)

### Used equipment and software
![MacBook](https://img.shields.io/badge/Apple-laptop-999999?style=for-the-badge&logo=apple&logoColor=white)  intel core i5, 8GB RAM

![MacOs](https://img.shields.io/badge/mac%20os-000000?style=for-the-badge&logo=apple&logoColor=white)  version Big.Sur 11.5.2

![Xcode](https://img.shields.io/badge/Xcode-007ACC?style=flat-square&logo=Xcode&logoColor=white)  version 12.2

## Target - creation custom `UIView`-components
Usage `@IBDesignable` and `@IBInspectable`

## Custom components
### Button
``` swift
@IBDesignable public class Button: UIButton
```
![Button](./git_resources/Button.png)
### Clock
``` swift
@IBDesignable public class RoundBase: UIView
```
``` swift
@IBDesignable public class RoundClock: RoundBase
```
There is also custom arrow class which has been created with help of `CAShapeLayer` and `UIBezierPath`.
``` swift
public class Arrow: UIView
```
>Clock view should has **equal width** and **height** for being round
#### One arrow
![Clock with one arrow](./git_resources/clock_one_arrow.png)
#### Three arrows
![Clock with three arrows](./git_resources/clock_three_arrows.png)
>There is a bug when all arrows are displayed together, but every arrow work amazing by one

![Clock with three arrows bug](./git_resources/clock_three_arrow_bug.png)
### SegmentedControl
``` swift
@IBDesignable public class Segmented: UIView
```
>There is a bug with displaying setting properties in Interface Builder (for my version XCode and Mac), but **functionality works as expected**.

![Segmented](./git_resources/segmented.png)
### Warning
> Theese components aren't displayed expectedly together in Interface Builder. **Add** them into view **by one**.
