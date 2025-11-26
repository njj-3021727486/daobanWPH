@Component
export struct Product{
  //@Prop: 子组件接收父组件的数据
  @Prop pro: Object = Object({})

  build() {
    Column(){
      Image(Object(this.pro).smallImg)
        .width('100%')  //图片占满卡片宽度
        .height('80%')   //固定图片高度
        .borderRadius(8) //图片圆角
      Row() {
        Column() {
          Text(Object(this.pro).name)
            .maxLines(2) // 防止文本过长溢出
            .textOverflow({overflow: TextOverflow.Ellipsis})
            .fontSize(13)
            .fontColor('#333')

        }
        .margin({left: 2})
        .alignItems(HorizontalAlign.Start)
        .width('65%')

        Column() {
          //价格文本
          Text(`￥${Object(this.pro).price}`)
            .fontSize(18)
            .fontColor('#ff4400')
            .textAlign(TextAlign.End)
        }

      }
      .margin({top: 5})
      .width('80%')

      Row() {
        Column() {
          Text(Object(this.pro).enname)
            .maxLines(1) // 防止文本过长溢出
            .textOverflow({overflow: TextOverflow.Ellipsis})
            .fontSize(13)
            .fontColor('#333')

        }
        .margin({left: 2})
        .alignItems(HorizontalAlign.Start)
        .width('90%')

      }
      .margin({top: 5})
      .width('80%')

      if(Object(this.pro).flag){
        Text(Object(this.pro).flag)
          .position({top:5 ,right:5})
          .backgroundColor("#E6F7F6") // 主题色的极浅色调，柔和不突兀
          .fontColor('#19aba8') // 直接用主题色，强化关联
          .padding({left: 6, right: 6, top: 2, bottom: 2}) // 增加内边距，标签更舒展
          .borderRadius(4) // 圆角优化，更精致
      }

    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}