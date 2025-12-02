//封装鸿蒙客户端向服务器API接口请求
import { http } from '@kit.NetworkKit';

let httpRequest = http.createHttp();

let baseUrl:string ='http://127.0.0.1:7001'

//首页-根据商品标志查询商品数据
export const getProductByFlags = async (flags: string[]) =>{

  //flags: 商品标志

  //等待httpRequest请求完成后返回结果
  return await httpRequest.request(`${baseUrl}/flagProducts`,{
    //请求类型
    method: http.RequestMethod.GET,
    //如果是GET请求，参数可以为一个对象
    extraData: {
      flags: JSON.stringify(flags)
    },
    //设置相应数据类型
    expectDataType: http.HttpDataType.OBJECT
  })
}


//商品-查询商品的所有类型
export const getProductType = async () =>{

  //flags: 商品标志

  //等待httpRequest请求完成后返回结果
  return await httpRequest.request(`${baseUrl}/type`,{
    //请求类型
    method: http.RequestMethod.GET,
    //设置相应数据类型
    expectDataType: http.HttpDataType.OBJECT
  })
}


//根据商品类型获取商品接口
export const getProductByType = async (typeId: string) => {
  return await httpRequest.request(`${baseUrl}/typeProducts`,{
    //请求类型
    method: http.RequestMethod.GET,
    extraData:{
      typeId: typeId
    },
    //设置相应数据类型
    expectDataType: http.HttpDataType.OBJECT

  })
}

//搜索
export const searchProduct = async (name: string) => {
  return await httpRequest.request(`${baseUrl}/search`,{
    //请求类型
    method: http.RequestMethod.GET,
    extraData:{
      name: name
    },
    //设置相应数据类型
    expectDataType: http.HttpDataType.OBJECT

  })
}