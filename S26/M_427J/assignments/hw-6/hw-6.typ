#import "@preview/noteworthy:0.3.0": *
#import "@preview/diverential:0.3.0": *

#show: noteworthy.with(
  paper-size: "us-letter",
  font: "New Computer Modern",
  language: "EN",
  title: "M 427J Homework Set 6",
  header-title: "M 427J",
  author: "Dawson Zhang",
  contact-details: "dawsonzhang@utexas",
  toc-title: "Table of Contents",
)

#set math.equation(numbering: "(1)")

#pagebreak()

#heading(level: 1, numbering: none)[
  Question 1
]

Given that

$
sum^infinity_(n = 0) x^n = 1/(1 - x), "for" abs(x) < 1,
$

show that the expansion

$
1/(1 + x) = 1 - x + x^2 - x^3 + dots
$

is valid for $abs(x) < 1$. Apply this to show that

$
log(1 + x) = x - x^2/2 + x^3/3 - x^4/4 + dots
$

and

$
arctan(x) = x - x^3/3 + x^5/5 - x^7/7 + dots
$

_solution._

Rewrite 

$
1/(1 + x) = 1/(1 - (-x)) = sum^infinity_(n = 0) (-x)^n &= 1 + (-x)^1 + (-x)^2 + (-x)^3 + (-x)^4 + dots \
&= 1 - x + x^2 - x^3 + x^4 + dots
$

For $log(1 + x)$, notice how $dv(, x) log(1 + x) = 1/(1 + x)$. Consider applying the integral to the series
term by term.

$
integral sum^infinity_(n = 0) (-x)^n = sum^infinity_(n = 0) ((-1)^n x^(n + 1))/(n + 1) = x - x^2/2 + x^3/3 - x^4/4 + dots
$

Finally, for $arctan(x)$, notice how $dv(, u) arctan(u) = 1/(1 + u^2)$. Now suppose we apply substitution 
$x = u^2, 1/(1 + u^2) = 1/(1 + x)$

$
integral dv(, u) arctan(u) &= integral 1/(1 + x) = integral sum^infinity_(n = 0) (-1)^n x^n = integral
sum^infinity_(n = 0) (-1)^n u^(2n) \
arctan(u) &= sum^infinity_(n = 0) ((-1)^n u^(2n + 1))/(2n + 1) = x - x^3/3 + x^5/5 - x^7/7 + dots \
$

#pagebreak()

#heading(level: 1, numbering: none)[
  Question 2
]

Show that the series for $cos(x)$,

$
y = 1 - x^2/(1 dot 2) + x^4/(1 dot 2 dot 3 dot 4) - x^6/(1 dot 2 dot 3 dot 4 dot 5 dot 6) + dots
$

has the property that $y'' = -y$, and is therefore a solution of equation $y'' + y = 0$

_solution._

Rewrite $cos(x)$

$
y = cos(x) = sum^infinity_(n = 0) ((-1)^n x^(2n))/(2n!)
$

Take derivatives,

$
y' &= sum^infinity_(n = 1) ((-1)^n (2n) x^(2n - 1))/(2n!) \
&= sum^infinity_(n = 1) ((-1)^n x^(2n - 1))/((2n - 1)!) \
y'' &= sum^infinity_(n = 1) ((-1)^n (2n - 1) x^(2n - 2))/((2n - 1)!) \
&= sum^infinity_(n = 1) ((-1)^n x^(2n - 2))/((2n - 2)!)
$

Rewrite by switching lower bound

$
y'' &= sum^infinity_(n = 1) ((-1)^n x^(2n - 2))/((2n - 2)!) \
&= sum^infinity_(n = 0) ((-1)^(n + 1) x^(2n)) / (2n!) \
&= (-1) sum^infinity_(n = 0) ((-1)^(n) x^(2n)) / (2n!) \
&= - y
$

#pagebreak()

#heading(level: 1, numbering: none)[
  Question 3
]

Consider the following differential equations:

$
y' = 2x y
$

$
y' + y = 1
$

In each case, find a power series solution of the form $sum a_n x^n$, try to recognize
the resulting series as the expansion of a familiar function, and very your conclusion
by solving the equation directly.

_solution._

Assume

