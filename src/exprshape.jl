# Shape of expressions

resultsize(x::DelayedArray) = size(x.arr)

resultsize(x::DelayedUnaryMap) = resultsize(x.a1)
resultsize(x::DelayedBinaryMap) = mapsize(x.a1, x.a2)
resultsize(x::DelayedTernaryMap) = mapsize(x.a1, x.a2, x.a3)

mapsize(x1::DelayedExpr, x2::DelayedExpr) = promote_shape(resultsize(x1), resultsize(x2))
mapsize(x1::DelayedExpr, x2::Number) = resultsize(x1)
mapsize(x1::Number, x2::DelayedExpr) = resultsize(x2)

mapsize(x1::DelayedExpr, x2::DelayedExpr, x3::DelayedExpr) = promote_shape(mapsize(x1, x2), resultsize(x3))

mapsize(x1::DelayedExpr, x2::DelayedExpr, x3::Number) = promote_shape(resultsize(x1), resultsize(x2))
mapsize(x1::DelayedExpr, x2::Number, x3::DelayedExpr) = promote_shape(resultsize(x1), resultsize(x3))
mapsize(x1::Number, x2::DelayedExpr, x3::DelayedExpr) = promote_shape(resultsize(x2), resultsize(x3))

mapsize(x1::DelayedExpr, x2::Number, x3::Number) = resultsize(x1)
mapsize(x1::Number, x2::DelayedExpr, x3::Number) = resultsize(x2)
mapsize(x1::Number, x2::Number, x3::DelayedExpr) = resultsize(x3)
