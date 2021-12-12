abstract class RoqaLoginStates {}

class initialState extends RoqaLoginStates {}

class ChangeSuffixState extends RoqaLoginStates {}

                                                     /// LoginState ///
class LoginLoadingState extends RoqaLoginStates {}

class LoginSuccessState extends RoqaLoginStates
{
  final String uId;

  LoginSuccessState(this.uId);
}

class LoginErrorState extends RoqaLoginStates
{
  final String error;
  LoginErrorState(this.error);
}

