import 'package:basalon/modal/favorite_model.dart';
import 'package:basalon/services/api_provider/api_provider.dart';
import 'package:dio/dio.dart';

class FetchFavoriteEvents {
  var dio = Dio();

  FetchFavoriteEvents({
    this.favoriteEvents,
  });

  FavoriteEvents? favoriteEvents;

  Future getFavorite(userId) async {
    // final response = await ApiProvider.get('get_wishlist?user_id=1045');
    print('userId userId userId userId userId');
    print(userId);
    try {
      final response = await ApiProvider.get('get_wishlist?user_id=$userId');
      final result = FavoriteEvents.fromJson(response['body']);
      favoriteEvents = result;
      print(result);
    } catch (e) {
      print('nhi chali favorute');
      print(e);
      favoriteEvents?.data = null;
    }
    return favoriteEvents;
  }

  Future addToFavorite(userId, eventId) async {
    try {
      final response = await ApiProvider.post(
        url: 'add_to_wishlist',
        body: {
          "user_id": "$userId",
          "event_id": "$eventId",
        },
      );
      print('addToFavorite');
      print(response);
    } catch (e) {
      print('nhi chali addToFavorite addToFavorite favorute');
      print(e);
    }
    return favoriteEvents;
  }

  Future removeFavorite(userId, eventId) async {
    try {
      final response = await ApiProvider.post(
        url: 'remove_from_wishlist',
        body: {
          "user_id": "$userId",
          "event_id": "$eventId",
        },
      );

      print('remove_from_wishlist-------------------');
      print(response['status']);
    } catch (e) {
      print('nhi chali addToFavorite addToFavorite favorute');
      print(e);
    }
    return favoriteEvents;
  }
}
