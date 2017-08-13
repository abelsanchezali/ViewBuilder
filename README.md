# ViewBuilder

View Builder Project is a XML document base declarative way for building any user interface in iOS. With is own built-in layout engine. 

# Features

  - First fully declarative XML documents for building any objects in iOS.
  - Custom layout engine, 4X more performant than autolayout.
  - Built-in support for Resources, Styles, View Templates and more.
  - Gradients and SVG Vector Graphics support.

You can easily:
  - Have all your resources and reuse them andanywhere. 
  - Define object styles that you can freely apply.
  - Have view templates will help you to be more productive.
  - Use any custom object in your documents and extend document language. 

Documents are handled with performance in mind. They are cached and automatically evicted by default. Having concepts like mutability that help to optimize string parsing.

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

## Layout Engine

ViewBuilder is provided with a built-in layout engine. Comparing layouts could be very hard but having some metrics will be helpful to understand what work better to you.

* **Productivity** - How much effort is needed to build and define UI elements. 
* **Performance** - How faster is done the measurement/layout/rendering process.
* **Learning Curve** - How easy to learn and to use is that technology.
* **Readability** - How easy is to review, its diff compatible, etc.
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

## Todos

 - Write MORE Tests
 - And so much more

## License

MIT

**Free Software, Hell Yeah!**

[//]: # (These are reference links used in the body)

   [demovideo]: <https://www.youtube.com/watch?v=n8bfS0tZYJM>
