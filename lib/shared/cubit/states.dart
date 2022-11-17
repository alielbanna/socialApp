abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error;
  SocialGetUserErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}

class SocialProfileImagePickedSuccessState extends SocialStates {}

//class SocialProfileImagePickedLoadingState extends SocialStates {}

class SocialProfileImagePickedErrorState extends SocialStates {
  // final String error;
  // SocialProfileImagePickedErrorState(this.error);
}

class SocialCoverImagePickedSuccessState extends SocialStates {}

//class SocialCoverImagePickedLoadingState extends SocialStates {}

class SocialCoverImagePickedErrorState extends SocialStates {
  // final String error;
  // SocialCoverImagePickedErrorState(this.error);
}

class SocialUploadProfileImageSuccessState extends SocialStates {}

//class SocialUploadProfileImageLoadingState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {
  final String error;
  SocialUploadProfileImageErrorState(this.error);
}

class SocialUploadCoverImageSuccessState extends SocialStates {}

//class SocialUploadCoverImageLoadingState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {
  final String error;
  SocialUploadCoverImageErrorState(this.error);
}

class SocialUploadUserLoadingState extends SocialStates {}

class SocialUploadUserErrorState extends SocialStates {
  final String error;
  SocialUploadUserErrorState(this.error);
}

class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {
  final String error;
  SocialCreatePostErrorState(this.error);
}

class SocialPostImagePickedSuccessState extends SocialStates {}

//class SocialPostImagePickedLoadingState extends SocialStates {}

class SocialPostImagePickedErrorState extends SocialStates {
  // final String error;
  // SocialPostImagePickedErrorState(this.error);
}

class SocialRemovePostImageState extends SocialStates {}

//*********************************************************8

class SocialGetPostsSuccessState extends SocialStates {}

class SocialGetPostsLoadingState extends SocialStates {}

class SocialGetPostsErrorState extends SocialStates {
  final String error;
  SocialGetPostsErrorState(this.error);
}

class SocialLikePostsSuccessState extends SocialStates {}

//class SocialLikePostsLoadingState extends SocialStates {}

class SocialLikePostsErrorState extends SocialStates {
  final String error;
  SocialLikePostsErrorState(this.error);
}

class SocialCommentPostsSuccessState extends SocialStates {}

//class SocialCommentPostsLoadingState extends SocialStates {}

class SocialCommentPostsErrorState extends SocialStates {
  final String error;
  SocialCommentPostsErrorState(this.error);
}

class SocialGetAllUsersSuccessState extends SocialStates {}

class SocialGetAllUsersLoadingState extends SocialStates {}

class SocialGetAllUsersErrorState extends SocialStates {
  final String error;
  SocialGetAllUsersErrorState(this.error);
}

//************************************************

class SocialSendMessageSuccessState extends SocialStates {}

class SocialSendMessageErrorState extends SocialStates {
  final String error;
  SocialSendMessageErrorState(this.error);
}

class SocialGetMessagesSuccessState extends SocialStates {}
