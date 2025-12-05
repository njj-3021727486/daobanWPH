import {HomePage} from '../view/HomePage'
import {StorePage} from '../view/StorePage'
import {MyPage} from '../view/MyPage'
import { PackagePage } from '../view/PackagePage'

//定义类型约束（interface）

interface TabbarDataItem{
  //未选中时的图标
  inactiveIcon: Resource
  //选中时的图标
  activeIcon: Resource
  //图标对应字符串
  title: string
}

@Entry
@Component
struct Index {
  //定义tabbar数组
  @State tabbarData: TabbarDataItem[]=[
    {
      inactiveIcon: $r('app.media.homeD'),
      activeIcon: $r('app.media.home'),
      title: '首页'
    },
    {
    inactiveIcon: $r('app.media.storeD'),
      activeIcon: $r('app.media.store'),
    title: '商城'
    },
    {
      inactiveIcon: $r('app.media.packageD'),
      activeIcon: $r('app.media.package'),
      title: '购物车'
    },
    {
      inactiveIcon: $r('app.media.myD'),
      activeIcon: $r('app.media.my'),
      title: '我的'
    }
  ]

  //定义选中tabbar的下标
  @State selectedIndexindex: number = 0;
  //定义函数内部的组件
  @Builder
  TabBarItem(item: TabbarDataItem , index:number){
    Column(){
      Image(this.selectedIndexindex==index?item.activeIcon:item.inactiveIcon)
        .width(28)
      Text(item.title)
        .fontSize(16)
        .margin({top: 3})
        .fontColor(this.selectedIndexindex==index ? '#19aba8':'#646567')
    }
  }


  build() {
    //控制内容列排布
    Column(){
      // tabs
      Tabs(){
        ForEach(this.tabbarData,(item: TabbarDataItem,index: number)=>{
          TabContent(){
            if(this.selectedIndexindex==0){
              HomePage()
            }
            else if(this.selectedIndexindex==1){
              StorePage()
            }
            else if(this.selectedIndexindex==2){
              PackagePage()
            }
            else {
              MyPage()
            }

          }.tabBar(this.TabBarItem(item,index))

        })
      }
      .barPosition(BarPosition.End)
      .barBackgroundColor('#fff')
      .onChange((value: number)=>{
        this.selectedIndexindex = value;
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#ddd')
  }
}