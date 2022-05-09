import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:b2gsoft_ecommerce/blocs/product_cubit.dart';
import 'package:b2gsoft_ecommerce/variables/variables.dart';
import 'package:b2gsoft_ecommerce/widgets/product_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  String catItem='';
  String storeItem='';
  String brandItem='';

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData()async{
    final ProductCubit pc = BlocProvider.of<ProductCubit>(context,listen: false);
    await pc.getProductList();
  }

  @override
  Widget build(BuildContext context) {
    final ProductCubit pc = BlocProvider.of<ProductCubit>(context,listen: true);
    final double wd = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          body: pc.loading==true
              ? const Center(child: CircularProgressIndicator())
              : _bodyUI(pc,wd),
        ));
  }

  Widget _bodyUI(ProductCubit pc, double wd)=>RefreshIndicator(
    onRefresh:()async => await pc.refreshProductList(),
    backgroundColor: Colors.white,
    child: ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: wd*.04),
      children: [
        SizedBox(height: wd*.04),
        ///Image Slider
        CarouselSlider(
          options: CarouselOptions(
            height: wd*.5,
            aspectRatio: 16/9,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          ),
          items: pc.productListModel.data!.info!.sliders!.map<Widget>((item) => Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(wd*.04)),
                color: Colors.white
            ),
            child: Center(child: CachedNetworkImage(
                imageUrl: '${Variables.domain}${item.image!}',
                placeholder: (context, url) => Icon(Icons.image_outlined,color: Colors.grey,size: wd*.3),
                errorWidget: (context, url, error) => Icon(Icons.error,size: wd*.25,color: Colors.grey),
                fit: BoxFit.cover
            )),
          )).toList(),
        ),
        SizedBox(height: wd*.04),

        ///Shop by Categories
        Text('Shop By Categories',
          style: TextStyle(
            fontSize: wd*.045,
            fontWeight: FontWeight.w600,
            color: Colors.pink
          )),
        Container(
          height: wd*.09,
          margin: EdgeInsets.only(top: wd*.02,bottom: wd*.04),
          child: ListView.separated(
            separatorBuilder: (context, index)=>SizedBox(width: wd*.02),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount:  pc.productListModel.data!.category!.length,
            itemBuilder:(context,index)=> _categoryTile(pc, wd, index),
          ),
        ),

        ///Shop by brand
        Text(pc.productListModel.data!.brand!.title!,
            style: TextStyle(
              fontSize: wd*.045,
              fontWeight: FontWeight.w600,
              color: Colors.pink
            )),
        Container(
          height: wd*.3,
          margin: EdgeInsets.only(top: wd*.02,bottom: wd*.04),
          child: ListView.separated(
            separatorBuilder: (context, index)=>SizedBox(width: wd*.02),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount:  pc.productListModel.data!.brand!.items!.length,
            itemBuilder:(context,index)=> _brandTile(pc, wd, index),
          ),
        ),

        ///Shop by store
        Text(pc.productListModel.data!.shop!.title!,
            style: TextStyle(
              fontSize: wd*.045,
              fontWeight: FontWeight.w600,
              color: Colors.pink
            )),
        Container(
          height: wd*.09,
          margin: EdgeInsets.only(top: wd*.02),
          child: ListView.separated(
            separatorBuilder: (context, index)=>SizedBox(width: wd*.02),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount:  pc.productListModel.data!.shop!.items!.length,
            itemBuilder:(context,index)=> _shopTile(pc, wd, index),
          ),
        ),

        ///Product with title
        ListView.separated(
          padding: EdgeInsets.only(top: wd*.04),
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: pc.productListModel.data!.productSection!.length,
          separatorBuilder: (context, index)=>SizedBox(height: wd*.04),
          itemBuilder: (context, index)=>Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    pc.productListModel.data!.productSection![index].title!,
                    style: TextStyle(
                        fontSize: wd*.06,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  Text('View all',
                    style: TextStyle(
                      fontSize: wd*.05,
                      color: Variables.primaryColor
                    ),
                  ),
                ],
              ),

              ///Products
              GridView.builder(
                 // padding: EdgeInsets.symmetric(horizontal: wd*.04,vertical: wd*.02),
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: wd*.045,
                      mainAxisSpacing: wd*.07,
                      childAspectRatio: .6
                  ),
                  itemCount: pc.productListModel.data!.productSection![index].items!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, i)=>ProductTile(index: i, item:pc.productListModel.data!.productSection![index].items![i])
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _categoryTile(ProductCubit pc, double wd, int index)=> InkWell(
    onTap: ()=> setState(()=> catItem = pc.productListModel.data!.category![index].name!),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(
            width: 2,
            color: catItem ==pc.productListModel.data!.category![index].name? Variables.primaryColor.withOpacity(.3):Colors.white,
          )
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: '${Variables.domain}${pc.productListModel.data!.category![index].image}',
            placeholder: (context, url) => Icon(Icons.image_outlined,color: Colors.grey, size: wd*.08),
            errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.grey,size:wd*.08),
            height: wd*.08,
            fit: BoxFit.cover,
          ),
          Text(' ${pc.productListModel.data!.category![index].name}',style: TextStyle(color: Variables.textColor, fontSize: wd*.045,fontWeight: FontWeight.bold)),
        ],
      ),
    ),
  );

  Widget _brandTile(ProductCubit pc, double wd, int index)=> InkWell(
    onTap: ()=> setState(()=> brandItem = pc.productListModel.data!.brand!.items![index].name!),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
         padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(
                width: 2,
                color: brandItem ==pc.productListModel.data!.brand!.items![index].name? Variables.primaryColor.withOpacity(.3):Colors.white,
              )
          ),
          child: CachedNetworkImage(
            imageUrl: '${Variables.domain}${pc.productListModel.data!.brand!.items![index].image}',
            placeholder: (context, url) => Icon(Icons.image_outlined,color: Colors.grey, size: wd*.2),
            errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.grey,size:wd*.2),
            height: wd*.2,
            fit: BoxFit.cover,
          ),
        ),
        Text(' ${pc.productListModel.data!.brand!.items![index].name}',style: TextStyle(color: Variables.textColor, fontSize: wd*.04)),
      ],
    ),
  );

  Widget _shopTile(ProductCubit pc, double wd, int index)=> InkWell(
    onTap: ()=> setState(()=> storeItem = pc.productListModel.data!.shop!.items![index].name!),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(
            width: 2,
            color: storeItem ==pc.productListModel.data!.shop!.items![index].name? Variables.primaryColor.withOpacity(.3):Colors.white,
          )
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: '${Variables.domain}${pc.productListModel.data!.shop!.items![index].image}',
            placeholder: (context, url) => Icon(Icons.image_outlined,color: Colors.grey, size: wd*.08),
            errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.grey,size:wd*.08),
            height: wd*.08,
            fit: BoxFit.cover,
          ),
          Text(' ${pc.productListModel.data!.shop!.items![index].name}',style: TextStyle(color: Variables.textColor, fontSize: wd*.045,fontWeight: FontWeight.bold)),
        ],
      ),
    ),
  );

}
