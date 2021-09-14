#  Skillbox iOS - 1 level - module 11 

## Target - creation custom UIView-components
Usage @IBDesignable and @IBInspectable

## Custom components
### Button
``` swift
@IBDesignable public class Button: UIButton
```

### Clock
``` swift
@IBDesignable public class RoundBase: UIView
@IBDesignable public class RoundClock: RoundBase
```
There is also custom arrow class which has been created with help of CAShapeLayer and UIBezierPath.
``` swift
public class Arrow: UIView
```
>Clock view should has equal width and height for being round
#### One arrow

#### Three arrows
>There is a bug when all arrows are displayed together, but every arrow work amazing by one

### SegmentedControl
``` swift
@IBDesignable
public class Segmented: UIView
```
### Warning
> Theese components aren't displayed together in Interface Builder
