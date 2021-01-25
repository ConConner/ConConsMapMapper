function approach(val1, val2, amount) {		//approach val1 to val2 with amount
	if (val1 > val2) return val1 - amount;
	if (val1 < val2) return val1 + amount;
	else return val1;
}