@Component
export struct StepperComponent {

  @Prop count: number = 1

  public onCountChange: (value: number) =>void = (count: number) : void =>{}

  build() {
    Row({ space: 10 }) {
      // 减号按钮（数量≥1才可用）
      Image($r('app.media.reduce'))
        .opacity(this.count ==1 ? 0.3 : 1)
        .width(24)
        .height(24)
        .backgroundColor('#ffffff')
        .onClick(() => {
          this.onCountChange(-1)
        })
      // 当前数量
      Text(`${this.count}`)
        .fontSize(14)
        .width(20)
        .textAlign(TextAlign.Center)
      // 加号按钮
      Image($r('app.media.add'))
        .width(24)
        .height(24)
        .backgroundColor('#ffffff')
        .onClick(() => {
          this.onCountChange(1)
        })
    }

  }
}