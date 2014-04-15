% A Quick Introduction to Haskell
% Timothy Braje
% <a href="http://braje.github.io/quick-intro-haskell">http://braje.github.io/quick-intro-haskell</a>

# Why Haskell? {data-background="img/haskell3.jpg"}

* purely functional language
* lazy
* statically typed + type inference
* elegant and concise

-------------------------------------------------------------------

## Haskell 101 {data-background="img/haskell3.jpg"}

## Interactive shell (ghci) 101 {data-background="img/haskell3.jpg"}

```haskell
ghci> 40 + 2
42

ghci> 2 * 21
42

ghci> 5 / 2
2.5

ghci> True && False
False

ghci> not (True && True)
False

ghci> 5 /= 5
False

ghci> "hello" == "hello"
True
```

## Interactive shell (ghci) 101 {data-background="img/haskell3.jpg"}

```haskell
ghci> fst (1,2)
1

ghci> min 9 10
9

ghci> 40 + 2
42

ghci> (40::Double) + 2
42.0

ghci> (40::Double) + (2::Int)
<interactive>:14:16:
    Couldn't match expected type `Double' with actual type `Int'
    In the second argument of `(+)', namely `(3 :: Int)'
    In the expression: (2 :: Double) + (3 :: Int)
    In an equation for `it': it = (2 :: Double) + (3 :: Int)

ghci> div 92 10
9

ghci> 92 `div` 10
9
```

## You can create functions, too {data-background="img/haskell3.jpg"}

```haskell
doubleMe x = x + x

doubleUs x y = 2*x + 2*y

doubleUs' x y = doubleMe x + doubleMe y

doubleSmallNumber x = if x > 100
                      then x
                      else x*2

doubleSmallNumber' x = (if x > 100 then x else x*2) + 1
```

## (Cons) lists are the bomb... {data-background="img/haskell3.jpg"}

```haskell
ghci> 1:2:3:[]
[1,2,3]

ghci> head [5,4,3,2,1]
5

ghci> tail [5,4,3,2,1]
[4,3,2,1]

ghci> [1,2,3,4] ++ [9,10,11,12]
[1,2,3,4,9,10,11,12]

ghci> "hello" ++ " " ++ "world"
"hello world"

ghci> take 10 (cycle [1,2,3])
[1,2,3,1,2,3,1,2,3,1]

ghci> take 10 (repeat 5)
[5,5,5,5,5,5,5,5,5,5]
```

-------------------------------------------------------------------

# Quiz {data-background="img/haskell3.jpg"}

Given: `[1,3,5,7,2,5,6,9]`

How would I get the 3rd element?

. . .

```haskell
head (tail (tail [1,3,5,7,2,5,6,9]))
```

-------------------------------------------------------------------

## Types & Typeclasses {data-background="img/haskell3.jpg"}

## Example Types {data-background="img/haskell3.jpg"}

Within ghci, the type of any expression can be determined with the `:t` command

```haskell
ghci> :t 'a'
'a' :: Char

ghci> :t True
True :: Bool

ghci> :t "HELLO!"
"HELLO!" :: [Char]

ghci> :t (True, 'a')
(True, 'a') :: (Bool, Char)

ghci> :t 4 == 5
4 == 5 :: Bool
```

```haskell
doubleMe :: Int -> Int
doubleMe x = 2*x

addThree :: Int -> Int -> Int -> Int
addThree x y z = x + y + z
```

That's a really weird syntax for multi-parameter functions!  Let's talk about that later...

Some core types: Int, Integer, Float, Double, Bool, Char

## Type variables (Polymorphic Functions) {data-background="img/haskell3.jpg"}

```haskell
ghci> :t head
head :: [a] -> a

ghci> :t fst
fst :: (a, b) -> a
```

`a` and `b` are type variables and can represent any type

## Typeclasses {data-background="img/haskell3.jpg"}

***Kinda like Java interfaces, except awesomer!***

```haskell
ghci> :t (==)
(==) :: (Eq a) => a -> a -> Bool
```

```haskell
ghci> :t (>)
(>) :: (Ord a) => a -> a -> Bool

ghci> :t succ
succ :: Enum a => a -> a
```

More examples: Show, Read, Bounded, Num, Integral, Floating

-------------------------------------------------------------------

# Quiz {data-background="img/haskell3.jpg"}

