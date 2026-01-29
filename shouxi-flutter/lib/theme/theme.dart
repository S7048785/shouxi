import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class MyTheme {
  final TextTheme textTheme;

  const MyTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,

      // 设置主题亮度模式为亮色模式
      primary: Color(0xfff97316),
      // 主要颜色，用于强调重要的界面元素
      surfaceTint: Color(0xff9ca3af),
      // 表面色调，通常用于表面背景上的一些微小变化
      onPrimary: Color(0xffffffff),
      // 在主要颜色上的文字或图标颜色，确保对比度和可读性
      primaryContainer: Color(0xffffffff),
      // 主容器颜色，通常用于包含主颜色的组件背景
      onPrimaryContainer: Color(0xff001d36),
      // 在主容器颜色上的内容颜色（如文本或图标）
      secondary: Color(0xffea580c),
      // 辅助颜色，用于不太突出但需要区分的元素
      onSecondary: Color(0xffffedd5),
      // 在辅助颜色上的内容颜色
      secondaryContainer: Color(0xffd7e3f7),
      // 导航栏按钮背景色
      onSecondaryContainer: Color(0xff101c2b),
      // 导航栏按钮图标选中颜色
      tertiary: Color(0xfffed7aa),
      // 第三种颜色，可用于特定情境下的分隔或装饰
      onTertiary: Color(0xffffffff),
      // 在第三种颜色上的内容颜色
      tertiaryContainer: Color(0xfff2daff),
      // 第三容器颜色，与tertiary搭配使用
      onTertiaryContainer: Color(0xff251431),
      // 在第三容器颜色上的内容颜色
      error: Color(0xffba1a1a),
      // 错误颜色，用于错误消息或警告
      onError: Color(0xffffffff),
      // 在错误颜色上的内容颜色
      errorContainer: Color(0xffffdad6),
      // 错误容器颜色，用于包含错误信息的组件背景
      onErrorContainer: Color(0xff93000a),
      // 在错误容器颜色上的内容颜色
      surface: Color(0xfff9fafb),
      // 屏幕背景色，提供一致的背景环境
      onSurface: Color(0xff1c1b1b),
      // 在屏幕背景色上的内容颜色
      onSurfaceVariant: Color(0xff444748),
      // 变体上的内容颜色，用于不同的表面变体
      outline: Color(0xffC3C3C3),
      // 描边颜色，用于绘制边界线
      outlineVariant: Color(0xffc4c7c8),
      // 描边颜色变体
      shadow: Colors.white60,
      // 阴影颜色，用于给元素增加深度感
      scrim: Color(0xff000000),
      // 覆盖层颜色，用于遮罩部分界面
      inverseSurface: Color(0xff313030),
      // 反转的表面颜色，用于在深色背景下显示浅色内容
      inversePrimary: Color(0xffc6c6c7),
      // 反转的主要颜色
      primaryFixed: Color(0xffe2e2e2),
      // 固定的主要颜色变体
      onPrimaryFixed: Color(0xff1a1c1c),
      // 在固定主要颜色上的内容颜色
      primaryFixedDim: Color(0xffc6c6c7),
      // 暗淡固定的主要颜色
      onPrimaryFixedVariant: Color(0xff585a5a),
      // 在固定主要颜色变体上的内容颜色
      secondaryFixed: Color(0xffe2e2e2),
      // 固定的辅助颜色变体
      onSecondaryFixed: Color(0xff1a1c1c),
      // 在固定辅助颜色上的内容颜色
      secondaryFixedDim: Color(0xffc6c6c7),
      // 暗淡固定的辅助颜色
      onSecondaryFixedVariant: Color(0xff454747),
      // 在固定辅助颜色变体上的内容颜色
      tertiaryFixed: Color(0xffe2e2e2),
      // 固定的第三颜色变体
      onTertiaryFixed: Color(0xff1a1c1c),
      // 在固定第三颜色上的内容颜色
      tertiaryFixedDim: Color(0xffc6c6c7),
      // 暗淡固定的第三颜色
      onTertiaryFixedVariant: Color(0xff454747),
      // 在固定第三颜色变体上的内容颜色
      surfaceDim: Color(0xffddd9d9),

      // 暗淡的表面颜色
      surfaceBright: Color(0xfffcf8f8),
      // 明亮的表面颜色
      surfaceContainerLowest: Color(0xffffffff),
      // 最低高度的容器背景色
      surfaceContainerLow: Color(0xffffffff),
      // 低高度的容器背景色，例如提升按钮的背景
      surfaceContainer: Color(0xffffffff),
      // 导航栏背景色
      surfaceContainerHigh: Color(0xfff0f0f0),
      // 高度较高的容器背景色，如搜索框背景色
      surfaceContainerHighest: Color(0xffe5e2e1), // 最高高度的容器背景色
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffa0cafd),
      surfaceTint: Color(0xffc6c6c7),
      onPrimary: Color(0xff003258),
      primaryContainer: Color(0xff194975),
      onPrimaryContainer: Color(0xffd1e4ff),
      secondary: Color(0xffbbc7db),
      onSecondary: Color(0xff253140),
      // 导航栏按钮背景色
      secondaryContainer: Color(0xff3b4858),
      onSecondaryContainer: Color(0xffd7e3f7),
      tertiary: Color(0xffd6bee4),
      onTertiary: Color(0xff3b2948),
      tertiaryContainer: Color(0xff523f5f),
      onTertiaryContainer: Color(0xfff2daff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff111418),
      onSurface: Color(0xffe1e2e8),
      onSurfaceVariant: Color(0xffc3c7cf),
      outline: Color(0xff3e3e3e),
      outlineVariant: Color(0xff444748),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff5d5f5f),
      primaryFixed: Color(0xffe2e2e2),
      onPrimaryFixed: Color(0xff1a1c1c),
      primaryFixedDim: Color(0xffc6c6c7),
      onPrimaryFixedVariant: Color(0xff454747),
      secondaryFixed: Color(0xffe2e2e2),
      onSecondaryFixed: Color(0xff1a1c1c),
      secondaryFixedDim: Color(0xffc6c6c7),
      onSecondaryFixedVariant: Color(0xff454747),
      tertiaryFixed: Color(0xffe2e2e2),
      onTertiaryFixed: Color(0xff1a1c1c),
      tertiaryFixedDim: Color(0xffc6c6c7),
      onTertiaryFixedVariant: Color(0xff454747),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff3a3939),
      surfaceContainerLowest: Color(0xff0e0e0e),
      // 按钮背景色
      surfaceContainerLow: Color(0xff1c1c1c),
      surfaceContainer: Color(0xff201f1f),
      surfaceContainerHigh: Color(0xff2a2a2a),
      surfaceContainerHighest: Color(0xff353434),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    // 背景颜色
    scaffoldBackgroundColor: colorScheme.surface,

    canvasColor: colorScheme.surface,
    // 字体主题
    fontFamily: "Poppins",
    // 禁用组件点击时默认水波纹
    // splashFactory: NoSplash.splashFactory,
    // 导航栏返回按钮样式
    actionIconTheme: ActionIconThemeData(
      backButtonIconBuilder: (context) => const Icon(CupertinoIcons.back),
    ),
    // 底部导航栏主题
    navigationBarTheme: NavigationBarThemeData(
      elevation: 0,
      backgroundColor: Colors.transparent,
      indicatorColor: colorScheme.primary,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: Colors.white);
        }
        return IconThemeData(color: colorScheme.surfaceTint);
      }),
    ),
    // 按钮主题
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        backgroundColor: colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: colorScheme.surfaceTint, width: 1),
        ),
      ),
    ),
    // 升级按钮主题
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        // minimumSize: Size(200, 50),
        // maximumSize: Size(double.infinity, 50),
        // fixedSize: Size(double.infinity, 50),
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}
