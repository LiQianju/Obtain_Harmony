import { window } from '@kit.ArkUI';

@Entry
@Component
struct handBarrageIndex {

  build() {
    // 设置页面为横屏
    // window.Orientation = "LANDSCAPE";
    // 组件即将出现时

    // 使用Row布局，避免列过长影响横屏展示
    Row({ space: 0 }) {
      Text('想那一刻，他和上帝和解了。——《阿甘正传》')
        .fontSize(14) // 调整字体大小
        .textAlign(TextAlign.Start) // 文本起始对齐
        .fontWeight(FontWeight.Lighter) // 设置较轻的字体
        .lineHeight(18) // 设置行高，避免文本重叠
        .flexGrow(1) // 增加flex属性使其适应横屏布局
    }
  }
}