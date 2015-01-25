module.exports = () ->
  new class Validate
    cardHolderPattern: '^\\w+\\s\\w+$'
    cardHolderValidate: (cardHolder) ->
      pattern = new RegExp(@cardHolderPattern)
      pattern.test cardHolder

    cardNumberPattern: '^\\d{16}$'
    cardNumberValidate: (cardNumber) ->
      pattern = new RegExp(@cardNumberPattern)
      pattern.test cardNumber

    cvvPattern: '^\\d{3}$'
    cvvValidate: (cvv) ->
      pattern = new RegExp(@cvvPattern)
      pattern.test cvv

    expDateValidate: (expDate) ->
      expDate? && parseInt(expDate.year) && parseInt(expDate.month)
