import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_sales/core/helper_functions/get_user.dart';
import 'package:medical_sales/features/auth/domain/entities/user_entity.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:medical_sales/core/cubit/user/user_cubit.dart';
import 'package:medical_sales/features/5-profile/presentation/views/widgets/profile_header_item.dart';

class CustomProfileHeaderBlocConsumer extends StatefulWidget {
  const CustomProfileHeaderBlocConsumer({super.key});

  @override
  State<CustomProfileHeaderBlocConsumer> createState() =>
      _CustomProfileHeaderBlocConsumerState();
}

class _CustomProfileHeaderBlocConsumerState
    extends State<CustomProfileHeaderBlocConsumer> {
  UserEntity getUser1() {
    return UserEntity(
      uId: 'dummy_id',
      name: 'Loading...',
      email: '',
      phone: '',
      image: '',
      address: '',
      joiningDate: '',
      userType: '',
      admin: 'false',
      directManager: '',
      areaManager: '',
      territory: '',
      password: '',
      employeeStatus: '',
      basicSalary: '',
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getUserData();
  }

  // UserEntity user = getUser();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is GetUserSuccess) {
          return ProfileHeaderItem(user: state.user);
        }
        if (state is GetUserLoading) {
          print('GetUserLoading: ${getUser().uId}');
          return Skeletonizer(
            enabled: true,
            child: ProfileHeaderItem(user: getUser1()),
          );
        }
        if (state is GetUserFailed) {
          print('GetUserFailed: ${state.errMessage}');
          return Center(child: Text(state.errMessage));
        }
        // ret if (state is GetUserSuccess) {

        // }
        return Skeletonizer(
          enabled: true,
          child: ProfileHeaderItem(user: getUser1()),
        );
        // return ProfileHeaderItem(
        //   user: getUser(),
        // );
      },
    );
  }
}
