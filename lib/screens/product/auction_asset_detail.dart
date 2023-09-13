import 'package:flutter/material.dart';
import 'package:model_viewer/model_viewer.dart';

class AuctionAssetDetail extends StatefulWidget {
  final String item_assets;
  AuctionAssetDetail(this.item_assets);

  @override
  State<AuctionAssetDetail> createState() => _AuctionAssetDetailState();
}

class _AuctionAssetDetailState extends State<AuctionAssetDetail> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.item_assets);
    // _localPath()
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Product Detail")),
        body: ModelViewer(
          // src: "http://virtual_exhibition.test/assets/images/booth_items/bag.glb",
          src: 'assets/images/auction/'+widget.item_assets,
          alt: "Product",
          ar: true,
          autoRotate: true,
          cameraControls: true,
        ),
    );
  }
}