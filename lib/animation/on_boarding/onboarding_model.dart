class OnboardingModel{
  final String lottieURL;
  final String title;
  final String  subtitle;

  OnboardingModel(this.lottieURL, this.title, this.subtitle);
}

List<OnboardingModel> onboardintItems=[
  OnboardingModel(
    "https://lottie.host/172d0f07-296d-41d9-b94c-a6f2fe7f09be/Ai54NeM4is.json", 
    "Start Journey", 
    "When you make a journey, \nyou travel fromt one place to another \n place to enjoy"),
  OnboardingModel(
    "https://lottie.host/b3b45a58-fe49-4f87-987f-405c98e5eec1/bSNbeglO0C.json", 
    "Continue", 
    "We make it simple to find th \nbest way to travel"),
  OnboardingModel(
    "https://lottie.host/2de75391-acb5-483d-a173-2b6d57af8d13/GiIuccc6Tf.json", 
    "Final point", 
    "Dream point every rider, \n during the journey of every place and point")
];