import 'package:datcao/modules/authentication/auth_bloc.dart';
import 'package:datcao/modules/model/group.dart';
import 'package:datcao/modules/model/post.dart';
import 'package:datcao/modules/repo/group_repo.dart';
import 'package:datcao/modules/repo/post_repo.dart';
import 'package:datcao/share/import.dart';

class GroupBloc extends ChangeNotifier {
  GroupBloc._privateConstructor();
  static final GroupBloc instance = GroupBloc._privateConstructor();

  ScrollController groupScrollController = ScrollController();
  List<GroupModel> myGroups;
  List<GroupModel> followingGroups;

  bool isReloadFeed = true;
  bool isLoadMoreFeed = true;
  bool isLoadStory = true;
  bool isEndFeed = false;
  DateTime lastFetchFeedPage1;
  int feedPage = 1;
  List<PostModel> feed = [];

  Future init() async {
    getListGroup(
            filter: GraphqlFilter(
                limit: 20,
                order: "{updatedAt: -1}",
                filter: "{ownerId: \"${AuthBloc.instance.userModel.id}\"}"))
        .then((res) {
      if (res.isSuccess) {
        myGroups = res.data;
      }
    });
    getNewFeedGroup(filter: GraphqlFilter(limit: 10, order: "{updatedAt: -1}"));
  }

  Future<BaseResponse> getListGroup({GraphqlFilter filter}) async {
    try {
      final res = await GroupRepo().getListGroup(filter: filter);
      final List listRaw = res['data'];
      final list = listRaw.map((e) => GroupModel.fromJson(e)).toList();
      return BaseResponse.success(list);
    } catch (e) {
      return BaseResponse.fail(e.message ?? e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<BaseResponse> getNewFeedGroup({GraphqlFilter filter}) async {
    try {
      isEndFeed = false;
      isReloadFeed = true;
      notifyListeners();
      final res = await PostRepo().getNewsFeedGroup(filter: filter);
      final List listRaw = res['data'];
      final list = listRaw.map((e) => PostModel.fromJson(e)).toList();
      if (list.length < filter.limit) isEndFeed = true;
      feed = list;
      lastFetchFeedPage1 = DateTime.now();
      feedPage = 1;
      return BaseResponse.success(list);
    } catch (e) {
      return BaseResponse.fail(e.message ?? e.toString());
    } finally {
      isReloadFeed = false;
      notifyListeners();
    }
  }

  Future<BaseResponse> loadMoreNewFeedGroup() async {
    try {
      if (isEndFeed) return BaseResponse.success(<PostModel>[]);
      isLoadMoreFeed = true;
      notifyListeners();
      final res = await PostRepo().getNewsFeedGroup(
          filter: GraphqlFilter(
              limit: 10, order: "{updatedAt: -1}", page: ++feedPage),
          timeSort: '-1',
          timestamp: lastFetchFeedPage1.toString());
      final List listRaw = res['data'];
      final list = listRaw.map((e) => PostModel.fromJson(e)).toList();
      if (list.length < 15) isEndFeed = true;
      feed.addAll(list);
      return BaseResponse.success(list);
    } catch (e) {
      return BaseResponse.fail(e?.message ?? e.toString());
    } finally {
      isLoadMoreFeed = false;
      notifyListeners();
    }
  }

  Future<BaseResponse> getPostGroup({GraphqlFilter filter}) async {
    try {
      final res = await PostRepo().getNewsFeedGroup(filter: filter);
      final List listRaw = res['data'];
      final list = listRaw.map((e) => PostModel.fromJson(e)).toList();
      return BaseResponse.success(list);
    } catch (e) {
      return BaseResponse.fail(e?.message ?? e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<BaseResponse> createGroup(
      String name,
      bool privacy,
      String description,
      String coverImage,
      String address,
      double locationLat,
      double locationLong) async {
    try {
      final res = await GroupRepo().createGroup(name, privacy, description,
          coverImage, address, locationLat, locationLong);
      myGroups.add(res as GroupModel);
      return BaseResponse.success(res as GroupModel);
    } catch (e) {
      return BaseResponse.fail(e?.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<BaseResponse> createPost(
      String groupId,
      String content,
      String expirationDate,
      bool publicity,
      double lat,
      double long,
      List<String> images,
      List<String> videos,
      List<LatLng> polygon,
      List<String> tagUserIds) async {
    try {
      final res = await PostRepo().createPost(content, expirationDate,
          publicity, lat, long, images, videos, polygon, tagUserIds,
          groupId: groupId);
      feed.insert(0, PostModel.fromJson(res));
      return BaseResponse.success(PostModel.fromJson(res));
    } catch (e) {
      return BaseResponse.fail(e?.toString());
    } finally {
      // wait to reload post
      Future.delayed(Duration(seconds: 1), () => notifyListeners());
    }
  }

  Future<BaseResponse> updateGroup(
      String id,
      String name,
      bool privacy,
      String description,
      String coverImage,
      String address,
      double locationLat,
      double locationLong) async {
    try {
      final res = await GroupRepo().updateGroup(id, name, privacy, description,
          coverImage, address, locationLat, locationLong);
      return BaseResponse.success(res);
    } catch (e) {
      return BaseResponse.fail(e?.toString());
    } finally {
      notifyListeners();
    }
  }
}