import router from '@ohos.router'
@Entry
@Component
struct SourcePage {
  build() {
    Column({ space: 10 }) {
      Text('Hi!')
        .fontSize(40)
        .textAlign(TextAlign.Start)
        .fontWeight(FontWeight.Lighter)
      // Blank()
      Text('A collection of gadgets')
        .fontSize(20)
        .textAlign(TextAlign.Start)
        .fontWeight(FontWeight.Lighter)
      // Text('想那一刻，他和上帝和解了。——《阿甘正传》')
      //   .fontSize(10)
      //   .textAlign(TextAlign.Start)
      //   .fontWeight(FontWeight.Lighter)
      Row({ space: 50 }) {
        Button('BMI计算器')
          .type(ButtonType.Normal)
          .fontColor('#1f1f1f')
          .compButtonStyle()
          .onClick(() => {
            //todo:pushUrl
            router.pushUrl({url:'pages/BMI/BMIPage'})
          })
        Button('食物卡路里计算器')
          .type(ButtonType.Normal)
          .fontColor('#1f1f1f')
          .compButtonStyle()
          .onClick(() => {
            //todo:replaceUrl
            router.pushUrl({url:'pages/Calories/CaloriesPage'})
          })
      }
      .padding({
        top: 40,
      })
      Row({ space: 50 }) {
        Button('BMR计算器')
          .type(ButtonType.Normal)
          .fontColor('#1f1f1f')
          .compButtonStyle()
          .onClick(() => {
            //todo:pushUrl
            router.pushUrl({url:'pages/BMR/BMR'})
          })
        Button('水平仪')
          .type(ButtonType.Normal)
          .fontColor('#1f1f1f')
          .compButtonStyle()
          .onClick(() => {
            //todo:replaceUrl
            router.pushUrl({url:'pages/Gradienter/Gradienter'})
          })
      }
      .padding({
        top: 20,
      })
      Row({ space: 50 }) {
        Button('保质期计算器')
          .type(ButtonType.Normal)
          .fontColor('#1f1f1f')
          .compButtonStyle()
          .onClick(() => {
            //todo:pushUrl
            router.pushUrl({url:'pages/ExpirationDate/ExpirationDate'})
          })
        Button('电子木鱼')
          .type(ButtonType.Normal)
          .fontColor('#1f1f1f')
          .compButtonStyle()
          .onClick(() => {
            //todo:replaceUrl
            router.pushUrl({url:'pages/ElectronicWoodenFish/ElectronicWoodenFish'})
          })
      }
      .padding({
        top: 20,
      })
      Row({ space: 50 }) {
        Button('二维码生成')
          .type(ButtonType.Normal)
          .fontColor('#1f1f1f')
          .compButtonStyle()
          .onClick(() => {
            //todo:pushUrl
            router.pushUrl({url:'pages/Two-dimensionalCodeGeneration/Two-dimensionalCodeGeneration'})
          })
        Button('指南针')
          .type(ButtonType.Normal)
          .fontColor('#1f1f1f')
          .compButtonStyle()
          .onClick(() => {
            //todo:replaceUrl
            router.pushUrl({url:'pages/Compass/Compass'})
          })
      }
      .padding({
        top: 20,
      })
      // Row({ space: 50 }) {
      //   Button('手持弹幕')
      //     .type(ButtonType.Normal)
      //     .fontColor('#1f1f1f')
      //     .compButtonStyle()
      //     .onClick(() => {
      //       //todo:pushUrl
      //       router.pushUrl({url:'pages/HandBarrag/handBarrageIndex'})
      //     })
      //   Button('进制转换')
      //     .type(ButtonType.Normal)
      //     .fontColor('#1f1f1f')
      //     .compButtonStyle()
      //     .onClick(() => {
      //       //todo:replaceUrl
      //       // router.pushUrl({url:'pages/Calories/CaloriesPage'})
      //     })
      // }
      // .padding({
      //   top: 20,
      // })
    }.width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
    .backgroundColor('#f0f0f0')
    .padding({
      top: 40,
      right:5,
      left:5
    })
  }
  @Styles compButtonStyle() {
    .width('40%')
    .backgroundColor('#f5f5f5')
    .borderRadius(10)
    .shadow({
      radius:8,
      color:'rgba(0, 0, 0, 0.2)',
      offsetX:6,
      offsetY:6
    })
  }


}