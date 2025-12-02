//封装用户首选项操作(本地存储)



import {preferences}from '@kit.ArkData'

let options: preferences.Options = {name: 'myStore'};

let context = getContext(this)

let dataPreferences: preferences.Preferences = preferences.getPreferencesSync(context,options);


//本地存储数据的增删改查
export const addData = (key: string, value: number | string | boolean | number[] | string[]|boolean[]): void =>{
  //添加数据
  dataPreferences.putSync(key, value);
  //刷新缓冲区,实现持久化储存
  dataPreferences.flushSync();
}

//获取数据
export const getData = (key: string): preferences.ValueType =>{
  //如果key不存在，默认''
  let result: preferences.ValueType = dataPreferences.getSync(key, '');
  return result;
}

//删除单个数据
export const deletaData = (key: string): void =>{
  dataPreferences.deleteSync(key);
  //刷新缓冲区,实现持久化储存
  dataPreferences.flushSync();
}