Can you guess what the type of (+) is?

. . .

```haskell
ghci> :t (+)
(+) :: Num a => a -> a -> a
```

-------------------------------------------------------------------

## Function syntax {data-background="img/haskell3.jpg"}

## Pattern Matching {data-background="img/haskell3.jpg"}

```haskell
lucky :: (Integral a) => a -> String
lucky 7 = "LUCKY NUMBER SEVEN!"
lucky x = "Sorry, you're out of luck, pal!"

factorial :: (Integral a) => a -> a
factorial 0 = 1
factorial n = n * factorial (n - 1)
```

<h5>Be careful now!</h5>

```haskell
charName :: Char -> String
charName 'a' = "Albert"
charName 'b' = "Broseph"
charName 'c' = "Cecil"
```

```haskell
ghci> charName 'a'
"Albert"

ghci> charName 'b'
"Broseph"

ghci> charName 'h'
*** Exception: tut.hs:(53,0)-(55,21): Non-exhaustive patterns in function charName
```

## Lists can, of course, be matched upon {data-background="img/haskell3.jpg"}

```haskell
head' :: [a] -> a
head' [] = error "No soup for you!"
head' (x:_) = x

sum' :: (Num a) => [a] -> a
sum' [] = 0
sum' (x:xs) = x + sum' xs
```

Keep in mind that `:` only matches lists with one or more elements!

## Guards! (or how I learned to cope with if else trees) {data-background="img/haskell3.jpg"}

```haskell
bigOrSmall :: (RealFloat a) => a -> a -> String
bigOrSmall width height
    | area <= 12.0 = "Tiny"
    | area <= 21.0 = "Just Right"
    | area <= 36.0 = "Too Big"
    | otherwise    = "OMG!"
    where area = weight * height
```

## Let... {data-background="img/haskell3.jpg"}

```haskell
cylinder :: (RealFloat a) => a -> a -> a
cylinder r h =
    let sideArea = 2 * pi * r * h
        topArea  = pi * r^2
    in  sideArea + 2 * topArea
```

In case you missed it, the syntax there is: `let <bindings> in <expression>`, and that's all I have to say about that!

## Case... {data-background="img/haskell3.jpg"}

```haskell
head' :: [a] -> a
head' [] = error "No soup for you!"
head' (x:_) = x

head' :: [a] -> a
head' xs = case xs of []    -> error "No soup for you!"
                      (x:_) -> x
```

Again, syntax...

```haskell
case expression of pattern -> result
                   pattern -> result
                   pattern -> result
                   ...
```

-------------------------------------------------------------------

# Quiz {data-background="img/haskell3.jpg"}

How do you get the third element out of a list?

. . .

```haskell
getThrd :: [a] -> a
getThrd (_:_:x:_) = x
getThrd _ = error "I don't have what you are looking for!"
```

-------------------------------------------------------------------

## Higher order functions {data-background="img/haskell3.jpg"}

Functions taking functions as parameters and/or returning them as return values since 1999...

Learn to love them, or you might as well just leave right now...

## Curried Functions {data-background="img/haskell3.jpg"}
<h5>so important they named the language after its inventor!</h5>

```haskell
ghci> max 4 5
5
```
```haskell
ghci> (max 4) 5
5
```

The space is sort of like an operator (function application) and it has the highest precedence

```haskell
max :: (Ord a) => a -> a -> a
```
```haskell
max :: (Ord a) => a -> (a -> a)
```

## Partial Function Application {data-background="img/haskell3.jpg"}

```haskell
multThree :: (Num a) => a -> a -> a -> a
multThree x y z = x * y * z
```

```haskell
ghci> let multTwoWithNine = multThree 9
ghci> multTwoWithNine 2 3
54

ghci> let multWithEighteen = multTwoWithNine 2
ghci> multWithEighteen 10
180
```

```haskell
compareWithHundred :: (Num a, Ord a) => a -> Ordering
compareWithHundred x = compare 100 x

compareWithHundred' :: (Num a, Ord a) => a -> Ordering
compareWithHundred' = compare 100

divideByTen :: (Floating a) => a -> a
divideByTen = (/10)
```

## Ready for some higher-orderism? {data-background="img/haskell3.jpg"}

