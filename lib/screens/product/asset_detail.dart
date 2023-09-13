import 'package:flutter/material.dart';
import 'package:model_viewer/model_viewer.dart';

class AssetDetail extends StatefulWidget {
  final String item_assets;
  AssetDetail(this.item_assets);

  @override
  State<AssetDetail> createState() => _AssetDetailState();
}

class _AssetDetailState extends State<AssetDetail> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.item_assets);
    // _localPath()
  }
  @override
  Widget build(BuildContext context) {
    print(widget.item_assets);
    return Scaffold(
        appBar: AppBar(title: Text("Product Detail")),
        body: ModelViewer(
          // src: "http://virtual_exhibition.test/assets/images/booth_items/bag.glb",
          // src: 'https://virtual.exhibition.sgvrevents.com/assets/images/booth_product/bag.glb',
          // src: 'https://virtual.exhibition.sgvrevents.com/assets/images/booth_product/bag.glb',
          // src: 'https://virtual.exhibition.sgvrevents.com/assets/images/booth_product/aa.glb',
          src: 'https://virtual.exhibition.sgvrevents.com/assets/images/booth_product/'+widget.item_assets,
          alt: "Product",
          ar: true,
          autoRotate: true,
          cameraControls: true,
        ),
    );
  }
}