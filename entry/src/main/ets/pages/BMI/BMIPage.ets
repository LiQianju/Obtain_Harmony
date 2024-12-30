import promptAction from '@ohos.promptAction';
import router from '@ohos.router'
@Component
struct InputCompoments {
  onTextChange?: (value: string) => void
  placeholder?: string
  build() {
    TextInput({
      placeholder: this.placeholder,
    })
      .width('70%')
      .caretColor('#1f1f1f')
      .type(InputType.NUMBER_DECIMAL)
      .onChange((value: string) => {
        // 触发回调，传递输入的值
        if (this.onTextChange) {
          this.onTextChange(value);
        }
      });
  }
}



@Entry
@Component
struct TargetPage {
  @State inputValue_height: number = 0
  @State inputValue_weight: number = 0
  @State count: number = 0

  build() {
    Column({ space: 0 }) {
      Row() {
        Image($r('app.media.icon_back'))
          .width(10)
          .height(10)
        Text('返回')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#959595')
      }.alignSelf(ItemAlign.Start)
      .padding(20)
      .onClick(() => {
        router.back()
      }).padding({ bottom: 160,left:10,top:10 })
      InputCompoments({
        onTextChange: (value: string) => {
          // 这里将输入值转换为数字，并更新状态
          const height = parseFloat(value);
          if (!isNaN(height)) {
            this.inputValue_height = height;
          }
        },
        placeholder: '请输入身高/cm'
      })
      InputCompoments({
        onTextChange: (value: string) => {
          // 这里将输入值转换为数字，并更新状态
          const weight = parseFloat(value);
          if (!isNaN(weight)) {
            this.inputValue_weight = weight;
          }
        },
        placeholder: '请输入体重/kg'
      })
        .margin({ top: 50,bottom:20 })
      Text('计算公式：BMI=体重÷身高的平方')
        .fontSize(14)
      Text('（体重单位：千克；身高单位：米）')
        .fontSize(14)

      Row({ space: 50 }) {
        // Button('重置')
        //   .type(ButtonType.Normal)
        //   .fontColor('#1f1f1f')
        //   .onClick(() => {
        //     //刷新整个页面
        //   })
        Button('点击计算BMI')
          .type(ButtonType.Normal)
          .fontColor('#1f1f1f')
          .width('40%')
          .backgroundColor('#f5f5f5')
          .borderRadius(10)
          .margin({ top: 30 })
          .shadow({
            radius:8,
            color:'rgba(0, 0, 0, 0.2)',
            offsetX:6,
            offsetY:6
          })
          .onClick(() => {
            if (this.inputValue_height > 0 && this.inputValue_weight > 0) {
              this.count = parseFloat((this.inputValue_weight / Math.pow(this.inputValue_height / 100, 2)).toFixed(2));
              console.info(`结果: BMI = ${this.count}`);
            }
            else{
              promptAction.showToast({
                message: '请输入身高和体重',
                duration: 2000,
                bottom: 50
              });
            }
          })
      }
      // 显示计算结果
      if (this.count > 0) {
        Text(`您的BMI为：${this.count}`)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 20 })
          .fontColor('#1f1f1f')
        Text(`(国际(WHO)BMI指数健康范围18.5 ~ 24.9)`)
          .fontSize(14)
          // .fontWeight(FontWeight.Bold)
          .margin({ top: 20 })
          .fontColor('#1f1f1f')
        Text(`历史记录`)
          .fontSize(14)
            // .fontWeight(FontWeight.Bold)
          .fontColor('rgba(255,200,108,1)')
          .decoration({ type: TextDecorationType.Underline,color: 'rgba(255,200,108,1)',})
          .margin({ top: 20 })
          .onClick(() => {
            //todo:pushUrl
            router.pushUrl({url:'pages/BMI/HistoricalRecordsPage'})
          })
      }
    }.width('100%')
    .height('100%')

  }
}