```haskell
applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)

ghci> applyTwice (+3) 10
16

ghci> applyTwice (++ " world") "Hello"
"Hello world world"

ghci> applyTwice ("world " ++) "Hello"
"world world Hello"

ghci> applyTwice (3:) [1]
[3,3,1]
```

## Of maps ...{data-background="img/haskell3.jpg"}

```haskell
map :: (a -> b) -> [a] -> [b]
map _ [] = []
map f (x:xs) = f x : map f xs

ghci> map (+3) [1,5,3,1,6]
[4,8,6,4,9]

ghci> map (++ "!") ["nice", "to", "see", "you"]
["nice!","to!","see!","you!"]

ghci> map fst [(1,2),(3,5),(6,3),(2,6),(2,5)]
[1,3,6,2,2]
```

## ... and filters {data-background="img/haskell3.jpg"}

```haskell
filter :: (a -> Bool) -> [a] -> [a]
filter _ [] = []
filter p (x:xs)
    | p x       = x : filter p xs
    | otherwise = filter p xs

ghci> filter (> 3) [1,5,3,2,1,6,4,3,2,1]
[5,6,4]

ghci> filter (== 3) [1,2,3,4,5]
[3]
```

## Lambdas {data-background="img/haskell3.jpg"}

```haskell
ghci> map (\x -> x + 3) [1,6,3,2]
[4,9,6,5]

ghci> map (+3) [1,6,3,2]
[4,9,6,5]

ghci> map (\(a,b) -> a + b) [(1,2),(3,5),(6,3),(2,6),(2,5)]
[3,8,9,8,7]
```

-------------------------------------------------------------------

# Quiz {data-background="img/haskell3.jpg"}

Write `partition` (like you need for quicksort)

```haskell
partition :: (Ord a) => a -> [a] -> ([a],[a])
```

. . .

```haskell
partition :: (Ord a) => a -> [a] -> ([a],[a])
partition x xs = ( filter (< x) xs, filter (>=  x) xs )
```

-------------------------------------------------------------------

## Folds {data-background="img/haskell3.jpg"}

Good for computing something based on a traversal

## Left or right? {data-background="img/haskell3.jpg"}
```haskell
sum' :: (Num a) => [a] -> a
sum' xs = foldl (+) 0 xs
```
```haskell
map' :: (a -> b) -> [a] -> [b]
map' f xs = foldr (\x acc -> f x : acc) [] xs
```

So, left folds associate to the left, and right folds to the right.

```haskell
foldl f z [a,b,c] = (f (f (f z a) b) c)
```
```haskell
foldr f z [a,b,c] = (f a (f b (f c z)))
```

## Function application {data-background="img/haskell3.jpg"}

```haskell
($) :: (a -> b) -> a -> b
f $ x = f x
```

What the...!?!?!?!?!

(space) highest precedence, left associative

($) lowest precedence, right associative

```haskell
f (g (z x)) = f $ g $ z x
```
```haskell
f a b c = (((f a) b) c)
```

-------------------------------------------------------------------

# Quiz {data-background="img/haskell3.jpg"}

Reverse a list using fold...

```haskell
revList :: [a] -> [a]
```

. . .

```haskell
revList :: [a] -> [a]
revList = foldl (\acc x -> x:acc) []
```

. . .

```haskell
revList :: [a] -> [a]
revList = foldl (flip (:)) []
```

-------------------------------------------------------------------

## Algebraic data types {data-background="img/haskell3.jpg"}

