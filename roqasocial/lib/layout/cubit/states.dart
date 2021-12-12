abstract class RoqaMainStates {}

class initialState extends RoqaMainStates {}


class changeOnBoardingState extends RoqaMainStates {}


class changeBottomNavState extends RoqaMainStates {}

                                         /// Get Users Data

class getUsersDataLoadingState extends RoqaMainStates {}

class getUsersDataSuccessState extends RoqaMainStates {}

class getUsersDataErrorState extends RoqaMainStates {
  final String error;

  getUsersDataErrorState(this.error);
}

                                      /// Get Profile Image

class getProfileImageLoadingState extends RoqaMainStates {}

class getProfileImageSuccessState extends RoqaMainStates {}

class getProfileImageErrorState extends RoqaMainStates {}

                                      /// Get Cover Image

class getCoverImageLoadingState extends RoqaMainStates {}

class getCoverImageSuccessState extends RoqaMainStates {}

class getCoverImageErrorState extends RoqaMainStates {}


                                       /// Upload Profile Image

class uploadProfileImageLoadingState extends RoqaMainStates {}

class uploadProfileImageSuccessState extends RoqaMainStates {}

class uploadProfileImageErrorState extends RoqaMainStates {
  final String error;

  uploadProfileImageErrorState(this.error);
}


                                    /// Upload Cover Image

class uploadCoverImageLoadingState extends RoqaMainStates {}

class uploadCoverImageSuccessState extends RoqaMainStates {}

class uploadCoverImageErrorState extends RoqaMainStates {
  final String error;

  uploadCoverImageErrorState(this.error);
}


                                         /// Update User Data

class updateUserDataLoadingState extends RoqaMainStates {}

class updateUserDataSuccessState extends RoqaMainStates {}

class updateUserDataErrorState extends RoqaMainStates {
  final String error;

  updateUserDataErrorState(this.error);
}


                                        /// Get Post Image

class getPostImageLoadingState extends RoqaMainStates {}

class getPostImageSuccessState extends RoqaMainStates {}

class getPostImageErrorState extends RoqaMainStates {}


                                       /// Upload Post Image

class uploadPostImageLoadingState extends RoqaMainStates {}

class uploadPostImageSuccessState extends RoqaMainStates {}

class uploadPostImageErrorState extends RoqaMainStates {
  final String error;

  uploadPostImageErrorState(this.error);
}


                                              /// Create Post

class createPostLoadingState extends RoqaMainStates {}

class createPostSuccessState extends RoqaMainStates {}

class createPostErrorState extends RoqaMainStates {
  final String error;

  createPostErrorState(this.error);
}


                                             /// Remove Post Image

class removePostImageState extends RoqaMainStates {}


                                                /// Get Post

class getPostLoadingState extends RoqaMainStates {}

class getPostSuccessState extends RoqaMainStates {}

class getPostErrorState extends RoqaMainStates {
  final String error;

  getPostErrorState(this.error);
}


                                               /// Put Like

class putLikeSuccessState extends RoqaMainStates {}

class putLikeErrorState extends RoqaMainStates {
  final String error;

  putLikeErrorState(this.error);
}


                                              /// Put Comment

class putCommentSuccessState extends RoqaMainStates {}

class putCommentErrorState extends RoqaMainStates {
  final String error;

  putCommentErrorState(this.error);
}

                                              /// Get All Users

class getAllUsersSuccessState extends RoqaMainStates {}

class getAllUsersErrorState extends RoqaMainStates {
  final String error;

  getAllUsersErrorState(this.error);
}



                                               /// Send Message

class sendMessageSuccessState extends RoqaMainStates {}

class sendMessageErrorState extends RoqaMainStates {
  final String error;

  sendMessageErrorState(this.error);
}


                                             /// receive Message

class receiveMessageSuccessState extends RoqaMainStates {}

class receiveMessageErrorState extends RoqaMainStates {
  final String error;

  receiveMessageErrorState(this.error);
}


                                             /// Get Message

class getMessageSuccessState extends RoqaMainStates {}

class getMessageErrorState extends RoqaMainStates {
  final String error;

  getMessageErrorState(this.error);
}


                                          /// Create Comment

class createCommentLoadingState extends RoqaMainStates {}

class createCommentSuccessState extends RoqaMainStates {}

class createCommentErrorState extends RoqaMainStates {
  final String error;

  createCommentErrorState(this.error);
}

                                         /// get Comment

class getCommentLoadingState extends RoqaMainStates {}

class getCommentSuccessState extends RoqaMainStates {}

class getCommentErrorState extends RoqaMainStates {
  final String error;

  getCommentErrorState(this.error);
}