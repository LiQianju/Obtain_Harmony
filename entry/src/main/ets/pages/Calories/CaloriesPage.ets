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
  @State inputValue_energy: number = 0
  @State inputValue_netContent: number = 0
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
      }).padding({ bottom: 180,left:10,top:10 })
      InputCompoments({
        onTextChange: (value: string) => {
          // 这里将输入值转换为数字，并更新状态
          const energy = parseFloat(value);
          if (!isNaN(energy)) {
            this.inputValue_energy = energy;
          }
        },
        placeholder: '请输入能量/千焦(每100g)'
      })
      InputCompoments({
        onTextChange: (value: string) => {
          // 这里将输入值转换为数字，并更新状态
          const netContent = parseFloat(value);
          if (!isNaN(netContent)) {
            this.inputValue_netContent = netContent;
          }
        },
        placeholder: '请输入净含量/g'
      })
        .margin({ top: 50,bottom:20 })
      Text('*此处参考名称为食品外包装的打印名称，”能量“数据请参考营养成分表')
        .fontSize(14)
      Text('计算公式：一份=能量*净含量/100*0.24')
        .fontSize(14)
      Text('（能量单位：千焦；净含量单位：克或毫升）')
        .fontSize(14)

      Row({ space: 50 }) {
        // Button('重置')
        //   .type(ButtonType.Normal)
        //   .fontColor('#1f1f1f')
        //   .onClick(() => {
        //     //刷新整个页面
        //   })
        Button('点击计算食物热量')
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
            if (this.inputValue_energy > 0 && this.inputValue_netContent > 0) {
              this.count = parseFloat((this.inputValue_energy * this.inputValue_netContent / 100*0.24).toFixed(2));
              console.info(`结果: 卡路里 = ${this.count}`);
            }
            else{
              promptAction.showToast({
                message: '请输入能量和净含量',
                duration: 2000,
                bottom: 50
              });
            }
          })
      }
      // 显示计算结果
      if (this.count > 0) {
        Text(`此件食物的热量为：${this.count}大卡`)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 20 })
          .fontColor('#1f1f1f')
      }
    }.width('100%')
    .height('100%')
  }
}