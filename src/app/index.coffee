main = require "./main"

angular.module "testApp", ['ngAnimate', 'ngCookies', 'ngTouch', 'ngSanitize', 'restangular', 'ui.router',
                           'ui.bootstrap', 'LocalStorageModule', main.name]
  .config ($stateProvider, $urlRouterProvider) ->

    $urlRouterProvider.otherwise '/'
