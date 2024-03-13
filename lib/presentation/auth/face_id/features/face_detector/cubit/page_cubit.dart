
import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../common/core/base_cubit.dart';
import 'package:camera/camera.dart';

import '../../../../../../common/enum/enums.dart';
import '../../../../../../data/repositories/auth_repository.dart';
import '../../../../../../data/repositories/favorite_repository.dart';
import '../../../../../ad/ad_list/cubit/page_cubit.dart';

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this._repository, this._favoriteRepository) : super(const PageState()){
     loadInitial();
  }
  final AuthRepository _repository;
  final FavoriteRepository _favoriteRepository;


  void loadInitial() async{
     await initialCamera().then((value) {
       updateState((state) => state.copyWith(
           loadState: LoadingState.success
       ));
     });

     }

   Future<void> initialCamera() async{
      List<CameraDescription> cameras = await availableCameras();
      final CameraController cameraController = CameraController(cameras[1], ResolutionPreset.high, enableAudio: false);
      await cameraController.initialize();
        updateState((state) => state.copyWith(
          cameras: cameras,
          cameraController: cameraController,
          loadState: LoadingState.loading
        ));


  }

  void setSecretKey(String secretKey) {
    updateState((state) => state.copyWith(
          secretKey: secretKey,
        ));
  }

  void sendImage(String image,String secretKey) async {
     updateState((state) => state.copyWith(loading: true));
    try {
      var res = await _repository.sendImage(image,secretKey);
      updateState((state) => state.copyWith(loadState: LoadingState.success));
      sendAllFavoriteAds();
      emitEvent(PageEvent(PageEventType.navigationHome));
    } on DioException catch (e) {
      emitEvent(PageEvent(PageEventType.error));
      display.error(e.toString());
    } finally {
      updateState((state) => state.copyWith(loading: false));
    }
  }

  Future<void> sendAllFavoriteAds() async {
    try {
      await _favoriteRepository.pushAllFavoriteAds();
    } catch (error) {
      display.error("Xatolik yuz berdi");
      emitEvent(PageEvent(PageEventType.navigationHome));
    }
  }
}