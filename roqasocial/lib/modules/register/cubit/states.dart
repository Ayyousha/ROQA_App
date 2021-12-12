abstract class RoqaRegisterStates {}

class initialState extends RoqaRegisterStates {}

class ChangeSuffixState extends RoqaRegisterStates {}

/// Create Users ///
class CreateUsersLoadingState extends RoqaRegisterStates {}

class CreateUsersSuccessState extends RoqaRegisterStates {
  final String uId;
  CreateUsersSuccessState(this.uId);
}

class CreateUsersErrorState extends RoqaRegisterStates {
  final String error;
  CreateUsersErrorState(this.error);
}

/// Register Users ///
class RegisterUsersLoadingState extends RoqaRegisterStates {}

class RegisterUsersSuccessState extends RoqaRegisterStates {}

class RegisterUsersErrorState extends RoqaRegisterStates {
  final String error;
  RegisterUsersErrorState(this.error);
}