We have types and value constructors (well...okay, we'll come back to this)

```haskell
data FavLangs = HASKELLL | IDRIS | AGDA

data AssetHolding = Stock String Int Float | MutualFund String Float Float

ghci> :t Stock
Stock :: String -> Int -> Float -> AssetHolding

ghci> :t MutualFund
MutualFund :: String -> Float -> Float -> AssetHolding

value :: AssetHolding -> Float
value (Stock _ s p) = s * p
value (MutualFund _ s p) = s * p
```

## Recursive data structures (Mind Blown!) {data-background="img/haskell3.jpg"}

```haskell
data List a = Empty | Cons a (List a)
              deriving (Show, Read, Eq, Ord)

ghci> Empty
Empty

ghci> 5 `Cons` Empty
Cons 5 Empty

ghci> 4 `Cons` (5 `Cons` Empty)
Cons 4 (Cons 5 Empty)

ghci> 3 `Cons` (4 `Cons` (5 `Cons` Empty))
Cons 3 (Cons 4 (Cons 5 Empty))
```

-------------------------------------------------------------------

## Types & Typeclasses 102 {data-background="img/haskell3.jpg"}

## Instances {data-background="img/haskell3.jpg"}

Definition of Eq from standard prelude:

```haskell
class Eq a where
  (==) :: a -> a -> Bool
  (/=) :: a -> a -> Bool
  x == y = not (x /= y)
  x /= y = not (x == y)
```

In action:

```haskell
data FavLangs = HASKELLL | IDRIS | AGDA

instance Eq FavLangs where
  HASKELL == HASKELL = True
  IDRIS == IDRIS = True
  AGDA == AGDA = True
  _ == _ = False

instance Show FavLangs where
  show HASKELL = "Haskell"
  show AGDA    = "Agda"
  show IDRIS   = "Idris"
```

## Derived Instances {data-background="img/haskell3.jpg"}

```haskell
data FavLangs = HASKELLL | IDRIS | AGDA
                deriving (Eq, Ord, Show, Read, Bounded, Enum)

ghci> HASKELL == IDRIS
False

ghci> AGDA == AGDA
True

ghci> [HASKELL .. AGDA]
[HASKELL, IDRIS, AGDA]
```
</section>

<section data-background="img/haskell3.jpg">
<p>Hey, I just met you, And this is crazy, But here's my number,
</p><h1>So call me, Maybe?</h1>

```haskell
data Maybe a = Nothing | Just a
```

We have types, type constructors, & value constructors

## Ghci, Maybe? {data-background="img/haskell3.jpg"}

```haskell
ghci> Just "Awesome"
Just "Awesome"

ghci> Just 42
Just 42

ghci> :t Just "Awesome"
Just "Awesome" :: Maybe [Char]

ghci> :t Just 42
Just 42 :: (Num t) => Maybe t

ghci> :t Nothing
Nothing :: Maybe a
```

## Eq, Maybe? {data-background="img/haskell3.jpg"}

```haskell
instance Eq Maybe where
    ...

class Eq a where
    (==) :: a -> a -> Bool
    (/=) :: a -> a -> Bool
    x == y = not (x /= y)
    x /= y = not (x == y)
```

Maybe isn't a type!

## Just add a type parameter, Maybe? {data-background="img/haskell3.jpg"}

```haskell
instance Eq (Maybe m) where
    Just x  == Just y  = x == y
    Nothing == Nothing = True
    _ == _             = False
```

Still not right...

## The type parameter should be equatable, Maybe? {data-background="img/haskell3.jpg"}

```haskell
instance (Eq m) => Eq (Maybe m) where
    Just x  == Just y  = x == y
    Nothing == Nothing = True
    _ == _             = False
```

-------------------------------------------------------------------

## IO {data-background="img/haskell3.jpg"}

## Hello World! {data-background="img/haskell3.jpg"}

```haskell
main = putStrLn "Hello, World!"
```

## Hello World! (with a type signature this time) {data-background="img/haskell3.jpg"}

```haskell
main :: IO ()
main = putStrLn "Hello, World!"
```

```haskell
putStrLn :: String -> IO ()
```

## Is There An Echo In Here? {data-background="img/haskell3.jpg"}

```haskell
main :: IO ()
main = do
  putStrLn "Tell me something interesting"
  answer <- getLine
  putStrLn $ "I am also interested in " ++ answer
```

```haskell
getLine :: IO String
```

...And They Said Haskell Couldn't Have Side Effects

## No, Really, This Is Completely Legit {data-background="img/haskell3.jpg"}

What we are doing here is creating IO Actions that may or may not get executed by the runtime

## Let Bindings for pure values {data-background="img/haskell3.jpg"}

```haskell
main = do
  putStrLn "Please give me stuff to capitalize"
  line <- getLine
  let caps = map toUpper line
  putStrLn caps
```

## Putting It All Together {data-background="img/haskell3.jpg"}

```haskell
main = do 
  putStrLn "Please give me stuff to capitalize, empty line to quit"
  line <- getLine
  if null line
    then return ()
    else do putStrLn $ map toUpper line
            main
```

-------------------------------------------------------------------

# Thanks for listening! {data-background="img/haskell3.jpg"}
