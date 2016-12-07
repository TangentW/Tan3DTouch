# Tan3DTouch
个人博文《iOS-3D Touch 特性 &amp; API 详解》的参考代码
文章链接： [iOS-3D Touch 特性 &amp; API 详解](http://tangent.gift/2016/06/04/iOS-3D-Touch-%E7%89%B9%E6%80%A7-API-%E8%AF%A6%E8%A7%A3/)

# iOS-3D Touch 特性 & API 详解
## 前言
### 关于这篇文章
由于iPhone 6S发布不到一年的时间，很多新特性、新技术还未普遍，不管是`3D Touch`的使用还是开发，对其有相关了解的人并不多。前几天偶然接触了`3D Touch`的某个API接口，为了满足好奇心，于是我就系统地去了解了这个苹果的新技术。查阅了相关的官方文档，敲了些Demo，并编写了这篇文章，作为总结。
### 从Force Touch到3D Touch
使用过新版Mac Book或Apple Watch的朋友应该对`Force Touch`这个词汇并不陌生，这是苹果针对设备触控操作的一项新的技术，将传统的用户触控点击操作扩展化，加上了按压操作，设备可根据用户手指在屏幕上的按压力度来进行相应的响应。在新版Mac Book以及Apple Watch中，我们可以通过使用不同的力度按压触控板或触控屏来调出更多的控制选项，人机交互性非常高。
`3D Touch`是`Force Touch`延伸出的新一代技术，它现在应用于装配了`iOS9`以上操作系统的`iPhone 6S`上，致力于向iPhone用户提供更加高质量的交互体验，将操作方式扩展至三维层面。

本篇文章分别针对`3D Touch`的特性以及开发API进行讲解。

## 特性 — 3D Touch On iPhone
### Home Screen Quick Actions - 主页屏幕快速操作
在手机的主页上，假如你用手指轻轻按压某个应用的图标，图标的背后出现了一个半透明的矩形，这就说明了这款应用支持`Home Screen Quick Actions`(主页屏幕快速操作)。这时，我们保持手指按压，并加大力度，你就会发现这个应用图标的周围都变模糊了，一个小巧的选项栏菜单在你眼前弹出。
![](http://7xsfp9.com1.z0.glb.clouddn.com/Home%20Screen%20Quick%20Actions.gif)
这个选项栏菜单每个选项视图最多允许有两行文本（主文本、次文本）以及一个图标（可要可不要）。另外，图标的位置是不定的，它会在文本的左边或者右边进行布局，具体放置于哪一边，则根据应用图标的水平位置而定，不过这些布局系统都已经帮我们处理好了。
当我们点击某一个选项，应用程序就会运行起来，并且执行相应的操作，相比于以往用户要先进入应用程序才能再进行操作，使用`Home Screen Quick Actions`则更加的便利。

### Peek and Pop - 预览和查看详情
#### Peek - 预览
在传统的手机用户操作中，当我们在应用里看到某张缩略图、某个网址链接或者某个列表Item时，若我们想查看详细的信息，比如想看缩略图对应的大图、网址链接对应的网页、Item对应的详情页面，一般会用手指对屏幕进行点击操作，从而让应用的页面进行跳转。新特性`Peek`则大大提高了这类型操作的用户体验。
![Peek演示](http://7xsfp9.com1.z0.glb.clouddn.com/Peek.gif)
上方效果图所展示的是对一个缩略图片进行`Peek`操作，当我们用手指轻压图片时，图片的周围迅速模糊，这说明你所按压的地方支持`Peek`操作。按压力度稍微增大，预览图就出来了，这就是`Peek`（预览）功能。当我们将手指从屏幕上抬起时，预览图就会消失，界面也就恢复回来。
有了`Peek`的操作简化，当我们想预览某些详情时，只需按压屏幕，手机即可弹出详情页面；移开手指，界面恢复原状，这样就使得用户不必进入一个新的页面浏览详情，然后再点击返回按钮回到原来视图了。

---

#### Peek quick actions - 预览中的快速操作
上方已经说到，当我们的手指按压需要预览的屏幕的区域，预览的视图就会出现。现在，继续保持手指的按压状态，然后再向上方滑动，就会在预览视图的下方滑出一个选项栏菜单。
![](http://7xsfp9.com1.z0.glb.clouddn.com/pick%20quick%20action.png?imageView/2/w/330/q/90)
当菜单完全显示出来后，你可以松开按压在屏幕上的手指，然后点击相应的选项来执行操作，就像上方效果图一样，可以复制、分享、点赞、删除等等。

---

#### Pop - 查看详情
在能出现`Peek`预览视图的手指按压力度基础上，用户再使把劲加大点力度，就能进入相关详情页面，这个就是`Pop`。事实上，`Pop`所进入的详情页面跟用户用手指轻点后所跳转出来的页面是一样的，所以，用户如果想直接进入详情页面，不需要预览，可以直接轻点屏幕指定区域即可；而在预览中，用户想了解得更多，可以再加大按压力度进入详情页面。

### 3D Touch 还能做些什么？
`3D Touch`能完成的功能非常多，你可以利用它来制作一个绘画板，根据手指在屏幕上的压力大小来模拟画笔的粗细，你也可以做一款精美的手游，通过手指的按压力度来反馈不同的游戏操作......
总之，`3D Touch`非常的强大，潜力无限。😁

## 开发 — 3D Touch API
下面，我会通过苹果提供的`3D Touch`API就之前所提及到的各个`3D Touch`特性进行开发实现的分析。所有的交互跟视图布局我都是使用纯代码去实现。
### 判断设备是否支持3D Touch
我们在为应用添加`3D Touch`功能时，有必要做设备是否支持或开启`3D Touch`的判断，考虑到用户使用的手机型号比`iPhone 6s`低，或者用户自己已经手动关闭了`3D Touch`功能，所以在编写代码的时候，需要获取或监听当前设备针对于`3D Touch`的可用性状态，以便在后面做出判断。

我们获取当前设备针对于`3D Touch`的可用性状态，可以使用协议`UITraitEnvironment`。
#### UITraitEnvironment的结构
`UITraitEnvironment`中包含一个属性以及一个方法：

- var traitCollection: UITraitCollection
- func traitCollectionDidChange(previousTraitCollection: UITraitCollection?)

不管是属性还是方法，其目的都是让我们能够获取到当前的设备特征环境集合，只不过使用方法来获取比较动态，可以时刻监听变化。

获取到的环境集合为`UITraitCollection`类型，这个类里面包含属性`forceTouchCapability`，是一个`UIForceTouchCapability`枚举类型，有三个case，分别是`Unknown`（未知的）、`Unavailable`（不可用的）、`Available`（可用的），根据相应的`forceTouchCapability`值，我们就能知道当前设备对`3D Touch`的可用性状态。

---

#### 如何使用UITraitEnvironment
其实，很多我们常用的类都已经实现了`UITraitEnvironment`协议，比如说`UIView`、`UIViewController`等等，我们可以直接从他们的内部中获得`traitCollection`属性然后进行判断：

```Swift
if self.traitCollection.forceTouchCapability == .Available {
	//  TODO:  加入实现3D Touch的代码
}
```

如果我们想做到实时监听状态的变化，比如软件在运行的时候用户突然关闭了`3D Touch`，我们可以自己去实现`UITraitEnvironment`协议，实现其中的监听方法，在这里我就不演示代码了。

### Home Screen Quick Actions
#### 实现Home Screen Quick Actions选项栏菜单
实现`Home Screen Quick Actions`有两种方法，分别是`static`(静态)实现以及`dynamic`(动态)实现，它们的实现主要都是依靠`UIApplicationShortcutItem`这个类来进行。

- **Static 静态实现** 可以硬性地规定好要呈现出来的选项信息，这些设定好的选项在后期是不能够再次修改的。进行静态实现，我们需要修改的是`Info.plist`文件。下面我就编辑`Info.plist`文件来进行静态实现：
  ![](http://7xsfp9.com1.z0.glb.clouddn.com/infoplist.png)
  
  如图所示，我在`Info.plist`文件中添加了一个key为`UIApplicationShortcutItems`的数组，里面有两个字典类Item，每个字典类Item都代表了一个`UIApplicationShortcutItem`，它们具有5个属性：
  
  - **UIApplicationShortcutItemIconType** (String) 选项的图标类型，可选择性设置。使用`static`静态实现是无法使用自己定义的图标的，不过系统也已经提供好一些默认的图标，我们可以设置图标的类型来使用指定的系统默认图标。那究竟有多少种图标类型呢？这个我放在后面讲~
  - **UIApplicationShortcutItemTitle** (String) 选项的主标题，必要设置项。相对于次标题，主标题文字较大且颜色较深，位于次标题的上方。
  - **UIApplicationShortcutItemSubtitle** (String) 选项的次标题，可选择性设置。主要起到选项的帮助提示作用。
  - **UIApplicationShortcutItemType** (String) 选项的类型，必要设置项。利用它，我们就可以在你点击选项执行handle语句时判别具体是哪一个选项被选中了，从而让程序进行相应的操作。关于选项选择后的反馈处理，我在后面也会详细去讲。
  - **UIApplicationShortcutItemUserInfo** (Dictionary) 附加信息，可选择性设置。你可以在里面添加某些附加信息，在执行handle语句的时候可提取出来，具体看你的操作逻辑是如何实现的了。

	现在我把应用跑起来后，回到手机的主页面，并用力按压此应用的图标，`Home Screen Quick Actions`的选项栏菜单就呈现在我们的眼前：
	![](http://7xsfp9.com1.z0.glb.clouddn.com/Home%20Screen%20Quick%20Actions%20static.png?imageView/2/w/330/q/90)

	---

- **Dynamic 动态实现** 较为灵活，我们通过代码去构建每个选项，所以，在程序运行的过程中，选项的信息可以动态地去改变，不过，动态实现较静态实现来说相对复杂了点。

	```Swift
	enum ShortcutItemType: String {
        case Home
        case Share
    }
    
    func setupShortcutItemsWithApplication(application: UIApplication) {
        let playItem = UIApplicationShortcutItem(type: ShortcutItemType.Home.rawValue, localizedTitle: "主页", localizedSubtitle: "点击进入应用主页", icon: UIApplicationShortcutIcon(templateImageName: "icon_home"), userInfo: nil)
        let shareItem = UIApplicationShortcutItem(type: ShortcutItemType.Share.rawValue, localizedTitle: "分享", localizedSubtitle: "点击向朋友分享", icon: UIApplicationShortcutIcon(type: .Share), userInfo: nil)
        application.shortcutItems = [playItem, shareItem]
    }
	```
	如代码所示，应用的单例application对象中拥有`shortcutItems`属性，这是一个数组对象，我们可以在里面添加`UIApplicationShortcutItem`实例或可变`UIMutableApplicationShortcutItem`实例，从而实现菜单中的每个选项。
	这里值得注意的是，要在`shortcutItem`上配置icon并不是用到简单的`UIImage`类，而是使用专门的`UIApplicationShortcutIcon`，它有两种构造方式，一种是选择一个类型，然后使用与类型相对应的系统所提供的图标，究竟有多少种类型呢？我下面来列举一下：

	```Swift
	UIApplicationShortcutIconType 枚举：
	
	iOS 9.0 及以上系统所支持：
	case Compose
    case Play
    case Pause
    case Add
    case Location
    case Search
    case Share
    
    iOS 9.1 及以上系统所支持：
    case Prohibit
    case Contact
    case Home
    case MarkLocation
    case Favorite
    case Love
    case Cloud
    case Invitation
    case Confirmation
    case Mail
    case Message
    case Date
    case Time
    case CapturePhoto
    case CaptureVideo
    case Task
    case TaskCompleted
    case Alarm
    case Bookmark
    case Shuffle
    case Audio
    case Update
	```

	构造的另一种方式是填入一串字符串，其实就是图片的名字，对于这张图片，苹果做出了以下的要求：

	1. 这张图片必须位于你的应用程序包(app bundle)中。
	2. 图片要为`正方形`，颜色使用`单色`，大小为`35×35` points(点)。系统为了保持UI的统一性，会将你提供的这张图片进行颜色渲染，最终图片的整体颜色会变为灰黑色，所以这里建议图片使用单色，即只有一种颜色。

	现在我们在`AppDelegate`中的`application(_:, didFinishLaunchingWithOptions:)`方法里面执行`setupShortcutItemsWithApplication(_:)`，把application作为参数传入其中。
	这里提供一部分的参考代码：
	
	```Swift
	if let shortcutItems = application.shortcutItems where shortcutItems.isEmpty {
            setupShortcutItemsWithApplication(application)
        }
	```
	可能有人在这里会感到奇怪，为什么我在执行`setupShortcutItemsWithApplication(_:)`方法前要先判断`application`中的`shortcutItems`数组属性是否为空容器（里面没有对象），原因是当我们第一次开启这个应用的时候，系统会将我们应用所配置的所有`shortcutItem`进行记录，在我们下一次打开应用时，我们不必再去配置一遍，也就是说，`application`中的`shortcutItems`属性在应用第一次打开的时候是空的，但是当我们进行相应的配置后，在下一次的应用开启时，`shortcutItems`就会默认被系统所赋值，我们也没必要每次打开应用都去配置它。
	
	现在，运行程序，我们来测试一下：
	![](http://7xsfp9.com1.z0.glb.clouddn.com/Home%20Screen%20Quick%20Actions%20dynamic.png?imageView/2/w/330/q/9)
	
	在程序运行的过程中，我们可以任意改变`shortcutItems`：
	
	```Swift
	UIApplication.sharedApplication().shortcutItems = dynamicShortcuts
	```
	
- **static与dynamic混用共同实现Home Screen Quick Actions** 时，选项栏菜单中各个选项的顺序是按照`先静态后动态`来排列的。此外，我们还要注意避免选项类型的冲突。

---

#### 监听Home Screen Quick Actions选项的选择并进行处理
监听`Home Screen Quick Actions`选项的点击选择，我们要在`AppDelegate`中实现方法`application(_:, performActionForShortcutItem:, completionHandler:)`，判断用户选择的是哪一个选项，然后进行相应的操作：

```Swift
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        switch shortcutItem.type {
        case ShortcutItemType.Home.rawValue:
            print("选择了主页选项")
        case ShortcutItemType.Share.rawValue:
            print("选择了分享选项")
        default:
            print("选择了其他选项")
        }
        completionHandler(true)
    }
```

在方法的最后记得调用`completionHandler`闭包，把是否处理完成的布尔值传进去，如成功处理完，传`true`，失败，则传`false`。

---

**注意：**关于方法`application(_:, performActionForShortcutItem:, completionHandler:)`，苹果官方文档给出了使用的相关注意事项：

这个方法会在你选择了某个`Home Screen Quick Actions`选项时调用，但是前提条件是AppDelegate中的`application(_:,willFinishLaunchingWithOptions:)`方法以及`application(_:didFinishLaunchingWithOptions)`方法都要返回`true`真值。苹果建议这个方法是在应用已经启动了、在后台工作的时候才去监听`Home Screen Quick Actions`选项的选择，若我们在应用程序还未启动的时候使用`Home Screen Quick Actions`选择某个选项，我们就不应该使用这个方法来进行监听，应当在`application(_:,willFinishLaunchingWithOptions:)`方法或者`application(_:didFinishLaunchingWithOptions)`方法里进行操作，最后返回`false`，使得AppDelegate不会再去调用`application(_:, performActionForShortcutItem:, completionHandler:)`这个方法。

---

那么，当`Home Screen Quick Actions`选项在应用还未启动时被选择了，我们应该如何在AppDelegate中的`application(_:,willFinishLaunchingWithOptions:)`方法或`application(_:didFinishLaunchingWithOptions)`方法里监听`Home Screen Quick Actions`选项的选择以及做出相应的操作呢？这里我们可以从这两个方法的`launchOptions`参数中获取到对应的`shortcutItem`：

```Swift
let shortcutItem = launchOptions?[UIApplicationLaunchOptionsShortcutItemKey] as? UIApplicationShortcutItem
```
下面我就重写`application(_:didFinishLaunchingWithOptions)`来演示一下：

```Swift
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
        //  TODO: 应用的初始化代码，包括UIWindow以及UIViewController等等的配置...
        
        var performActionForShortcutItemWhenAppLaunch = false
        //  判断应用的启动是否是因为用户选择了Home Screen Quick Actions选项
        if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsShortcutItemKey] as? UIApplicationShortcutItem {
            performActionForShortcutItemWhenAppLaunch = true
            print("选择了\(shortcutItem.type)类的选项")
            //  TODO: 相应的Handle操作
        }
        
        return !performActionForShortcutItemWhenAppLaunch
    }
```
如上方代码所示，我在前面就定义了以布尔型变量`performActionForShortcutItemWhenAppLaunch`，默认值为`false`,然后再从`launchOptions`中取出`shortcutItem`，如果`shortcutItem`为空，则说明应用的启用是由于用户点击了应用的图标，而不是通过`Home Screen Quick Actions`；如果`shortcutItem`不为空，则说明用户是用过点击`shortcutItem`对应的选项来启动应用的，这时候我将`true`值赋值给了`performActionForShortcutItemWhenAppLaunch`。在方法的最后，我通过返回`performActionForShortcutItemWhenAppLaunch`的布尔相反值，来让应用避免调用`application(_:, performActionForShortcutItem:, completionHandler:)`方法。

### Peek And Pop
`Peek And Pop`较`Home Screen Quick Actions`来说更为复杂，下面我就`Peek`、`Peek quick actions`、`Pop`的实现进行分析。
#### Peek & Pop
实现`Peek`和`Pop`首先我们要关注协议`UIViewControllerPreviewingDelegate`，它有两个需要我们去实现的方法：

- **previewingContext(_:, viewControllerForLocation:) -> UIViewController**

	`Peek`就是用户用力按压屏幕某个地方时，周围变得模糊，然后随着按压的力度加强，最后会有一个预览视图弹出。举个例子，屏幕上有一个`TableView`，当我们手指按压其中某个`Cell`时，`Cell`的周围就会变得模糊，然后关于这个`Cell`的预览视图就出现了。这个方法就是用于配置此过程中的相关逻辑，并返回最终的预览视图所属的视图控制器。在这个方法中，我们需要配置一些东西：
	1. `previewingContext`参数中的`sourceRect`。这是一个`CGSize`类型，我们要将手指所按压的视图控件的`frame`赋值给它，从而让系统精确将视图控件的周围模糊掉；如何获取被按压的视图控件呢？方法的`viewControllerForLocation`参数就是当用户用力按压时手指的按压点，我们可以利用这个按压点来找到包含此点的视图控件。
	2. 详情视图控制器的创建、预览尺寸设置以及返回。在这个方法里，我们得实例化我们要预览时展现出来的详情视图控制器，并且利用`preferredContentSize`设置它的预览大小，这是一个`CGSize`类型，当我们把长宽都设置为`0.0`的时候，预览视图大小就会采用系统默认的尺寸值。
	
- **previewingContext(_:, commitViewController:)**

	`Pop`操作就是在这个方法里执行，在前面已经说到，`Pop`其实就是我们传统情况下点击控件然后应用跳出详情视图控制器这一过程，所以，在这里我们需要做的就是把详情视图控制器展现出来。方法中的`commitViewController`参数就是我们在前面方法中返回的详情视图控制器，我们在这个方法中将其"Show"出来即可。

下面就是参考的代码：

```Swift
//  MARK: - UIViewControllerPreviewingDelegate
extension ViewController: UIViewControllerPreviewingDelegate {
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = self.tableView.indexPathForRowAtPoint(location) else { return nil }
        let selectedCellFrame = tableView.cellForRowAtIndexPath(indexPath)!.frame
        
        let detailViewController = DetailViewController()
        detailViewController.mainTitle = self.tableViewData[indexPath.row]
        detailViewController.preferredContentSize = CGSize(width: 0.0, height: 350)
        
        previewingContext.sourceRect = selectedCellFrame
        
        return detailViewController
    }
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
        self.showViewController(viewControllerToCommit, sender: self)
    }
}
```

当我们实现了`UIViewControllerPreviewingDelegate`协议后，我们就可以为视图控制器注册`Peek`预览了，不过，在注册的时候一定要先判断好设备的`3D Touch`是否可用：

```Swift
//  MARK: - Setup 3D Touch
        if self.traitCollection.forceTouchCapability == .Available {
            self.registerForPreviewingWithDelegate(self, sourceView: self.tableView)
        } else {
            print("3D Touch 不可用!")
        }
```
这里我们使用`UIViewController`中的方法`registerForPreviewingWithDelegate(_:, sourceView:)`来进行`Peek`注册，方法第一个传入的参数就是实现了`UIViewControllerPreviewingDelegate`的实例，第二个参数就是手指按压的监听视图。

#### Peek quick actions
`Peek`的快速操作是在详情视图控制器中实现的，我们只需重写这个视图控制器的`previewActionItems() -> [UIPreviewActionItem]`方法，返回一个数组即可。
`UIPreviewActionItem`为一个协议，一般我们需要创建的是`UIPreviewAction`或者`UIPreviewActionGroup`实例。

- **UIPreviewAction**就是代表一个选项，它的构造方法为`init(title: String, style: UIPreviewActionStyle, handler: (UIPreviewAction, UIViewController) -> Void)`，设置的是选项的标题、类型以及选项选择后所需要处理的操作。这里的类型`UIPreviewActionStyle`有三种，分别是`默认`类型、`已选择`类型（旁边有一个勾）、`取消`类型（标题颜色为红色）。
- **UIPreviewActionGroup**是一个`UIPreviewAction`的分组，它的构造方法为`init(title: String, style: UIPreviewActionStyle, actions: [UIPreviewAction])`，传入的参数为标题以及组成这个小组的`UIPreviewAction`成员数组。它的作用是当我们点击这个小组选项时，它就会将自己的成员选项们展开并呈现出来。

这里提供参考代码：

```Swift
    private lazy var previewActions: [UIPreviewActionItem] = {
        let action1 = UIPreviewAction(title: "分享", style: .Default, handler: { action, viewController in
            print("Peek quick actions- 分享")
        })
        let action2 = UIPreviewAction(title: "搜索", style: .Default, handler: { action, viewController in
            print("Peek quick actions- 搜索")
        })
        let action3 = UIPreviewActionGroup(title: "更多", style: .Default, actions: [action1, action2])
        return [action1, action2, action3]
    }()

//  MARK: - Setup PreviewActionItems
    override func previewActionItems() -> [UIPreviewActionItem] {
        return self.previewActions
    }
```
应用运行的效果图如下：
![](http://7xsfp9.com1.z0.glb.clouddn.com/peekandPop.png?imageView/2/w/310/q/9)


### 3D Touch的其他API
苹果为`3D Touch`提供了`Force Properties`（按压强度属性），我们可以在`UITouch`类中找到属性`force`和`maximumPossibleForce`，分别代表瞬时按压力度以及设备最大可能达到的按压力度，我们可以利用这两个属性完成很多有趣的交互，这就要看大家的想象力了，在这里我就举一个简单的小例子：

我编写了一个`UIView`的子类，它的大小由我们手指按压它的力度去决定，这是它的内部代码：

```Swift
class ResizeableView: UIView {
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var multiple: CGFloat = 0.0
        if let force = touches.first?.force, let maximumPossibleForce = touches.first?.maximumPossibleForce {
            multiple = force / maximumPossibleForce
        }
        self.transform = CGAffineTransformMakeScale(1 + multiple, 1 + multiple)
    }
}
```
现在我在一个视图控制器中创建它的一个实例，并添加到控制器的视图中，然后随便设置一个`frame`给它：

```Swift
class TouchViewController: UIViewController {
    
    private let mViewSizeValue: CGFloat = 70.0
    
    private lazy var mView: ResizeableView = {
        let view = ResizeableView()
        view.backgroundColor = UIColor.redColor()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.mView)
        self.mView.frame = CGRectMake(100, 200, mViewSizeValue, mViewSizeValue)
    }

}
```
于是乎，一个利用简单的利用`force`和`maximumPossibleForce`属性的小例子就做出来了。我们运行一下看看效果：
![](http://7xsfp9.com1.z0.glb.clouddn.com/force.gif)

## 总结
这篇文章向大家介绍了`3D Touch`的特性，并详细讲解了有关于`3D Touch`开发API的使用。相关代码我已经发布到个人的GitHub上：[Tan3DTouch](https://github.com/TangentW/Tan3DTouch)。
感谢大家的阅读，在这里也祝大家夏日愉快！

## 参考资料
苹果官方文档：
[Adopting 3D Touch on iPhone](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/Adopting3DTouchOniPhone/)
[iOS Human Interface Guidelines: 3D Touch](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/MobileHIG/3DTouch.html#//apple_ref/doc/uid/TP40006556-CH71-SW1)

苹果官方参考项目：
[ApplicationShortcuts: Using UIApplicationShortcutItem](https://developer.apple.com/library/ios/samplecode/ApplicationShortcuts/Introduction/Intro.html#//apple_ref/doc/uid/TP40016545)
[ViewControllerPreviews: Using the UIViewController previewing APIs](https://developer.apple.com/library/ios/samplecode/ViewControllerPreviews/Introduction/Intro.html#//apple_ref/doc/uid/TP40016546)


