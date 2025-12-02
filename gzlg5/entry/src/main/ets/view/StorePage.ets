import { Product } from "../components/Product"
import {getProductType} from '../api/api'
import {getProductByType} from '../api/api'

// 导入路由模块（用于页面跳转）
import router from '@kit.ArkUI';


@Component
export  struct StorePage{
  //商品类别下标，默认值为0
  @State selectTypaIndex: number = 0
  //商品标志
  @State types: Object[] = []
  //所有类型数据
  private allTypeData: Object[] = []
  //当前选中类型的商品数据
  @State currentProduct: Object[] = []

  //钩子函数
  async aboutToAppear(){

    console.log('store 页面挂载时，触发...')
    let data: Object =await getProductType();
    // console.log('获取类品表的数据==>',JSON.stringify(data))
    let typesData: Object[]=Object(data).result.result;

    //保存typesData
    this.allTypeData = typesData;
    console.log('获取类品表的数据==>',JSON.stringify(typesData))

    typesData.forEach((item: Object) =>{
      if(Object(item).type){
        this.types.push(Object(item).type)
      }

    })
    console.log('获取类品类型==>',this.types)
    this.getProductData();
  }

  private async getProductData (){
    let typeId: string = Object(this.allTypeData[this.selectTypaIndex]).typeId;
    //根据商品类别 typeId 获取对应的商品信息
    let productRes: Object = await getProductByType(typeId);
    let ProductData :Object[]= Object(productRes).result.result
    this.currentProduct=ProductData
    //保存获取到的商品信息
    console.log('ProductData==>',JSON.stringify(this.currentProduct))
  }



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
      .alignItems(HorizontalAlign.Start)
      .backgroundColor('#fff')
      .padding({left:10 ,right:10})
      .width('100%')


      //商品类型和商品列表
      Row(){
        //商品类型
        Column(){
          Scroll(){
            Column(){
              ForEach(this.types,(item: string,index: number)=>{
                Column(){
                  Text(item)
                    .fontColor('#19aba8')
                  if(index==this.selectTypaIndex){
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

                }
                .width('100%')
                .height(60)
                .justifyContent(FlexAlign.Center)
                .backgroundColor(index==this.selectTypaIndex?'#F0F9F8':'#ffffff')
                .onClick(async (): Promise<void> =>{
                  //如果当前选项再次被点击，直接俄跳过此次点击
                  if(this.selectTypaIndex==index){
                    return;
                  }
                  console.log('index==>',index)
                  this.selectTypaIndex=index
                  //保存当前选中的类型的数据
                  let currentType: object = this.allTypeData[this.selectTypaIndex];
                  console.log('currentType==>',JSON.stringify(currentType))
                  //根据 typeId 查询对应商品
                  this.getProductData();
                })
              })
            }
            .width('80')
            .background('#fff')
          }
        }




        //商品列表
        Column(){
          Scroll(){
            //列表的每一项
            Column(){
              Flex({wrap: FlexWrap.Wrap}){
                ForEach(this.currentProduct,(item: Object,index: number)=>{
                  Column(){
                    Product({pro: Object(item)})
                  }
                  .alignItems(HorizontalAlign.Start)
                  .borderRadius(8) //图片圆角
                  .width('calc(50% - 5vp)')
                  .height(300)
                  .backgroundColor('#fff')
                  .margin({right: (index%2==0)?10:0,bottom: 10})
                  .padding(5)                  // 内边距，避免内容贴边
                })
              }
              .width('100%')
              .padding({left: 10,right:10})
            }

            .width('100%')
          }
        }
        .width('calc(100% - 80vp)')
        .height('100%')
        .backgroundColor('#94ffffff')
      }
      .width('100%')
      .height('calc(100% - 56vp)')
      .alignItems(VerticalAlign.Top)
    }
    .width('100%')
    .height('100%')
    // .backgroundColor('#ff969132') // 添加背景色便于观察

  }
}