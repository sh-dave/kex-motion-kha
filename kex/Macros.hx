package kex;

import haxe.macro.Context;
import haxe.macro.Expr;

class Macros {
	macro public static function select( value: Expr, defaultValue: Expr ) : Expr
		return macro @:pos(Context.currentPos()) {
			if ($value == null) {
				$value = $defaultValue;
			}

			$value;
		}
}
