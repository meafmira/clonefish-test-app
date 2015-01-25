digitsGenerator = ->
  digits = [ 0 .. 9 ]
  rand = (min, max) ->
    Math.round(Math.random() * (max - min)) + min

  digits.forEach (digit, index) ->
    newIndex = rand 0, 9
    digits[index] = digits[newIndex]
    digits[newIndex] = digit

  digits

module.exports = (Validate) ->
  templateUrl: "components/testapp-cvv/testapp-cvv.html"
  replace: true
  require: "ngModel"
  link: (scope, el, attrs, ngModelCtrl) ->
    $unwatch = scope.$watch (-> ngModelCtrl.$modelValue), (value) ->
      if ngModelCtrl.$isEmpty(value)
        ngModelCtrl.$setViewValue ""
        ngModelCtrl.$setValidity "cvv", false
        scope.cvv = ""
      else
        scope.cvv = ngModelCtrl.$modelValue
        if Validate.cvvValidate(scope.cvv)
          ngModelCtrl.$setValidity "cvv", true
        else
          ngModelCtrl.$setViewValue ""
          ngModelCtrl.$setValidity "cvv", false

      $unwatch()

    scope.digits = digitsGenerator()

    scope.addDigit = (digit) ->
      currentValue = scope.cvv
      if currentValue.length < 3
        scope.cvv = currentValue + digit

      if scope.cvv.length == 3
        ngModelCtrl.$setValidity "cvv", true
        ngModelCtrl.$setViewValue scope.cvv
      else
        ngModelCtrl.$setValidity "cvv", false

    scope.removeDigit = ->
      currentValue = scope.cvv
      if currentValue.length != 0
        scope.cvv = currentValue.substr(0, currentValue.length - 1)

      ngModelCtrl.$setViewValue ""
      ngModelCtrl.$setValidity "cvv", false

    scope.clear = ->
      ngModelCtrl.$setViewValue ""
      scope.cvv = ""
      ngModelCtrl.$setValidity "cvv", false