$
y(x) &= sum^infinity_(n = 0) a_n x^n \
y'(x) &= sum^infinity_(n = 1) n a_n x^(n - 1)
$

*Equation (1).* Substituting into $y' = 2 x y$,

$
sum^infinity_(n = 1) n a_n x^(n - 1) = 2 x sum^infinity_(n = 0) a_n x^n = sum^infinity_(n = 0) 2 a_n x^(n + 1)
$

Reindex both sums to powers of $x^m$:

$
sum^infinity_(m = 0) (m + 1) a_(m + 1) x^m = sum^infinity_(m = 1) 2 a_(m - 1) x^m
$

Matching coefficients gives $a_1 = 0$ and the recurrence

$
a_(m + 1) = (2 a_(m - 1))/(m + 1), quad m >= 1.
$

So all odd coefficients vanish, and the even ones satisfy $a_(2k) = a_0 / k!$. Therefore

$
y = a_0 sum^infinity_(k = 0) x^(2 k)/k! = a_0 e^(x^2).
$

Solving directly: $y' = 2 x y$ separates as $dif y / y = 2 x dif x$, giving $log abs(y) = x^2 + C$, hence
$y = a_0 e^(x^2)$. #h(1fr) #sym.checkmark

*Equation (2).* Substituting into $y' + y = 1$,

$
sum^infinity_(n = 1) n a_n x^(n - 1) + sum^infinity_(n = 0) a_n x^n = 1
$

Reindexing the first sum,

$
(a_1 + a_0) + sum^infinity_(m = 1) [(m + 1) a_(m + 1) + a_m] x^m = 1.
$

Matching coefficients: $a_1 = 1 - a_0$ and $a_(m + 1) = - a_m /(m + 1)$ for $m >= 1$. By induction,

$
a_n = ((-1)^(n - 1) (1 - a_0))/n!, quad n >= 1.
$

Hence

$
y = a_0 + (1 - a_0) sum^infinity_(n = 1) ((-1)^(n - 1) x^n)/n! = a_0 - (1 - a_0)(e^(-x) - 1) = 1 + (a_0 - 1) e^(-x).
$

Solving directly: $y' + y = 1$ has integrating factor $e^x$, so $(e^x y)' = e^x$, giving
$y = 1 + C e^(-x)$, which agrees with $C = a_0 - 1$. #h(1fr) #sym.checkmark

#pagebreak()

#heading(level: 1, numbering: none)[
  Question 4
]

Express $arcsin(x)$ in the form of a power series $sum a_n x^n$ by solving $y' = (1 - x^2)^(-1/2)$
in two ways, and use the result to obtain

$
pi/6 = 1/2 + 1/2 dot 1/(3 dot 2^3) + (1 dot 3)/(2 dot 4) dot 1/(5 dot 2^5) + (1 dot 3 dot 5)/(2 dot 4 dot 6) dot 1/(7 dot 2^7) + dots
$

_solution._

*Method 1 (binomial series).* Recall the binomial series

$
(1 + u)^alpha = sum^infinity_(n = 0) binom(alpha, n) u^n, quad abs(u) < 1.
$

With $alpha = -1/2$ and $u = -x^2$,

$
binom(-1/2, n) (-1)^n = ((1/2)(3/2)(5/2) dots ((2n - 1)/2))/n! = ((2n - 1)!!)/(2^n n!) = ((2n - 1)!!)/((2n)!!).
$

Therefore

$
(1 - x^2)^(-1/2) = sum^infinity_(n = 0) ((2n - 1)!!)/((2n)!!) x^(2n) = 1 + 1/2 x^2 + (1 dot 3)/(2 dot 4) x^4 + (1 dot 3 dot 5)/(2 dot 4 dot 6) x^6 + dots
$

Integrating term by term with $arcsin(0) = 0$,

$
arcsin(x) = x + sum^infinity_(n = 1) ((2n - 1)!!)/((2n)!!) dot x^(2n + 1)/(2n + 1) = x + 1/2 dot x^3/3 + (1 dot 3)/(2 dot 4) dot x^5/5 + (1 dot 3 dot 5)/(2 dot 4 dot 6) dot x^7/7 + dots
$

