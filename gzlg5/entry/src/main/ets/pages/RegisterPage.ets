// import router from '@ohos.router';
@Entry
@Component
struct LoginPage {
  // 状态变量（贴合你的命名风格）
  @State phone: string = ''
  @State password: string = ''
  @State isPwdVisible: boolean = false

  build() {
    Column() {
      // 1. 顶部Logo区域
      Column() {
        // Logo图标（用Image替代，这里模拟你的风格）
        Image($r('app.media.YEK'))
          .width(80)
          .height(80)
          .backgroundColor('#fff')
          .borderRadius(10)
        Text('优二库')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 10 })
      }
      .alignItems(HorizontalAlign.Center)
      .margin({ top: 60, bottom: 40 })

      // 2. 输入框区域
      Column({ space: 15 }) {
        // 手机号输入框
        Row() {
          Text('手机号')
            .fontSize(16)
            .fontColor('#333')
            .width('25%')
          TextInput({ placeholder: '输入手机号' })
            .width('75%')
            .height(40)
            .border({ width: 1, color: '#eee', radius: 6 })
            .padding({ left: 10 })
        }
        .width('85%')
        .alignItems(VerticalAlign.Center)

        // 密码输入框
        Row() {
          Text('密码')
            .fontSize(16)
            .fontColor('#333')
            .width('25%')
          TextInput({ placeholder: '输入密码' })
            .type(InputType.Password)
            .width('75%')
            .height(40)
            .border({ width: 1, color: '#eee', radius: 6 })
            .padding({ left: 10 })
        }
        .width('85%')
        .alignItems(VerticalAlign.Center)

        // 密码昵称
        Row() {
          Text('昵称')
            .fontSize(16)
            .fontColor('#333')
            .width('25%')
          TextInput({ placeholder: '输入昵称' })
            .width('75%')
            .height(40)
            .border({ width: 1, color: '#eee', radius: 6 })
            .padding({ left: 10 })
        }
        .width('85%')
        .alignItems(VerticalAlign.Center)

      }
      .alignItems(HorizontalAlign.Center)

      // 3. 登录按钮
      Button('注册')
        .width('85%')
        .height(45)
        .fontSize(18)
        .fontColor('#fff')
        .backgroundColor('#19aba8')
        .borderRadius(22)
        .margin({ top: 30 })

      // 4. 辅助链接
      Row() {
        Text('已有账号, 去登录')
          .fontSize(14)
          .fontColor('#19aba8')
          .onClick(() => { /* 注册逻辑 */ })
      }
      .width('85%')
      .justifyContent(FlexAlign.Start)
      .margin({ top: 15 })

      // 5. 提示信息
      Column() {
        Text('提示:')
          .fontSize(14)
          .fontColor('#333')
          .fontWeight(FontWeight.Medium)
          .margin({ top: 40, bottom: 5 })
        Text('1、手机号为11位。')
          .fontSize(12)
          .fontColor('#999')
        Text('2、密码由数字、字母组合, 且必须以字母开头, 6-16位。')
          .fontSize(12)
          .fontColor('#999')
      }
      .width('85%')
      .alignItems(HorizontalAlign.Start)
      .margin({ top: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#fff')
  }
}