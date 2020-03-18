import 'package:flutter/material.dart';
import 'package:amap_map_fluttify/amap_map_fluttify.dart';

class MapDemo extends StatefulWidget {
  MapDemo({Key key}) : super(key: key);

  @override
  _MapDemoState createState() => _MapDemoState();
}

class _MapDemoState extends State<MapDemo> {
  @override
  void initState() async {
    super.initState();
    await AmapService.init(
        iosKey: '7a04506d15fdb7585707f7091d715ef4',
        androidKey: '7c9daac55e90a439f7b4304b465297fa');
    await enableFluttifyLog(true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: AmapView(
      mapType: MapType.Standard,
      // 是否显示缩放控件 (可选)
      showZoomControl: true,
      // 是否显示指南针控件 (可选)
      showCompass: true,
      // 是否显示比例尺控件 (可选)
      showScaleControl: true,
      // 是否使能缩放手势 (可选)
      zoomGesturesEnabled: true,
      // 是否使能滚动手势 (可选)
      scrollGesturesEnabled: true,
      // 是否使能旋转手势 (可选)
      rotateGestureEnabled: true,
      // 是否使能倾斜手势 (可选)
      tiltGestureEnabled: true,
      // 缩放级别 (可选)
      zoomLevel: 10,
      // 中心点坐标 (可选)
      centerCoordinate: LatLng(39, 116),
      // 标记 (可选)
      markers: <MarkerOption>[],
      // 标识点击回调 (可选)
      onMarkerClicked: (Marker marker) {},
      // 地图点击回调 (可选)
      onMapClicked: (LatLng coord) {},
      // 地图拖动回调 (可选)
      // onMapMoveEnd: (MapDrag drag) {},
      // 地图创建完成回调 (可选)
      onMapCreated: (controller) async {
        // requestPermission是权限请求方法, 需要你自己实现
        // 如果不知道怎么处理, 可以参考example工程的实现, example过程依赖了`permission_handler`插件.
        // if (await requestPermission()) {
        //   await controller.showMyLocation(true);
        // }
      },
    ));
  }
}
