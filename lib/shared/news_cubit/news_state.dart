abstract class NewsStates{}
class NewsInitialState extends NewsStates{}
class NewsBottomNav extends NewsStates{}
class NewsGetBusinessLoadingState extends NewsStates{}
class NewsGetBusinessSuccessState extends NewsStates{}
class NewsGetBusinessErrorState extends NewsStates
{
  late final String error;
NewsGetBusinessErrorState(this.error);
}
class NewsGetSportsLoadingState extends NewsStates{}
class NewsGetSportsSuccessState extends NewsStates{}
class NewsGetSportsErrorState extends NewsStates
{
  late final String error;
  NewsGetSportsErrorState(this.error);
}
class NewsGetScienceLoadingState extends NewsStates{}
class NewsGetScienceSuccessState extends NewsStates{}
class NewsGetScienceErrorState extends NewsStates
{
  late final String error;
  NewsGetScienceErrorState(this.error);
}
class NewsGetSearchLoadingState extends NewsStates{}
class NewsGetSearchSuccessState extends NewsStates{}
class NewsGetSearchErrorState extends NewsStates
{
  late final String error;
  NewsGetSearchErrorState(this.error);
}