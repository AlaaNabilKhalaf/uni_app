// This File provides States for Screens UI and ABI Methods

abstract class LayoutStates {}
class LayoutInitialState extends LayoutStates {}

// UI States
// Login Screen States
class LoginPasswordVisibilityChanged extends LayoutStates{}
class NavToHomeScreenState extends LayoutStates{}

// Image Picker States
class ImagePickerLoadingState extends LayoutStates{}
class ImagePickedState extends LayoutStates{}
class ImageReturnedState extends LayoutStates{}

// Change Password Screen States
class OldPasswordVisibilityChanged extends LayoutStates{}
class NewPasswordVisibilityChanged extends LayoutStates{}
class NewPasswordConVisibilityChanged extends LayoutStates{}



// API Handling States
// Login Method States
class LoginLoadingState extends LayoutStates{}
class LoginSuccessState extends LayoutStates{}
class LoginFailureState extends LayoutStates{}

// Reset Password Method States
class ResetPasswordLoadingState extends LayoutStates{}
class ResetPasswordSuccessState extends LayoutStates{}
class ResetPasswordFailureState extends LayoutStates{}


//Languages
class LanguageChangedToArabic extends LayoutStates{}
class LanguageChangedToEnglish extends LayoutStates{}
class LanguageIsEnglish extends LayoutStates{}


// Controllers
class CameraFlip extends LayoutStates{}
class Flash extends LayoutStates{}
class ControllerInitialed extends LayoutStates{}


//QR Methods
class SendAttendanceLoadingState extends LayoutStates{}
class SendAttendanceSuccessState extends LayoutStates{}
class SendAttendanceFailureState extends LayoutStates{}
class SendAttendanceFailureCatchState extends LayoutStates{}
