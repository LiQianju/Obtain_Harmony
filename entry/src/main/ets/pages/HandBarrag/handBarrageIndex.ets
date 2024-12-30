import { router } from '@kit.ArkUI'

@Component
struct InputCompomentsNormal {
  onTextChange?: (value: string) => void
  placeholder?: string
  build() {
    TextInput({
      placeholder: this.placeholder,
    })
      .width('70%')
      .caretColor('')
      .borderRadius(0)
      .type(InputType.Normal)
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
struct handBarrageIndex {
  @State inputValue_text: String = ''
  @State textBole_No: boolean = true;
  @State textItalic_No: boolean = true;
  @State fontSize: number = 0;
  @State scrollSpeed: number = 0;

  build() {
    Column({ space: 0 }) {
      Flex({
        direction: FlexDirection.Column,
        justifyContent: FlexAlign.Start
      }) {
        Flex({
          direction: FlexDirection.Column,
          justifyContent: FlexAlign.Center
        }) {
          Text('文字')
            .fontColor('#999999')
            .fontSize(13)
          InputCompomentsNormal({
            onTextChange: (value: string) => {
              this.inputValue_text = value;
            },
            placeholder: '请填装弹幕'
          }).width('142%')
            .height(50)
        }
        .width('100%')
        .height(70)
        .backgroundColor('#ffffff')
        .margin({
          top: 10,
          right: 5,
          left: 5
        })
        .padding({
          top: 5,
          right: 5,
          left: 5
        })

        Flex({
          direction: FlexDirection.Row,
          justifyContent: FlexAlign.SpaceBetween
        }) {
          Button('B')
            .type(ButtonType.Normal)
            .fontColor('#1f1f1f')
            .width('49%')
            .backgroundColor('#ffffff')
            .onClick(() => {
              this.textBole_No=false
            })
          Button('I')
            .type(ButtonType.Normal)
            .fontColor('#1f1f1f')
            .width('49%')
            .backgroundColor('#ffffff')
            .onClick(() => {
              this.textItalic_No=false
            })
        }.padding({
          top: 5,
          right: 5,
          left: 5
        })

        Flex({
          direction: FlexDirection.Row,
          justifyContent: FlexAlign.SpaceBetween
        }) {
          Button('文本颜色')
            .type(ButtonType.Normal)
            .fontColor('#1f1f1f')
            .width('100%')
            .backgroundColor('#ffffff')
            .onClick(() => {
              //todo:pushUrl
              router.pushUrl({ url: 'pages/router/pushAndReplace/BMIPage' })
            })
        }.padding({
          top: 5,
          right: 5,
          left: 5
        })
        Flex({
          direction: FlexDirection.Row,
          justifyContent: FlexAlign.SpaceBetween
        }) {
          Button('背景颜色')
            .type(ButtonType.Normal)
            .fontColor('#1f1f1f')
            .width('100%')
            .backgroundColor('#ffffff')
            .onClick(() => {
              //todo:pushUrl
              router.pushUrl({ url: 'pages/router/pushAndReplace/BMIPage' })
            })
        }.padding({
          top: 5,
          right: 5,
          left: 5
        })

        Flex({
          direction: FlexDirection.Column,
          justifyContent: FlexAlign.Center
        }) {
          Text('字体大小')
            .fontColor('#999999')
            .fontSize(13)
          // Text(this.fontSize.toString())
          Slider({max:99,min:1,value:50}).width("96%")
            .selectedColor('rgba(255, 200, 108, 0.5)')
            .onChange((value: number, mode: SliderChangeMode) => {
              this.fontSize = value;
            })
        }
        .width('100%')
        .height(70)
        .backgroundColor('#ffffff')
        .margin({
          top: 5,
          right: 5,
          left: 5
        })
        .padding({
          top: 5,
          right: 5,
          left: 5
        })
        Flex({
          direction: FlexDirection.Column,
          justifyContent: FlexAlign.Center
        }) {
          Text('滚动速度')
            .fontColor('#999999')
            .fontSize(13)
          // Text(this.scrollSpeed.toString())
          Slider({max:99,min:1,value:50}).width("96%")
            .selectedColor('rgba(255, 200, 108, 0.5)')
            .onChange((value: number, mode: SliderChangeMode) => {
              this.scrollSpeed = value;
            })
        }
        .width('100%')
        .height(70)
        .backgroundColor('#ffffff')
        .margin({
          top: 5,
          right: 5,
          left: 5
        })
        .padding({
          top: 5,
          right: 5,
          left: 5
        })

        Flex({
          direction: FlexDirection.Row,
          justifyContent: FlexAlign.Center
        }) {
          Button('开始')
            .type(ButtonType.Normal)
            .fontColor('#1f1f1f')
            .width('80%')
            .backgroundColor('#f5f5f5')
            .borderRadius(10)
            .shadow({
              radius:8,
              color:'rgba(0, 0, 0, 0.2)',
              offsetX:6,
              offsetY:6
            })
              // .compButtonStyle22()
            .onClick(() => {
              //todo:replaceUrl
              router.pushUrl({url:'pages/router/pushAndReplace/CaloriesPage'})
            })
        }.padding({
          top: 10,
          right: 5,
          left: 5
        })

      }.width('100%')
      .height('100%')
      .backgroundColor('#f0f0f0')
      // .justifyContent(FlexAlign.Center)
    }
  }
  // @Styles compButtonStyle22() {
  //   .width('40%')
  //   .backgroundColor('#f5f5f5')
  //   .borderRadius(10)
  //   .shadow({
  //     radius:8,
  //     color:'rgba(0, 0, 0, 0.2)',
  //     offsetX:6,
  //     offsetY:6
  //   })
  // }
}