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
    allItems.add(PopularCategory(id: 1,name: "Уборка"));
    allItems.add(PopularCategory(id: 2,name: "Сантехник"));
    allItems.add(PopularCategory(id: 3,name: "Строительные"));
    allItems.add(PopularCategory(id: 4,name: "Моляры"));
    allItems.add(PopularCategory(id: 5,name: "Электрик"));
    allItems.add(PopularCategory(id: 6,name: "Вывоз мусора"));
    allItems.add(PopularCategory(id: 7,name: "Дезинфекция"));
    allItems.add(PopularCategory(id: 8,name: "Чистка ковров"));

    updateState((state) => state.copyWith(
      popularCategories:allItems
    ));
  }



}