*Method 2 (power series).* Squaring $y' = (1 - x^2)^(-1/2)$ gives $(1 - x^2)(y')^2 = 1$.
Differentiating and dividing by $2 y'$ yields

$
(1 - x^2) y'' - x y' = 0.
$

With $y(0) = 0$ and $y'(0) = 1$, set $y = sum a_n x^n$, so $a_0 = 0$ and $a_1 = 1$. Substituting,

$
sum^infinity_(m = 0) (m + 2)(m + 1) a_(m + 2) x^m - sum^infinity_(m = 2) m(m - 1) a_m x^m - sum^infinity_(m = 1) m a_m x^m = 0.
$

This gives $a_2 = 0$, $a_3 = a_1/6 = 1/6$, and for $m >= 2$,

$
(m + 2)(m + 1) a_(m + 2) = m^2 a_m, quad "i.e." quad a_(m + 2) = m^2/((m + 2)(m + 1)) a_m.
$

So all even coefficients are zero, and computing odd ones gives $a_5 = 3/40$, $a_7 = 5/112$, $dots$,
agreeing with Method 1.

*Formula for $pi slash 6$.* Since $arcsin(1/2) = pi/6$, substitute $x = 1/2$:

$
pi/6 = 1/2 + 1/2 dot (1 slash 2)^3/3 + (1 dot 3)/(2 dot 4) dot (1 slash 2)^5/5 + (1 dot 3 dot 5)/(2 dot 4 dot 6) dot (1 slash 2)^7/7 + dots \
= 1/2 + 1/2 dot 1/(3 dot 2^3) + (1 dot 3)/(2 dot 4) dot 1/(5 dot 2^5) + (1 dot 3 dot 5)/(2 dot 4 dot 6) dot 1/(7 dot 2^7) + dots
$

#pagebreak()

#heading(level: 1, numbering: none)[
  Question 5
]

Find the general solution of $(1 + x^2) y'' + 2 x y' - 2 y = 0$ in terms of power series in $x$.
Can you express this solution by means of elementary functions?

_solution._

Assume $y = sum^infinity_(n = 0) a_n x^n$. Then

$
y'' + x^2 y'' + 2 x y' - 2 y = sum^infinity_(m = 0) (m + 2)(m + 1) a_(m + 2) x^m + \
sum^infinity_(m = 2) m(m - 1) a_m x^m + sum^infinity_(m = 1) 2 m a_m x^m - sum^infinity_(m = 0) 2 a_m x^m.
$

Matching coefficients:

- $m = 0$: $2 a_2 - 2 a_0 = 0 ==> a_2 = a_0$.
- $m = 1$: $6 a_3 + 2 a_1 - 2 a_1 = 0 ==> a_3 = 0$.
- $m >= 2$: $(m + 2)(m + 1) a_(m + 2) + [m(m - 1) + 2 m - 2] a_m = 0$, and since
  $m(m - 1) + 2 m - 2 = (m + 2)(m - 1)$,

$
a_(m + 2) = -(m - 1)/(m + 1) a_m.
$

All odd coefficients with $n >= 3$ vanish, leaving $a_1 x$. The even coefficients are

$
a_2 = a_0, quad a_4 = -1/3 a_0, quad a_6 = 1/5 a_0, quad a_8 = -1/7 a_0, quad dots
$

so the even part is

$
a_0 (1 + x^2 - x^4/3 + x^6/5 - x^8/7 + dots) &= a_0 (1 + x sum^infinity_(n = 0) ((-1)^n x^(2n + 1))/(2 n + 1)) \
&= a_0 (1 + x arctan(x)).
$

The general solution is therefore

$
y = a_0 (1 + x arctan(x)) + a_1 x.
$

_Verification._ Take $y = 1 + x arctan(x)$. Then $y' = arctan(x) + x/(1 + x^2)$ and
$y'' = 2/(1 + x^2)^2$. Substituting,

$
(1 + x^2) dot 2/(1 + x^2)^2 + 2 x (arctan(x) + x/(1 + x^2)) - 2 (1 + x arctan(x)) \
= 2/(1 + x^2) + 2 x arctan(x) + (2 x^2)/(1 + x^2) - 2 - 2 x arctan(x) = (2 + 2 x^2)/(1 + x^2) - 2 = 0. quad checkmark
$

