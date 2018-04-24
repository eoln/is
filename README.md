# @eoln/is

## install mantra
```bash
npm install @eoln/is --save
```

## TL;DR
run time type/class discovery by value inspection 
and custom class type information scoped registry


## coffeescript usage examples:

```coffee
$is = require '@eoln/is'

$is.Array []
#=> true

$is.Object {}
#=> true

$is.String 'the-string'
#=> true

$is.RegExp /^i-am-regexp$/g
#=> true

$is.Date new Date()
#=> true

$is.Number 3.14
#=> true

$is.Function (x) => x*x
#=> true

$is.Boolean 1 == 2
#=> true

$is.Undefined undefined
#=> true

$is.Null null
#=> true

$is.Symbol Symbol()
#=> true

# global custom classes
class NewClass
$is._name new NewClass
#=> NewClass

# register type by example value
$is._register new NewClass
$is.NewClass new NewClass
#=> true

# custom scope `eoln` for custom value of class  `NewestClass`
class NewestClass
$is._register new NewestClass, 'eoln'
$is.eoln.NewestClass new NewestClass
#=> true
```