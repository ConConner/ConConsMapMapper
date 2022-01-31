function approach(val1, val2, amount) {		//approach val1 to val2 with amount
	if (val1 > val2) return val1 - amount;
	if (val1 < val2) return val1 + amount;
	if (val1 < val2) && (val1 + amount >= val2) return val2;
	if (val1 > val2) && (val1 - amount >= val2) return val2;
	else return val1;
}

function dec_to_hex() {
    var dec = argument[0],
        len = (argument_count > 1) ? argument[1] : 1,
        hex = "";
 
    if (dec < 0) {
        len = max(len, ceil(logn(16, 2*abs(dec))));
    }
 
    var dig = "0123456789ABCDEF";
    while (len-- || dec) {
        hex = string_char_at(dig, (dec & $F) + 1) + hex;
        dec = dec >> 4;
    }
 
	if (argument[0] < 16) hex = string(0) + string(hex);
    return hex;
}

function hex_to_dec(hex) 
{
    var dec = 0;
 
    var dig = "0123456789ABCDEF";
    var len = string_length(hex);
    for (var pos = 1; pos <= len; pos += 1) {
        dec = dec << 4 | (string_pos(string_char_at(hex, pos), dig) - 1);
    }
 
    return dec;
}