For $y = x$: $y'' = 0, y' = 1$, and $2 x dot 1 - 2 x = 0$. #h(1fr) #sym.checkmark

#pagebreak()

#heading(level: 1, numbering: none)[
  Question 6
]

Verify each function is a solution of the given partial differential equation.

_solution._

*(1)* $u_(x x) + u_(y y) = 0$ with $u(x, y) = log(x^2 + y^2)$.

$
u_x = (2 x)/(x^2 + y^2), quad u_(x x) = (2(x^2 + y^2) - 2 x dot 2 x)/(x^2 + y^2)^2 = (2(y^2 - x^2))/(x^2 + y^2)^2.
$

By symmetry, $u_(y y) = (2(x^2 - y^2))/(x^2 + y^2)^2$, so $u_(x x) + u_(y y) = 0$. #sym.checkmark

*(2)* $alpha^2 u_(x x) = u_t$.

For $u_1(x, t) = e^(-alpha^2 t) sin(x)$:

$
alpha^2 u_(1, x x) = -alpha^2 e^(-alpha^2 t) sin(x) = u_(1, t). quad checkmark
$

For $u_2(x, t) = e^(-alpha^2 lambda^2 t) sin(lambda x)$:

$
alpha^2 u_(2, x x) = -alpha^2 lambda^2 e^(-alpha^2 lambda^2 t) sin(lambda x) = u_(2, t). quad checkmark
$

#pagebreak()

#heading(level: 1, numbering: none)[
  Question 7
]

Which of the following operators are linear?

_solution._ An operator $L$ is linear if $L[a u + b v] = a L[u] + b L[v]$ for all constants $a, b$.

*(a)* $L[u] = u_x + x u_y$. Linear: each term is linear in $u$ and its derivatives.

*(b)* $L[u] = u_x + u u_y$. Nonlinear: the product $u u_y$ is quadratic in $u$.

*(c)* $L[u] = u_x + u_y^2$. Nonlinear: $u_y^2$ is quadratic in $u_y$.

*(d)* $L[u] = u_x + u_y + 1$. Not linear: $L[0] = 1 != 0$, so it fails the homogeneity property
(it is affine, not linear).

*(e)* $L[u] = sqrt(1 + x^2) cos(y) u_x + u_(y x x) - arctan(x slash y) u$. Linear: each term is
linear in $u$ and its derivatives, and the coefficients depend only on $x, y$.

#pagebreak()

#heading(level: 1, numbering: none)[
  Question 8
]

_solution._

*(1)* Solve $2 u_t + 3 u_x = 0$ with $u(x, 0) = sin(x)$.

By the method of characteristics, $u$ is constant along curves where $dif x slash dif t = 3 slash 2$,
i.e., on lines $x - (3 slash 2) t = "const"$. Hence $u(x, t) = f(x - 3 t slash 2)$ for some function
$f$. The condition $u(x, 0) = sin(x)$ gives $f = sin$, so

$
u(x, t) = sin(x - 3 t slash 2).
$

_Verify._ $u_t = -(3 slash 2) cos(x - 3 t slash 2)$ and $u_x = cos(x - 3 t slash 2)$, so
$2 u_t + 3 u_x = -3 cos + 3 cos = 0$. #sym.checkmark

*(2)* Solve $3 u_y + x u_(x y) = 0$.

Let $v = u_y$. Then $3 v + x v_x = 0$, i.e., $v_x slash v = -3 slash x$. Integrating with respect
to $x$ (treating $y$ as constant),

$
log abs(v) = -3 log abs(x) + C(y) ==> v = (C(y))/x^3
$

for an arbitrary function $C(y)$. Then $u_y = C(y) slash x^3$, so integrating with respect to $y$,

$
u(x, y) = (G(y))/x^3 + F(x),
$

where $F$ and $G$ are arbitrary (with $G' = C$).

_Verify._ $u_y = G'(y)/x^3$ and $u_(x y) = -3 G'(y)/x^4$, so
$3 u_y + x u_(x y) = 3 G'(y)/x^3 - 3 G'(y)/x^3 = 0$. #sym.checkmark
