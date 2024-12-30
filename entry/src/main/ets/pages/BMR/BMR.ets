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
  @State selected: boolean = true;
  @State inputValue_height: number = 0
  @State inputValue_weight: number = 0
  @State inputValue_ago: number = 0
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
      Row({ space: 14 }) {
        Text('请选择性别：')
        Toggle({ type: ToggleType.Button, isOn: this.selected }) {
          Text('女性')
        }.selectedColor('rgba(255, 200, 108, 0.5)')
        .onChange((isOn) => {
          this.selected = isOn;
        })

        Toggle({ type: ToggleType.Button, isOn: !this.selected }) {
          Text('男性')
        }.selectedColor('rgba(255, 200, 108, 0.5)')
        .onChange((isOn) => {
          this.selected = !isOn;
        })
      }.margin({ bottom:30 })

      InputCompoments({
        onTextChange: (value: string) => {
          // 这里将输入值转换为数字，并更新状态
          const ago = parseFloat(value);
          if (!isNaN(ago)) {
            this.inputValue_ago = ago;
          }
        },
        placeholder: '请输入年龄'
      }).margin({ bottom:30 })
      InputCompoments({
        onTextChange: (value: string) => {
          // 这里将输入值转换为数字，并更新状态
          const height = parseFloat(value);
          if (!isNaN(height)) {
            this.inputValue_height = height;
          }
        },
        placeholder: '请输入身高/cm'
      }).margin({ bottom:30 })
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
        .margin({ bottom:20 })
      Text('基础代谢率(BMR)计算公式使用Harris-Benedict方程')
        .fontSize(14)
      Text('（体重单位：千克；身高单位：厘米）')
        .fontSize(14)

      Row({ space: 50 }) {
        // Button('重置')
        //   .type(ButtonType.Normal)
        //   .fontColor('#1f1f1f')
        //   .onClick(() => {
        //     //刷新整个页面
        //   })
        Button('点击计算BMR')
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
            if (this.inputValue_height > 0 && this.inputValue_weight > 0 && this.inputValue_ago >0 && this.selected===true) {
              // 女性 (9.6 × 体重 kg) + (1.8 × 身高 cm) - (4.7 × 年龄) + 655
              // (9.6*this.inputValue_weight)+(1.8*this.inputValue_height)-(4.7*this.inputValue_ago)+655
              this.count = parseFloat(((9.6*this.inputValue_weight)+(1.8*this.inputValue_height)-(4.7*this.inputValue_ago)+655).toFixed(2));
              console.info(`结果: BMR = ${this.count}`);
            }
            else if (this.inputValue_height > 0 && this.inputValue_weight > 0 && this.inputValue_ago >0 && this.selected===false) {
              // 男性 BMR = (13.7 × 体重 kg) + (5.0 × 身高 cm) - (6.8 × 年龄) + 66
              // (13.7*this.inputValue_weight)+(5.0*this.inputValue_height)-(6.8*this.inputValue_ago)+66
              this.count = parseFloat(((13.7*this.inputValue_weight)+(5.0*this.inputValue_height)-(6.8*this.inputValue_ago)+66).toFixed(2));
              console.info(`结果: BMR = ${this.count}`);
            }
            else{
              promptAction.showToast({
                message: '请输入年龄、身高和体重',
                duration: 2000,
                bottom: 50
              });
            }
          })
      }
      // 显示计算结果
      if (this.count > 0) {
        Text(`您的基础代谢率（BMR）为：${this.count}大卡`)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 20 })
          .fontColor('#1f1f1f')
        Text(`*本基础代谢计算工具仅适用于一般情况，如需得到个人实际基础代谢情况请咨询专业人士。`)
          .fontSize(14)
            // .fontWeight(FontWeight.Bold)
          .margin({ top: 20 })
          .fontColor('#1f1f1f')
      }
    }.width('100%')
    .height('100%')
  }
}