class Wizard
  constructor: (@localStorageService, @$state, @Validate) ->
    cardInfo = @localStorageService.get "cardInfo"
    @steps = [
      fields: [ 'cardNumber' ]
      enabled: false
      name: "Card number"
      state: "card-number"
    ,
      fields: [ 'cardHolder' ]
      enabled: false
      name: "Card holder"
      state: "card-holder"
    ,
      fields: [ 'cvv' ]
      enabled: false
      name: "CVV"
      state: "cvv"
    ,
      fields: [ 'expDate' ]
      enabled: false
      name: "Expiration date"
      state: "expiration-date"
    ,
      fields: [ ]
      enabled: false
      name: "Final"
      state: "finish"
    ]

    @currentStep = 0

    if cardInfo?
      @cardInfo = cardInfo
    else
      @cardInfo = { }

    @checkSteps()

    currentStep = ""
    @steps.some (step) ->
      currentStep = step.state
      !step.enabled

    @$state.go "wizard." + currentStep

  checkSteps: ->
    @steps.forEach (step) =>
      allValid = true
      step.fields.forEach (field) =>
        if !@Validate[field + 'Validate'](@cardInfo[field])
          allValid = false

      if allValid && !(step.fields.length == 0) then step.enabled = true

  goTo: (step) ->
    @localStorageService.set "cardInfo", @cardInfo
    @$state.go step
    @checkSteps()

Wizard.$inject = [ 'localStorageService', '$state', 'Validate' ]

module.exports = Wizard
