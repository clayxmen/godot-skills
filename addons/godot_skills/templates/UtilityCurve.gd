# res://src/core/components/utility_ai/utility_curve.gd
class_name UtilityCurve
extends Resource
## Mathematical Utility Curve Evaluator (Sigmoid / Exponential / Linear) for Godot 4.x

enum CurveType { LINEAR, EXPONENTIAL, LOGISTIC, NORMAL }

@export var curve_type: CurveType = CurveType.LOGISTIC
@export var slope: float = 1.0
@export var exponent: float = 2.0
@export var midpoint: float = 0.5

func evaluate(x: float) -> float:
	x = clampf(x, 0.0, 1.0)
	match curve_type:
		CurveType.LINEAR:
			return clampf(slope * (x - midpoint) + 0.5, 0.0, 1.0)
		CurveType.EXPONENTIAL:
			return clampf(pow(x, exponent), 0.0, 1.0)
		CurveType.LOGISTIC:
			return clampf(1.0 / (1.0 + exp(-10.0 * slope * (x - midpoint))), 0.0, 1.0)
		CurveType.NORMAL:
			var diff: float = x - midpoint
			return clampf(exp(-(diff * diff) / (2.0 * 0.15 * 0.15)), 0.0, 1.0)
	return x
