import { window } from '@kit.ArkUI'; // 导入窗口相关的API
import { deviceInfo } from '@kit.BasicServicesKit'; // 导入设备信息相关的API

// 定义直尺线类
class RulerLine {
  index: number; // 线的索引
  height: number; // 线的高度

  constructor(index: number, height: number) {
    this.index = index; // 初始化索引
    this.height = height; // 初始化高度
  }

  // 显示线的编号
  showNumber(): string {
    return this.index % 10 === 0 ? `${Math.floor(this.index / 10)}` : ''; // 每10个线显示一个编号
  }
}

// 扩展文本样式
@Extend(Text)
function fancy() {
  .fontColor("#019dfe") // 设置字体颜色
  .fontSize(20); // 设置字体大小
}

// 定义直尺组件
@Entry
@Component
struct RulerComponent {
  @State maxRulerHeight: number = 0; // 最大直尺高度
  @State @Watch('onCellWidthChanged') cellWidthInPixels: number = 17.28; // 每毫米对应的像素
  @State textWidth: number = 80; // 文本宽度
  @State rulerLines: RulerLine[] = []; // 直尺线数组
  @State leftOffsetX: number = -300; // 左侧偏移
  @State currentPositionX: number = -300; // 当前X位置
  @State @Watch('onContainerHeightChanged') containerHeight: number = 53; // 容器高度
  @State originalContainerHeight: number = 53; // 原始容器高度
  @State @Watch('onCellWidthChanged') containerWidth: number = 0; // 容器宽度

  // 处理单元格宽度变化
  onCellWidthChanged() {
    this.maxRulerHeight = vp2px(this.containerWidth) / this.cellWidthInPixels / 10; // 更新最大直尺高度
  }

  // 处理容器高度变化
  onContainerHeightChanged() {
    this.containerHeight = Math.max(this.containerHeight, 53); // 确保容器高度不小于53
  }

  // 组件即将出现时
  aboutToAppear(): void {
    // 设置当前应用为横屏显示
    window.getLastWindow(getContext()).then((windowClass) => {
      windowClass.setPreferredOrientation(window.Orientation.LANDSCAPE); // 设置为横屏
    });

    // 初始化直尺线
    for (let i = 0; i <= 15 * 10; i++) {
      let lineHeight: number = (i % 10 === 0) ? 90 : (i % 5 === 0) ? 60 : 45; // 根据索引设置线的高度
      this.rulerLines.push(new RulerLine(i, lineHeight)); // 将新线添加到数组中
    }
  }

