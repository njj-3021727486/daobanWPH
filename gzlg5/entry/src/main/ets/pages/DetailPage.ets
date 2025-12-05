import router from '@ohos.router';
import { StepperComponent } from '../components/StepperComponent'
import {getProductDetail} from '../api/api'
import { it } from '@ohos/hypium';

// import { StyleSheet } from '@ohos.ui'; // 可选：用StyleSheet统一管理样式

@Entry
@Component
struct DetailPage {
  // 商品数据（可从父组件/接口传入，这里先模拟）

  @Prop product: Object = Object({
    smallImage: 'http://127.0.0.1:7001/assets/56f6a7360-caa4-11f0-a4d8-4d82b2539fe6.jpeg',
    name: '连衣裙两件套通勤套装',
    enname: 'Two-Piece Dress Set for Work',
    price: '￥269.00',
    flag: '潮牌',
    desc: '冬季文艺风收腰显瘦法式针织衫上衣吊带连衣裙两件套通勤套装'
  })
  // 数量状态（默认1，限制最小为1）
  @State count: number = 1;

  //定义商品详细数据
  @State productDetail: string[] = []

  public updataCount: (value: number) =>void =(value: number): void =>{
    console.log('父类组件方法')
    let countValue: number = this.count + value
    console.log('countValue ==>',countValue)
    if(countValue >=1){
      this.count = countValue
    }
}

  @State pid: string = '';//存储pid
  public async getPid (){
    const params = router.getParams();
    console.log('params==>',JSON.stringify(params))
    if (params && Object(params).pid) {
      this.pid = Object(params).pid; // 赋值给变量，后续可直接用
      }
    else {
      return;
    }
    //访问 api 接口，获取商品的详细信息
    let data: Object = await getProductDetail(this.pid);
    //打印所有获得的信息
    // console.log('data==>',JSON.stringify(data))
    let  productData: Object = Object(data).result.result[0]
    //打印有效数据
    // console.log('productData==>',JSON.stringify(productData))

    let productDesc: string[] = Object(productData).desc.split('\n')
    for(let i = 0; i<productDesc.length; i++){
      if(productDesc[i]=='\r'){
        productDesc.splice(i,1);
        i--
      }
    }
    //纸打印商品描述信息
    console.log('productDesc==>',JSON.stringify(productDesc))

    this.productDetail = productDesc
    console.log('productDetail==>',JSON.stringify(this.productDetail))

    this.product = productData

    // console.log('product==>',JSON.stringify(this.product))
  }

  aboutToAppear() {
    this.getPid()
  }

  build() {
    Column() {
      // 1. 顶部导航栏（返回+标题）
      Row() {
        // 返回按钮
        Image($r('app.media.left'))
          .width(24)
          .height(24)
          .onClick(() => router.back())
        // 页面标题
        Text('商品详情')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .flexGrow(1)
          .textAlign(TextAlign.Center)
        // 右侧占位（保持布局平衡）
        Text('')
          .width(24)
      }
      .backgroundColor('#fff')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .width('100%')
      .padding({
        left: 10,
        right: 10,
        top: 15,
        bottom: 15
      })

      Scroll() {
        Column() {
          // 2. 商品主图
          Row() {
            // Scroll() {
              Column(){
                Image(Object(this.product).smallImage)
                  .width('100%')
              }
              .width('100%')
            // }
            // .height('40%')
          }
          .width('100%')

          // 3. 商品基本信息（标签+名称+价格）
          Row() {
            // 左侧：标签+名称+英文名
            Column({ space: 4 }) {
              // 商品标签（如“潮牌”）
              Text(Object(this.product).flag)
                .fontSize(15)
                .fontColor('#ffffff')
                .backgroundColor('#19aba8')
                .padding({
                  left: 6,
                  right: 6,
                  top: 2,
                  bottom: 2
                })
                .borderRadius(4)
              // 商品中文名
              Text(Object(this.product).name)
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
              // 商品英文名
              Text(Object(this.product).enname)
                .fontSize(16)
                .fontColor('#999999')
            }
            // .backgroundColor('#ffbf0b0b')
            .width('75%')
            .alignItems(HorizontalAlign.Start)

            Column(){
              Text(Object(this.product).price)
                .fontSize(18)
                .fontColor('#19aba8')
                .fontWeight(FontWeight.Bold)
            }
            // .backgroundColor('#ffbf0b0b')
            .alignItems(HorizontalAlign.Start)
            .margin({left: 0})
            // 右侧：价格

          }
          .backgroundColor('#fff')
          .width('100%')
          .justifyContent(FlexAlign.Start)
          .alignItems(VerticalAlign.Center)
          .padding({
            left: 6,
            right: 6,
            top: 10,
            bottom: 2
          })

          // 4. 数量选择区域
          Row() {
            Text('选择数量')
              .fontSize(14)
              .fontColor('#333333')
            // 数量控制按钮组
            StepperComponent({count: this.count,onCountChange: this.updataCount})
          }
          .backgroundColor('#fff')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .width('100%')
          .padding({
            left: 15,
            right: 15,
            top: 20,
            bottom: 20
          })

          // {
          //   borderTopWidth: 1,
          //   borderTopColor: '#f2f2f2'
          // }


          // 5. 商品描述区域
          Column({space: 5}) {
            Text('商品描述')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#333333')
              .margin({ top: 15, bottom: 8 })

            // 描述内容（带圆点前缀）
            ForEach(Object(this.productDetail),(item: string)=>{
              Row() {
                Text(`●`)
                  .fontSize(16)
                  .fontColor('#19aba8')
                  .margin({ right: 0 })

                Text(item)
                  .fontSize(14)
                  .fontColor('#666')
                  .textAlign(TextAlign.JUSTIFY)
              }
            })

            //别删掉，空白快填充，不然看不到底部
            Row(){

            }
            .height('85')
          }
          .backgroundColor('#fff')
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding({ left: 15, right: 15, bottom: 20 })
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)
        .margin({top: 0})
        .padding({ top: 0})
      }
      .backgroundColor('#fff')
      .padding({ top: 0 })
      .margin({top:0})





      // 6. 底部操作栏（固定在页面底部）
      Row() {

        // 购物袋图标
        Column() {
          Image($r('app.media.bag'))
            .width(30)
            .height(30)
          Text('购物袋')
            .fontSize(12)
            .fontColor('#666666')
        }
        .alignItems(HorizontalAlign.Center)
        .width('18%')
        .padding({
          left: 15,
          right: 0,
          top: 10,
          bottom: 10
        })

        // 收藏图标
        Column() {
          Image($r('app.media.heart'))
            .width(27)
            .height(25)
          Text('收藏')
            .fontSize(12)
            .fontColor('#666666')
        }
        .padding({
          left: 0,
          right: 10,
          top: 10,
          bottom: 10
        })
        .width('18%')
        .alignItems(HorizontalAlign.Center)

        Column() {
          // 加入购物袋按钮（占比更大）
          Button('加入购物车')
            .width('50%')
            .height(40)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#ffffff')
            .backgroundColor('#19aba8')
            .borderRadius(20)
        }
        .margin({ right: 20 })
      }
      .width('100%')
      .backgroundColor('#fff')
      .justifyContent(FlexAlign.SpaceBetween)

      .position({ left: 0, bottom: -27 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f2f2f2')
  }
}