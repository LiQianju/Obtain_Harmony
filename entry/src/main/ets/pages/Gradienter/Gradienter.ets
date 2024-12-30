// 导入传感器服务模块
import { sensor } from '@kit.SensorServiceKit';
// 导入业务错误处理模块
import { BusinessError } from '@kit.BasicServicesKit';

// 定义单位长度，用于后续计算中的比例尺
const UNIT_LENGTH = 4;

// 使用 @Entry 和 @Component 装饰器定义一个名为 LevelMeter 的组件
@Entry
@Component
struct LevelMeter {
  // 定义状态变量，用于存储当前角度
  @State angle: number = 0;
  // 定义状态变量，用于存储前后倾斜角度（pitch）
  @State pitch: number = 0;
  // 定义状态变量，用于存储左右倾斜角度（roll）
  @State roll: number = 0;
  // 定义角度变化阈值，用于判断是否需要更新角度
  private threshold: number = 1;

  // 组件即将出现时的生命周期方法
  aboutToAppear(): void {
    // 获取传感器列表
    sensor.getSensorList((error: BusinessError) => {
      if (error) {
        // 如果获取传感器列表失败，输出错误信息
        console.error('获取传感器列表失败', error);
        return;
      }
      // 开始更新方向信息
      this.startOrientationUpdates();
    });
  }

  // 启动方向更新的方法
  private startOrientationUpdates(): void {
    // 注册加速度传感器事件监听器
    sensor.on(sensor.SensorId.ACCELEROMETER, (data) => {
      // 计算新的前后倾斜角度（pitch）
      const newPitch = Math.atan(data.y / Math.sqrt(data.x * data.x + data.z * data.z)) * (180 / Math.PI);
      // 计算新的左右倾斜角度（roll）
      const newRoll = Math.atan(data.x / Math.sqrt(data.y * data.y + data.z * data.z)) * (180 / Math.PI);

      // 如果新的角度变化超过阈值，则更新状态
      if (Math.abs(newPitch - this.pitch) > this.threshold || Math.abs(newRoll - this.roll) > this.threshold) {
        this.pitch = newPitch;
        this.roll = newRoll;
        // 更新当前角度
        this.angle = Math.hypot(newPitch, newRoll);
      }
    }, { interval: 100000000 }); // 设置更新间隔为100毫秒
  }

  // 计算小球位置的方法
  private calculateBallPosition(): Position {
    // 根据当前角度计算半径
    const radius = (this.angle <= 10 ? this.angle * 2.5 : (10 * 2.5 + (this.angle - 10))) * UNIT_LENGTH;
    // 将角度转换为弧度
    const angleInRadians = Math.atan2(this.pitch, this.roll);

    // 计算小球在圆周上的X坐标
    const x = -radius * Math.cos(angleInRadians);
    // 计算小球在圆周上的Y坐标
    const y = radius * Math.sin(angleInRadians);

    // 返回小球的位置
    return { x, y };
  }

  // 构建UI的方法
  build() {
    // 使用Stack布局容器
    Stack() {
      // 显示当前角度的文本
      Stack() {
        Row({ space: 5 }) { // 创建一个行布局，设置间距为5
          Text(`${Math.floor(this.angle)}°`)// 显示当前角度
            .layoutWeight(1)// 设置布局权重
            .textAlign(TextAlign.Center)// 文本对齐方式
            .fontColor('#dedede')// 文本颜色
            .fontSize(60); // 文本大小
        }.width('100%').margin({ top: 80 }) // 设置宽度和上边距
      }.height('100%').align(Alignment.Top) // 设置高度和对齐方式

      // 模拟水平仪背景的圆环
      Stack() {
        // 外部大圆
        Text()
          .width('600lpx')// 设置宽度
          .height('600lpx')// 设置高度
          .borderRadius('50%')// 设置圆角
          .backgroundColor("#171b1e")// 设置背景颜色
          .blur(50)// 设置模糊效果
          .shadow({ radius: 300, type: ShadowType.COLOR, color: "#232426" }); // 设置阴影效果

        // 中间圆
        Text()
          .width(`${(this.angle <= 10 ? this.angle * 2.5 : (10 * 2.5 + (this.angle - 10))) * UNIT_LENGTH *
            2}lpx`)// 计算宽度
          .height(`${(this.angle <= 10 ? this.angle * 2.5 : (10 * 2.5 + (this.angle - 10))) * UNIT_LENGTH *
            2}lpx`)// 计算高度
          .borderRadius('50%')// 设置圆角
          .backgroundColor("#2e3235")// 设置背景颜色
          .animation({ curve: Curve.EaseOut }); // 设置动画效果

        // 刻度线
        ForEach([10, 20, 30, 40, 50], (item: number) => {
          Text()
            .width(`${(15 + item) * UNIT_LENGTH * 2}lpx`)// 计算宽度
            .height(`${(15 + item) * UNIT_LENGTH * 2}lpx`)// 计算高度
            .borderWidth(1)// 设置边框宽度
            .borderRadius('50%')// 设置圆角
            .borderColor("#807d8184"); // 设置边框颜色

          // 刻度数字
          Text(`${item}`)
            .width(20)// 设置宽度
            .fontColor("#7d8184")// 设置字体颜色
            .fontSize(10)// 设置字体大小
            .textAlign(TextAlign.Center)// 设置文本对齐方式
            .margin({ left: `${(15 + item) * UNIT_LENGTH * 2}lpx` }); // 设置左边距
        });

        // 小球
        Text()
          .width(14)// 设置宽度
          .height(14)// 设置高度
          .backgroundColor("#ff5841")// 设置背景颜色
          .borderRadius('50%'); // 设置圆角

        // 小球背景
        Stack() {
          Stack() {
          }
          .radialGradient({
            center: [20, 20], // 设置渐变中心点
            radius: 60, // 设置渐变半径
            colors: [
              ["#807a7a83", 0.0], // 渐变颜色1
              ["#8074747e", 0.7], // 渐变颜色2
              ["#80898992", 1.0]// 渐变颜色3
            ]
          }).width('100%').height('100%') // 设置宽度和高度
        }
        .clip(true) // 设置裁剪
        .radialGradient({
          center: [20, 20], // 设置渐变中心点
          radius: 60, // 设置渐变半径
          colors: Math.floor(this.angle) === 0 ?
            [["#FF6B6B", 0.0], ["#D84315", 0.3], ["#C62828", 1.0]] : // 当角度为0时的渐变颜色
            [["#bcbcc6", 0.0], ["#464650", 0.3], ["#474750", 1.0]] // 当角度不为0时的渐变颜色
        })
        .width(50) // 设置宽度
        .height(50) // 设置高度
        .borderRadius('50%') // 设置圆角
        .translate({
          x: `${this.calculateBallPosition().x}lpx`, // 设置X轴偏移
          y: `${this.calculateBallPosition().y}lpx` // 设置Y轴偏移
        })
        .animation({ curve: Curve.EaseOut }); // 设置动画效果
      }.width('580lpx').height('580lpx').borderRadius('50%') // 设置外部大圆的宽度、高度和圆角
    }.height('100%') // 设置Stack的高度
    .width('100%') // 设置Stack的宽度
    .backgroundColor("#18181a"); // 设置背景颜色
  }
}