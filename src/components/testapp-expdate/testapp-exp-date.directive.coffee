getYears = ->
  date = new Date()
  year = date.getFullYear()
  [year .. year + 15]

module.exports = ($timeout) ->
  require: "ngModel"
  templateUrl: "components/testapp-expdate/testapp-expdate.html"
  replace: true
  link: (scope, el, attrs, ngModelCtrl) ->
    scope.expDate = { year: "", month: "" }
    scope.months = [1 .. 12]
    scope.years = getYears()
    $unwatch = scope.$watch (-> ngModelCtrl.$modelValue), (value) ->
      date = new Date()
      currentYear = date.getFullYear()
      currentMonth = date.getMonth() + 1
      if ngModelCtrl.$isEmpty(value)
        ngModelCtrl.$setViewValue year: currentYear, month: currentMonth
        ngModelCtrl.$setValidity "exp-date", true
        $timeout ->
          scope.expDate = year: currentYear, month: currentMonth
      else
        $timeout ->
          scope.expDate = angular.copy ngModelCtrl.$modelValue
          if parseInt(scope.expDate.month) && parseInt(scope.expDate.year)
            ngModelCtrl.$setValidity "exp-date", true
          else
            ngModelCtrl.$setViewValue { year: currentYear, month: currentMonth }
            ngModelCtrl.$setValidity "exp-date", true

      $unwatch()

    scope.changeDate = ->
      $timeout ->
        ngModelCtrl.$setViewValue scope.expDate
