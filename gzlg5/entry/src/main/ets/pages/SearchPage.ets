import { Product } from "../components/Product"
import { searchProduct } from "../api/api"
import { router } from "@kit.ArkUI"
import { addData, getData, deletaData } from '../utils/storage'

@Entry
@Component
export struct SearchPage {
  //存储搜索关键字
  @State keyword: string = ''
  //存储搜索到的商品数据
  @State productData: object [] = []
  //定义搜素历史数据
  @State historyData: string[] = []
  //定义搜素历史最多个数
  private maxCount: number = 3
  //记录上一次搜索的关键字
  private previousKeyword: string = ''
  //选择搜索标签下标
  @State selectedTagIndex: number = -1

  //保暖 老爹鞋 裙 裤子 百搭

  aboutToAppear(): void {

    let historyData: string[] = getData('historyData') as string[];
    console.log('搜索历史 historyData', JSON.stringify(historyData));

    if (historyData) {
      // historyData=[];
      // this.historyData = [];
      this.historyData = historyData;
    }
  }

  private viewProductDetail(pid: string){
    console.log('pid',pid);
    router.pushUrl({
      url:'pages/DetailPage',
      //参数
      params: {
        pid
      }
    })
  }

  build() {
    // 根布局：垂直排列
    Column() {
      // 顶部搜索栏：返回图标 + 搜索框 + 搜索按钮
      Row() {
        Column() {
          // 返回图标（资源名：left）
          Image($r('app.media.left'))
            .width(24)
            .height(24)
            .margin({ left: 10 })
            .onClick(() => {
              router.back()
            })
        }

        Column() {
          // 搜索输入框
          TextInput({ placeholder: '输入商品名称', text: this.keyword })
            .backgroundColor('#F0F9F8')
            .width('75%')
            .borderRadius(10)
            .placeholderColor('#99CCCC')
            .height(38)
            .margin({ left: 5, right: 10 })
            .onChange((value: string) => {
              console.log('value=>', value)
              this.keyword = value;
            })
        }

        // 搜索按钮鞋
        Text('搜索')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .onClick(async () => {
            //可添加逻辑
            console.log('this.keyword ==>', this.keyword)

            let keyWordValue: string = this.keyword.trim()

            if (!keyWordValue) {
              console.log('请输入商品名称')
              return;
            }

            if (keyWordValue == this.previousKeyword) {
              console.log('本次搜索关键字和上一次一样的')
              this.keyword = ''
              return;
            }

            //记录本次搜索的关键字
            this.previousKeyword = keyWordValue;

            this.selectedTagIndex = -1

            let data: Object = await searchProduct(keyWordValue)
            console.log('data=>', JSON.stringify(data))
            this.productData = Object(data).result.result
            console.log('productData_search=>', this.productData)

            //判断是否已经存在改搜素历史
            if (this.historyData.indexOf(keyWordValue) > -1) {
              console.log('该搜索历史已经存在')
              this.keyword = ''
              return;
            }

            //判断搜索历史是否已满
            if (this.maxCount == this.historyData.length) {
              //搜索历史已满，先删除最早的添加，在添加新的
              this.historyData.shift();
            }

            //保存搜素记录
            this.historyData.push(keyWordValue);
            console.log('搜索记录 this.historyData ==>', JSON.stringify(this.historyData))

            addData('historyData', this.historyData)
            this.keyword = ''

          })
      }
      .backgroundColor('#fff')
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Scroll() {
        Column() {
          if (this.historyData.length > 0) {
            Column({ space: 20 }) {
              // 最近搜索区域：文字 + 删除图标
              Row() {
                Column() {
                  Text('最近搜索')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .margin({ left: 20 })
                }

                Column() {
                  Image($r('app.media.deleteAll'))
                    .width(20)
                    .height(20)
                }
                .margin({ right: 20 })
                .onClick(() => {
                  this.historyData = []
                  deletaData('historyData')
                })
              }
              .margin({ top: 15, bottom: 10 })
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)

              //最近搜索标签区域
              Row() {
                Flex({ wrap: FlexWrap.Wrap }) {
                  ForEach(this.historyData, (tag: string, index: number) => {
                    Text(tag)
                      .padding({
                        left: 2,
                        right: 5,
                        top: 5,
                        bottom: 5
                      })
                      .backgroundColor(this.selectedTagIndex == index ? '#F0F9F8' : '#f0f0f0')
                      .fontColor(this.selectedTagIndex == index ? '#ff1dbc95' : '#000')
                      .borderRadius(6)
                      .fontSize(14)
                      .margin({ right: 20, bottom: 20 })
                      .onClick(async () => {
                        console.log('tag ==>', tag)
                        if (this.selectedTagIndex == index) {
                          return;
                        }
                        this.selectedTagIndex = index

                        if (this.previousKeyword == tag) {
                          console.log('本次搜索关键字和上一次一样的')
                          return;
                        }
                        this.previousKeyword = tag;
                        let data: Object = await searchProduct(tag);
                        this.productData = Object(data).result.result;

                      })
                  })
                }
              }
              .margin({ left: 15 })
            }
            .background('#ffffffff')
          }
          // 商品列表区域（自动换行布局）
          Flex({ wrap: FlexWrap.Wrap }) {
            ForEach(this.productData, (item: Object, index: number) => {
              Column() {
                Product({ pro: Object(item) })
              }
              .alignItems(HorizontalAlign.Start)
              .borderRadius(8) //图片圆角
              .width('calc(50% - 5vp)')
              .height(300)
              .backgroundColor('#fff')
              .margin({ right: (index % 2 == 0) ? 10 : 0, bottom: 10 })
              .padding(5) // 内边距，避免内容贴边
              .onClick(() =>{
                this.viewProductDetail(Object(item).pid)
              })
            })
          }
          .backgroundColor('#f2f2f2')
        }
        .width('100%')
      }
    }
    .backgroundColor('#f2f2f2')
    .width('100%')
    .height('100%')
  }
}