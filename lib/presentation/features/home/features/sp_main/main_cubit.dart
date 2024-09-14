import 'package:El_xizmati/core/enum/enums.dart';
import 'package:El_xizmati/data/datasource/network/responses/category/popular_category/popular_category_response.dart';
import 'package:El_xizmati/presentation/support/cubit/base_cubit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
part 'main_state.dart';
part 'main_cubit.freezed.dart';

@injectable
class MainCubit extends BaseCubit<MainState, MainEvent>{
  MainCubit():super(MainState()){ setCategories();}

  void setCategories(){
    List<PopularCategory> allItems=[];
    allItems.add(PopularCategory(id: 1,name: "Tozalash"));
    allItems.add(PopularCategory(id: 1,name: "Tuzatish"));
    allItems.add(PopularCategory(id: 1,name: "Remont"));
    allItems.add(PopularCategory(id: 1,name: "Bo'yash"));
    allItems.add(PopularCategory(id: 1,name: "Tozalash"));
    allItems.add(PopularCategory(id: 1,name: "Tuzatish"));

    updateState((state) => state.copyWith(
      popularCategories:allItems
    ));
  }



}
