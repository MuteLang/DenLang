# Den Overview

A series of patterns for the Den programing language.

## Variable

```
foo : bar
string : "hello"
float : 1.23
int : 10
```

## Operators

```
+ 3 5
- 10 2
* 4 2
/ 16 2
```

## Conditions

```
? > 10 : True
? = 10 : True
? < 10 : True
```

## Ranges

```
"string".1
"string".1..2 
```

## Comments

```
; Comment Line
; Comment Block ;
```

## Functions

```
function param1 param2
  : return
```

## Functions & Conditions

```
function param1 param2
  ? = (+ param1 param2) 10
    : True
  : False
```

## Functions & Conditions

```
function param1 param2
  ? = (+ param1 param2) 10
    : True
  : False
```

## Classes & Methods

```
Numbers val1 val2
  add
    : + val1 val2
  sub
    : - val1 val2
  isEven
    : = %2 0

test:Numbers 10 5
test.add
test.isEven
```

## Loops, Foreach & While

By default, methods don't break. So these 3 patterns are obtained with the same code.

```
index : 0
loop
  ? = index 10 : True
  + = index 1
```

## Extension

```
someClass
  methodA : True
  methodB : True

someClass.methodC : True
```
