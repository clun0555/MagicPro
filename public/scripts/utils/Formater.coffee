define [
	"underscore"
], (_) ->

	formatCurrency: (currency, num) ->
		"$" + _.numberFormat(num, 2, ".", ",")
