wizardCtrl = require "./wizard.controller"
cvvDirective = require "../../components/testapp-cvv/testapp-cvv.directive"
expDateDirective = require "../../components/testapp-expdate/testapp-exp-date.directive"
validateService = require "../../components/validate.service"

module.exports = angular.module "testApp.main", []
.config ($stateProvider) ->
  $stateProvider
    .state "wizard",
      url: "/"
      templateUrl: "app/main/main.html"
      controller: "WizardCtrl as wizard"

    .state "wizard.card-number",
      url: "card-number"
      templateUrl: "app/main/card-number.html"

    .state "wizard.card-holder",
      url: "card-holder"
      templateUrl: "app/main/card-holder.html"

    .state "wizard.cvv",
      url: "cvv"
      templateUrl: "app/main/cvv.html"

    .state "wizard.expiration-date",
      url: "expiration-date"
      templateUrl: "app/main/expiration-date.html"

    .state "wizard.finish",
      url: "finish"
      templateUrl: "app/main/finish.html"

.controller "WizardCtrl", wizardCtrl
.directive  "testappCvv", cvvDirective
.directive  "testappExpDate", expDateDirective
.factory    "Validate", validateService