  // 构建UI
  build() {
    Column() { // 创建一个列布局
      Stack() { // 创建一个堆叠布局
        Stack() { // 创建另一个堆叠布局
          ForEach(this.rulerLines, (line: RulerLine, index: number) => { // 遍历直尺线数组
            Line()// 创建一条线
              .width(1)// 设置线宽
              .height(`${line.height}px`)// 设置线高
              .backgroundColor(Color.White)// 设置线的背景颜色
              .margin({ left: `${this.cellWidthInPixels * index}px` }); // 设置线的左边距
            Text(line.showNumber())// 显示线的编号
              .fontColor(Color.White)// 设置字体颜色
              .fontSize(18)// 设置字体大小
              .width(`${this.textWidth}px`)// 设置文本宽度
              .height(`${this.textWidth}px`)// 设置文本高度
              .textAlign(TextAlign.Center)// 设置文本对齐方式
              .margin({
                left: `${this.cellWidthInPixels * index - this.textWidth / 2}px`,
                top: `${line.height}px`
              }); // 设置文本位置
          });
        }.width('100%').height('100%').align(Alignment.TopStart); // 设置堆叠布局的宽高和对齐方式

        Column({ space: 15 }) { // 创建一个列布局，设置间距
          Text(`当前设备：${deviceInfo.marketName}`).fancy(); // 显示当前设备名称
          Counter() { // 创建一个计数器
            Text(`选中区距离：${this.maxRulerHeight.toFixed(2)}厘米`).fancy(); // 显示选中区距离
          }
          .foregroundColor(Color.White) // 设置计数器字体颜色
          .width(300) // 设置计数器宽度
          .onInc(() => { // 增加计数器时的处理
            this.containerHeight = px2vp(vp2px(this.containerHeight) + this.cellWidthInPixels / 10); // 更新容器高度
          })
          .onDec(() => { // 减少计数器时的处理
            this.containerHeight = px2vp(vp2px(this.containerHeight) - this.cellWidthInPixels / 10); // 更新容器高度
          });

          Counter() { // 创建另一个计数器
            Text(`每毫米间距：${this.cellWidthInPixels.toFixed(2)}px`).fancy(); // 显示每毫米间距
          }
          .foregroundColor(Color.White) // 设置计数器字体颜色
          .width(300) // 设置计数器宽度
          .onInc(() => { // 增加计数器时的处理
            this.cellWidthInPixels += 0.01; // 增加每毫米间距
          })
          .onDec(() => { // 减少计数器时的处理
            this.cellWidthInPixels = Math.max(0.01, this.cellWidthInPixels - 0.01); // 减少每毫米间距，确保不小于0.01
          });
        }

        RelativeContainer() { // 创建一个相对布局容器
          Rect()// 创建一个矩形
            .fill("#80019dfe")// 设置填充颜色
            .borderColor("#019dfe")// 设置边框颜色
            .borderWidth({ left: 1, right: 1 })// 设置边框宽度
            .clip(true)// 启用裁剪
            .width("100%")// 设置宽度为100%
            .height("100%")// 设置高度为100%
            .onAreaChange((oldArea: Area, newArea: Area) => { // 处理区域变化
              this.containerWidth = newArea.width as number; // 更新容器宽度
            });

          Stack() { // 创建一个堆叠布局
            Circle({ height: 30, width: 30 })// 创建一个圆形
              .fill("#019dfe")// 设置填充颜色
              .stroke(Color.Transparent)// 设置边框颜色为透明
              .strokeWidth(3); // 设置边框宽度
            Circle({ height: 40, width: 40 })// 创建另一个圆形
              .fill(Color.Transparent)// 设置填充颜色为透明
              .stroke("#019dfe")// 设置边框颜色
              .strokeWidth(3); // 设置边框宽度
          }
          .hitTestBehavior(HitTestMode.Block) // 设置碰撞检测行为
          .padding(20) // 设置内边距
          .alignRules({
            // 设置对齐规则
            center: { anchor: "__container__", align: VerticalAlign.Center }, // 垂直居中
            middle: { anchor: "__container__", align: HorizontalAlign.Start } // 左对齐
          })
          .gesture(PanGesture({
            // 左侧拖动手势
            fingers: 1, // 单指拖动
            direction: PanDirection.Horizontal, // 水平拖动
            distance: 1 // 最小拖动距离
          }).onActionUpdate((event: GestureEvent) => { // 拖动更新时的处理
            this.leftOffsetX = this.currentPositionX + event.offsetX / 2; // 更新左侧偏移
            this.containerHeight = this.originalContainerHeight - event.offsetX; // 更新容器高度
          }).onActionEnd(() => { // 拖动结束时的处理
            this.currentPositionX = this.leftOffsetX; // 更新位置
            this.originalContainerHeight = this.containerHeight; // 更新原始高度
          }));

          Stack() { // 创建另一个堆叠布局
            Circle({ height: 30, width: 30 })// 创建一个圆形
              .fill("#019dfe")// 设置填充颜色
              .stroke(Color.Transparent)// 设置边框颜色为透明
              .strokeWidth(3); // 设置边框宽度
            Circle({ height: 40, width: 40 })// 创建另一个圆
              .fill(Color.Transparent)// 设置填充颜色为透明
              .stroke("#019dfe")// 设置边框颜色
              .strokeWidth(3); // 设置边框宽度
          }
          .hitTestBehavior(HitTestMode.Block) // 设置碰撞检测行为
          .padding(20) // 设置内边距
          .alignRules({
            // 设置对齐规则
            center: { anchor: "__container__", align: VerticalAlign.Center }, // 垂直居中
            middle: { anchor: "__container__", align: HorizontalAlign.End } // 右对齐
          })
          .gesture(PanGesture({
            // 右侧拖动手势
            fingers: 1, // 单指拖动
            direction: PanDirection.Horizontal, // 水平拖动
            distance: 1 // 最小拖动距离
          }).onActionUpdate((event: GestureEvent) => { // 拖动更新时的处理
            this.leftOffsetX = this.currentPositionX + event.offsetX / 2; // 更新左侧偏移
            this.containerHeight = this.originalContainerHeight + event.offsetX; // 更新容器高度
          }).onActionEnd(() => { // 拖动结束时的处理
            this.currentPositionX = this.leftOffsetX; // 更新位置
            this.originalContainerHeight = this.containerHeight; // 更新原始高度
          }));
        }
        .width(this.containerHeight) // 设置宽度
        .height("100%") // 设置高度
        .translate({ x: this.leftOffsetX }) // 使用左侧偏移
        .gesture(PanGesture({
          // 左侧拖动手势
          fingers: 1, // 单指拖动
          direction: PanDirection.Horizontal, // 水平拖动
          distance: 1 // 最小拖动距离
        }).onActionUpdate((event: GestureEvent) => { // 拖动更新时的处理
          if (event) {
            this.leftOffsetX = this.currentPositionX + event.offsetX; // 更新左侧偏移
          }
        }).onActionEnd(() => { // 拖动结束时的处理
          this.currentPositionX = this.leftOffsetX; // 更新位置
        }));
      }
    }.height('100%').width('100%') // 设置高度和宽度
    .padding({ left: 30, right: 10 }) // 设置内边距
    .backgroundColor("#181b22"); // 设置背景颜色
  }
}