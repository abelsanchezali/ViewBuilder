# ViewBuilder

View Builder Project is a XML document based declarative way for building an user interface in iOS. With is own built-in layout engine.

# Features

  - First fully declarative XML documents for building any objects in iOS.
  - Custom layout engine, 4X more performant than autolayout.
  - Built-in support for Resources, Styles, View Templates and more.
  - Gradients and SVG Vector Graphics support.

You can easily:
  - Have all your resources and reuse them anywhere. 
  - Define object styles that you can freely apply.
  - Having view templates will help you to be more productive.
  - Use any custom object in your documents and extend document language. 

Documents are handled with performance in mind. They are cached and automatically evicted by default. Having concepts like mutability help to optimize string parsing.


## Examples

To start will be cool to watch this [video][demovideo].

**Creating some resources**
```xml
<?xml version="1.1" encoding="UTF-8"?>
<d:Content xmlns:d="@framework" xmlns="com.apple.UIKit">
    <d:Resources>
        <d:Item name="font" value="d:Font(name: AvenirNext-Regular, size:14)"/>
        <d:Item name="color" value="d:Color(#FEFEFE)"/>
        <d:Item name="text" value="This is a text"/>
    </d:Resources>
</d:Content>
```

**Some sample view**

*Defining a scrollable section that will contain a label*
```xml
<?xml version="1.1" encoding="UTF-8"?>
<d:Content xmlns:d="@framework" xmlns="com.apple.UIKit">
    <d:ScrollPanel backgroundColor="d:Color(White)" contentInset="d:EdgeInsets(0)" directionalLockEnabled="true">
        <UILabel d:name="contentLabel" numberOfLines="0" margin="d:EdgeInsets(8)" maximumSize="d:Size(2048, -1)"/>
    </d:ScrollPanel>
</d:Content>
```

**Using some of those resources is very easy**

```xml
<?xml version="1.1" encoding="UTF-8"?>
<d:Content xmlns:d="@framework" xmlns="com.apple.UIKit">
    <d:Resources path="d:PathFromBundle(SomeResources.xml)"/>
    <UILabel text="@text" font="@font" textColor="@color"/>
</d:Content>
```

**How I get all that from code**
```swift
let path = Constants.bundle.path(forResource: "SampleView.xml")!
let view = DocumentBuilder.shared.load(path)
```

**Having references to any object in document will be like**

All named nodes could be accessed using `documentReferences` attached property.
```swift
let label = container.documentReferences!["contentLabel"] as! UILabel
```

**How to create a UIViewController binded to a document**

Since `UIViewController.loadView()` function handle custom view creations. We only need to override this function, but remember never calling it's super implementation.
```swift
override func loadView() {
  view = DocumentBuilder.shared.load(Bundle.main.path(forResource: "View", ofType: "xml")!)
}
```
in Objective-C:
```m
- (void) loadView {
    self.view = [[DocumentBuilder shared] loadView:[[NSBundle mainBundle] pathForResource: @"View" ofType: @"xml"] options: nil];
}
```

***How to create a custom view from a document***

Could be done in several ways. One is as we show before to load a view from a document insert this as a child view and access it's named element from `documentReferences` property.

Another approach is to create a subview class and load it using `UIView.loadFromDocument` extension.

```swift
public class CustomView: StackPanel {
    init() {
        super.init(frame: CGRect.zero)
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    private func initialize() {
        loadFromDocument(Bundle.main.path(forResource: "CustomView", ofType: "xml")!)
    }
}
```

and define it's content in a document:

```xml
<?xml version="1.1" encoding="UTF-8"?>
<d:Content xmlns:d="@framework" xmlns="com.apple.UIKit" xmlns:m="@document">
    <d:StackPanel backgroundColor="d:Color(#CCCCCC)"
                  borderColor="d:Color(#EEEEEE)"
                  borderWidth="1.0"
                  shadowOpacity="0.5"
                  shadowOffset="d:Size(0,0)"
                  shadowRadius="4"
                  cornerRadius="8">
        <UILabel numberOfLines="0"
                 text="This is a text on screen using an UILabel"
                 textAlignment="d:TextAlignment(Center)"
                 horizontalAlignment="d:Alignment(Stretch)"
                 margin="d:EdgeInsets(8)"/>
        <UIButton title="d:StringForState(Tap me)"
                  horizontalAlignment="d:Alignment(Center)"
                  margin="d:EdgeInsets(8)"/>
    </d:StackPanel>
</d:Content>
```

It's important to mention that content node should be same type as `CustomView` parent class `StackPanel`.


## Layout Engine

ViewBuilder is provided with a built-in layout engine. Comparing layouts could be very hard but having some metrics will be helpful to understand what work better to you.

* **Productivity** - How much effort is needed to build and define UI elements. 
* **Performance** - How faster is done the measurement/layout/rendering process.
* **Learning Curve** - How easy to learn and to use is that technology.
* **Readability** - How easy is to review, it's diff compatible, etc.
* **Flexibility** - How easy is to modify, customize and extend.

Here some existing layout engines compared together with our PanelLayout:

|  | AutoLayout | ManualLayout | LayoutKit | *PanelLayout* |
| - | - | - | - | - |
| *Productivity* | 5 | 1 | 4 | 5 |
| *Performance* | 2 | 5 | 5 | 5 |
| *Learning* | 3 | 5 | 3 | 4 |
| *Readability* | 1 | 3 | 3 | 5 |
| *Flexibility* | 3 | 5 | 3 | 5 |

*Is important to hightlight that those numbers are not proportional to results*

## Document

## Extension

## Cocoapods

Adding dependency will be just including `ViewBuilder` pod. Remember to add `use_frameworks` to podfile since ViewBuilder is implemented as a framework in swift.

```podfile
use_frameworks!

  pod 'ViewBuilder', '~> 0.0.1'
```

## Todos

 - Write MORE Tests
 - And so much more

## License

MIT

**Free Software, Hell Yeah!**

[//]: # (These are reference links used in the body)

   [demovideo]: <https://www.youtube.com/watch?v=n8bfS0tZYJM>
