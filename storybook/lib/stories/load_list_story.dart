import 'package:boilerplate_flutter/blocs/blocs.dart';
import 'package:boilerplate_flutter/global/provider.dart';
import 'package:boilerplate_flutter/widgets/load_list/load_list.dart';
import 'package:boilerplate_flutter/models/models.dart';
import 'package:boilerplate_flutter/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/model/model.dart';
import 'package:repository/repository.dart';
import 'package:common/extension/color_extension.dart';
import '../storybook.dart';

class MockUserService extends LoadListService<Group<User>> {
  MockUserService();

  @override
  Future<List<Group<User>>> loadItems({Map<String, dynamic> params}) async {
    await Future.delayed(const Duration(seconds: 4));

    final users = await TestData.getListUser();

    final groups = users.groupByOccupation();

    return groups;
  }

  @override
  Future<void> shouldRefreshItems({Map<String, dynamic> params}) async {}

  @override
  bool shouldReloadData({Map<String, dynamic> params}) {
    return true;
  }
}

class LoadListStory extends Story {
  @override
  List<WidgetMap> storyContent() {
    return [
      WidgetMap(
        title: 'Load List',
        builder: (context) {
          const key = Key('user_bloc');

          return Container(
            color: Colors.white,
            child: BlocProvider<LoadListBloc<Group<User>>>(
              create: (context) =>
                  EventBus().newBlocWithConstructor<LoadListBloc<Group<User>>>(
                key,
                () => LoadListBloc<Group<User>>(
                  key,
                  loadListService: MockUserService(),
                ),
              )..add(const LoadListStarted()),
              child: LoadList<Group<User>>(
                blocKey: key,
                emptyMessage: 'Not found any user.',
                supportFlatGroup: true,
                loadingIndicatorColor: Colors.black54,
                groupHeaderBuilder: (headerTitle, {extraData}) => Container(
                  height: 32,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, top: 12),
                    child: Text(
                      headerTitle,
                      style: Theme.of(context)
                          .primaryTextTheme
                          .headline1
                          .copyWith(color: Colors.black54),
                    ),
                  ),
                ),
                itemSeparatorBuilder: (index) => Divider(
                  color: Colors.transparent,
                ),
                groupItemPlaceholderBuilder: (item) {
                  return Container(
                    width: double.infinity,
                    height: 96,
                    color: Colors.grey,
                    padding: const EdgeInsets.all(8),
                  );
                },
                groupItemBuilder: (
                  item,
                ) {
                  final user = (item as User);

                  return Card(
                    color: ColorExtension.randomColor(),
                    child: ListTile(
                      key: Key('User_Item_${user.userId}'),
                      title: Text(
                        user.name,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline1
                            .copyWith(color: Colors.white),
                      ),
                      subtitle: Text(
                        'Age: ${user.age}',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline1
                            .copyWith(color: Colors.white),
                      ),
                      contentPadding: const EdgeInsets.all(8),
                    ),
                  );
                },
              ),
            ),
          );
        },
      )
    ];
  }
}
