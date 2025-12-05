import {getProductByFlags} from '../api/api'
import { Product } from '../components/Product'
import { router } from '@kit.ArkUI'


@Component
export  struct HomePage{
  //商品标志
  @State flags: string[] = ['热销','冬装','特价','潮牌']
  //定义选中的商品标记的下标
  @State selectFlagIndex: number = 0
  //所有的商品数据(根据商品标志获取)
  private allProductData: Object[] = []
  //定义轮播图数据(默认显示冬装的商品数据)
  private bannerFlag: string = '冬装'
  //@State定义页面展示的数据
  @State bannerData: Object[] = []
  //定义当前商品标记的商品数据
  @State currentProduct: Object[] = []

  private viewSearchPage(){
    console.log('点击搜索框，开始跳转');
    router.pushUrl({
      url:'pages/SearchPage'
    })
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



  //当页面挂载时，触发一个生命函数（钩子）
  async aboutToAppear() {
    console.log('当页面挂载时，触发...')
    //根据商品标志获取商品数据
    let data: Object = await getProductByFlags(this.flags);
    // console.log('根据商品标志获取商品的数据 data==>',JSON.stringify(data));


    //商品数据
    let productData: Object []= Object(data).result.result;

    // console.log('根据商品标志获取商品数据 productData ==>',JSON.stringify(productData));
    //保存productData
    this.allProductData = productData;
    // console.log('根据商品标志或取商品数据 productData==>',JSON.stringify(this.allProductData))


    //筛选轮播图(冬装的商品数据)
    let bannerResult: Object[] = [];

    //筛选默认选中的商品标志的商品的数据
      //存放标记名称
    let currentFlag: string = this.flags[this.selectFlagIndex];
    console.log('currentFlag==>',currentFlag)
      //存放属于该标记的商品详情
    let currentFlagProduct: Object[] = []

    //筛选轮播图的商品信息
    productData.forEach((item: Object) => {

      if(Object(item).flag == this.bannerFlag ){
        bannerResult.push(item)
      }
      //筛选对应标签的商品信息
      if(Object(item).flag ==currentFlag){
        currentFlagProduct.push(item)
      }

    })
    this.bannerData = bannerResult
    // console.log('轮播图数据 this.bannerData==>',JSON.stringify(this.bannerData))
    this.currentProduct = currentFlagProduct;
    console.log('当前商品标志的商品数据 this.currentProduct ==>',JSON.stringify(this.currentProduct))
  }

  build() {
    Column(){
      //滚动条组件
      Scroll() {
        Column() {
          //搜索框
          Column() {
            Search({ placeholder: '输入商品名称' })
              .backgroundColor('#F0F9F8')
              .width('85%')
              .borderRadius(10)
              .placeholderColor('#99CCCC')
              .height(38)
              .onClick(()=>{
                this.viewSearchPage()
              })
          }
          .alignItems(HorizontalAlign.Start)
          .backgroundColor('#fff')
          .padding({left:10 ,right:10})
          .width('100%')
        //轮播图
        Column(){
          Swiper(){
            ForEach(this.bannerData,(item:object) =>{
                Column(){
                  Image(Object(item).largeImg)
                    .width('100%')
                    .onClick(()=>{
                      this.viewProductDetail(Object(item).pid)
                    })
                }
                .width('100%')
                .background('#e1e3e2')
            })
          }
          .autoPlay(true)
          .interval(5000)
          .indicator(new DotIndicator().selectedColor('#oD33BA').color('rgba(0,0,0,0.8)'))
        }
        .width('100%')

        //商品标识列表（4个）
          Row(){
            Row(){
              ForEach(this.flags,(item: string, index: number)=>{
                Column(){
                  Text(item)
                    .width(60)
                    .height(60)
                    .backgroundColor(this.selectFlagIndex==index?'#19aba8':'#f2f2f2')
                    .fontColor(this.selectFlagIndex==index?'#fff':'#ff2e817e')
                    .textAlign(TextAlign.Center)
                    .borderRadius(30)
                    .onClick((): void =>{
                      //如果当前选项再次被点击，没有出现选项切换时，直接return，不需要重新渲染
                      if(this.selectFlagIndex==index){
                        return;
                      }
                      console.log('index ==>',index);
                      this.selectFlagIndex = index;
                      let currentFlag: string = this.flags[this.selectFlagIndex];
                      let currentFlagProduct: Object[] = [];

                      this.allProductData.forEach((item: Object) =>{
                        if(Object(item).flag == currentFlag){
                          currentFlagProduct.push(item);
                        }
                      })
                      this.currentProduct = currentFlagProduct;
                      console.log("currentFlagProduct==>",JSON.stringify(this.currentProduct))
                    })
                }
                .width('25%')
                .height(60)
              })
            }
            .backgroundColor('#fff')
            .padding({top: 10,bottom: 10})
            .borderRadius(10)
          }
          .width('100%')
          .padding(10)

      //商品列表
      Flex({wrap: FlexWrap.Wrap}){
            ForEach(this.currentProduct,(item: Object,index: number) =>{
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
              .onClick(()=>{
                this.viewProductDetail(Object(item).pid)

              })
            })

      }
      .width('100%')
      .padding({left:10,right:10})
        }
      }
    }
    .width('100%')
    .height('100%')

  }
}