@Component
export struct Product{
  //@Prop: 子组件接收父组件的数据
  @Prop pro: Object = Object({
    smallImg: 'http://127.0.0.1:7001/assets/56f6a7360-caa4-11f0-a4d8-4d82b2539fe6.jpeg',
    name :'连衣裙两件套通勤套装',
    enname:'Two-Piece Dress Set for Work',
    price: '269.00',
    flag: '潮牌'
  })

  build() {
    Column(){
      Image(Object(this.pro).smallImg)
        .width('100%')  //图片占满卡片宽度
        .height('80%')   //固定图片高度
        .borderRadius(8) //图片圆角

      Text(Object(this.pro).name)
        .maxLines(1) // 防止文本过长溢出
        .textOverflow({overflow: TextOverflow.Ellipsis})
        .fontSize(13)
        .fontColor('#333')

      Text(Object(this.pro).enname)
        .maxLines(1) // 防止文本过长溢出
        .textOverflow({overflow: TextOverflow.Ellipsis})
        .fontSize(13)
        .fontColor('#333')
      //价格文本
      Text(`￥${Object(this.pro).price}`)
        .fontSize(18)
        .fontColor('#ff4400')
        .textAlign(TextAlign.End)




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