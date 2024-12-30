import router from '@ohos.router'


@Entry
@Component
struct TargetPage {
  data: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
  scroller: Scroller = new Scroller();

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
      }).padding({ bottom: 10,left:10,top:10 })


      Stack({ alignContent: Alignment.BottomEnd }) {
        List({ space: 2, scroller: this.scroller }) {
          ForEach(this.data, (item:Object) => {
            ListItem() {
              Text(item.toString())
                .itemTextStyle()
            }
          })
        }.listStyle()
        .height('100%')
        .width('100%')

        Button({ type: ButtonType.Circle }) {
          Image($r('app.media.icon_top'))
            .width(30)
            .height(30)
        }
        .width(60)
        .height(60)
        .backgroundColor('rgba(255,200,108,0.5)')
        .offset({ x: -20, y: -100 })
        .onClick(() => {
          this.scroller.scrollToIndex(0)
        })
      }


    }.width('100%')
    .height('100%')

  }
}

@Extend(Text) function itemTextStyle() {
  .height(60)
  .width('100%')
  .textAlign(TextAlign.Center)
  .fontColor('#1f1f1f')
  .fontSize(20)
  // .fontWeight(FontWeight.Bold)
  .backgroundColor('#f5f5f5')
  .borderRadius(0)
}

@Extend(List) function listStyle() {
  .backgroundColor(Color.White)
  .padding(20)
}