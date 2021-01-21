function reach(val1, val2, amount) {
	if (val1 > val2) return val1 - amount;
	if (val1 < val2) return val1 + amount;
	else return val1;
}