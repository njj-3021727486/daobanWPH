import { Product } from "../components/Product"

@Component
export  struct StorePage{
  build() {
    Column(){
      // 搜索框
      Column() {
        Search({ placeholder: '输入商品名称' })
          .backgroundColor('#F0F9F8')
          .width('85%')
          .borderRadius(10)
          .placeholderColor('#99CCCC')
          .height(38)
      }
      .backgroundColor('#fff')
      .padding({left:10 ,right:10})
      .width('100%')

      //商品类型和商品列表
      Row(){
        //商品类型
        Column(){
          Scroll(){
            Column(){
              //外套
              Column(){
                Text('外套')
                  .fontColor('#19aba8')
                //左侧选中小竖杠标识
                Column(){
                }
                .width(4)
                .height(30)
                .background('#19aba8')
                .position({
                  left: 0,
                  top:15
                })
              }
              .width('100%')
              .height(60)
              .justifyContent(FlexAlign.Center)
              .backgroundColor('#F0F9F8')
              //衬衫
              Column(){
                Text('衬衫')
                  .fontColor('#19aba8')

              }
              .width('100%')
              .height(60)
              .justifyContent(FlexAlign.Center)
              .backgroundColor('rgb(12,52,186,0,25)')
              //鞋子
              Column(){
                Text('鞋子')
                  .fontColor('#19aba8')

              }
              .width('100%')
              .height(60)
              .justifyContent(FlexAlign.Center)
              .backgroundColor('rgb(12,52,186,0,25)')

            }
            .width('80')
            .background('#fff')
          }
        }


        //商品列表
        Column(){
          Scroll(){
            Column(){
              Flex({wrap: FlexWrap.Wrap}){
                Column(){
                  Product()
                }
                .alignItems(HorizontalAlign.Start)
                .borderRadius(8) //图片圆角
                .width('calc(50% - 5vp)')
                .height(250)
                .backgroundColor('#fff')
                .margin({right: 10,bottom: 10})
                .padding(5)                  // 内边距，避免内容贴边

                Column(){
                  Product()
                }
                .alignItems(HorizontalAlign.Start)
                .borderRadius(8) //图片圆角
                .width('calc(50% - 5vp)')
                .height(250)
                .backgroundColor('#fff')
                .margin({right: 0,bottom: 10})
                .padding(5)                  // 内边距，避免内容贴边
                Column(){
                  Product()
                }
                .alignItems(HorizontalAlign.Start)
                .borderRadius(8) //图片圆角
                .width('calc(50% - 5vp)')
                .height(250)
                .backgroundColor('#fff')
                .margin({right: 10,bottom: 10})
                .padding(5)                  // 内边距，避免内容贴边

                Column(){
                  Product()
                }
                .alignItems(HorizontalAlign.Start)
                .borderRadius(8) //图片圆角
                .width('calc(50% - 5vp)')
                .height(250)
                .backgroundColor('#fff')
                .margin({right: 0,bottom: 10})
                .padding(5)                  // 内边距，避免内容贴边
                Column(){
                  Product()
                }
                .alignItems(HorizontalAlign.Start)
                .borderRadius(8) //图片圆角
                .width('calc(50% - 5vp)')
                .height(250)
                .backgroundColor('#fff')
                .margin({right: 10,bottom: 10})
                .padding(5)                  // 内边距，避免内容贴边

                Column(){
                  Product()
                }
                .alignItems(HorizontalAlign.Start)
                .borderRadius(8) //图片圆角
                .width('calc(50% - 5vp)')
                .height(250)
                .backgroundColor('#fff')
                .margin({right: 0,bottom: 10})
                .padding(5)                  // 内边距，避免内容贴边


              }
              .width('100%')
              .padding({left: 10,right:10})
            }
            .width('100%')
          }
        }
        .width('calc(100% - 80vp)')
        .height('100%')
      }
      .width('100%')
      .height('calc(100% - 56vp)')
      // .backgroundColor('#ffe23232')
      .alignItems(VerticalAlign.Top)
    }
    .width('100%')
    .height('100%')
    // .backgroundColor('#ff969132') // 添加背景色便于观察

  }
}