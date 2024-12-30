import router from '@ohos.router'

// 观察者模式装饰器
@ObservedV2
class Cell {
  value: string = '功德+1'; // 默认显示的文字
  @Trace // 跟踪属性变化
  opacity: number = 0; // 文字透明度
  @Trace // 跟踪属性变化
  y: number = 0; // 文字的垂直偏移量
}

// 主入口组件
@Entry
@Component
struct Index {
  @State list: Cell[] = []; // 存储所有 Cell 对象的数组
  indexCount: number = 0; // 记录当前滚动的索引
  count: number = 10; // 列表中 Cell 对象的数量
  image: string =
    'data:image/png;base64,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'

  // 初始化方法，在组件即将显示时被调用
  aboutToAppear(): void {
    for (let i = 0; i < this.count; i++) {
      this.list.push(new Cell()); // 初始化 Cell 数组
    }
  }

  // 构建 UI 的方法
  build() {
    Column() { // 创建一个垂直布局容器
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
      }).padding({left:10,top:10 })
      Stack() { // 创建一个堆栈布局容器
        ForEach(this.list, (item: Cell, _index: number) => { // 遍历 list 中的每一个 Cell
          Text(item.value)// 显示 Cell 中的文字
            .fontColor(Color.White)// 设置文字颜色为白色
            .fontSize('50lpx')// 设置文字大小
            .translate({ x: 0, y: `${item.y}lpx` })// 设置文字的垂直偏移量
            .opacity(item.opacity) // 设置文字的透明度
        })
      }
      .width('300lpx') // 设置堆栈布局容器的宽度
      .height('300lpx') // 设置堆栈布局容器的高度
      .align(Alignment.BottomEnd) // 设置对齐方式为底部右端

      Image(this.image)// 显示图片
        .width('300lpx')// 设置图片宽度
        .height('300lpx')// 设置图片高度
        .objectFit(ImageFit.Contain)// 图片适应容器
        .clickEffect({
          // 点击效果配置
          scale: 0.5, // 缩放比例
          level: ClickEffectLevel.LIGHT // 效果级别
        })
        .onClick(() => { // 点击图片时触发的回调
          let index = this.indexCount % this.count; // 计算当前滚动的索引
          this.indexCount++; // 更新索引计数器
          animateToImmediately({
            // 立即开始动画
            duration: 0, // 动画持续时间为0毫秒
            onFinish: () => { // 动画完成后的回调
              animateToImmediately({
                // 再次立即开始动画
                duration: 1000, // 动画持续时间为1000毫秒
              }, () => {
                this.list[index].y = -200 // 设置 Cell 的垂直偏移量
                this.list[index].opacity = 0 // 设置 Cell 的透明度
              })
            }
          }, () => {
            this.list[index].y = 0 // 设置 Cell 的垂直偏移量
            this.list[index].opacity = 1 // 设置 Cell 的透明度
          })
        })
    }
    .height('100%') // 设置容器高度为100%
    .width('100%') // 设置容器宽度为100%
    .backgroundColor(Color.Black) // 设置背景颜色为黑色
  }
}