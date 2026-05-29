#import "@preview/noteworthy:0.3.0": *
#import "@preview/diverential:0.3.0": *

#show: noteworthy.with(
  paper-size: "us-letter",
  font: "New Computer Modern",
  language: "EN",
  title: "M 427J Notes",
  header-title: "M 427J",
  author: "Dawson Zhang",
  contact-details: "dawsonzhang@utexas",
  toc-title: "Table of Contents",
)

#set math.equation(numbering: "(1)")

#pagebreak()

= Power Series Method

The *power series method* is a technique for solving differential equations
by assuming the solution can be written as a power series and determining
the coefficients by substitution.

Given
$
y'' + y &= 0 \
y(x) &= cos(x) \
y(x) &= sin(x)
$

Suppose
$ x y'' + y' + x y = 0 $ <2>

This second equation (Bessel's equation) is much harder to solve. Our goal is to
find solutions to 2nd-order differential equations of this form, like @2.

#definition[
  A *power series* is an infinite series of the form

  $ sum^infinity_(n = 0) a_n x^n = a_0 + a_1 x + a_2 x^2
  + a_3 x^3 + dots $ <3>

]

The series in @3 converges at a point $x$ if the limit

$ lim_(m -> infinity) sum^m_(n = 0) a_n x^n $

exists and is finite; in this case the sum of @3 is the value of this limit.

#example[
  $ sum^infinity_(n = 0) x^n = 1 / (1 - x) $
]

if $abs(x) < 1$, otherwise it diverges. When $x = 0$, the
series in @3 always converges.

The *factorial* can be notated as,

$
n! &= 1 dot 2 dot 3 dots (n - 1) n \
3! &= 1 dot 2 dot 3 \
2! &= 1 dot 2 \
1! &= 1 \
0! &= 1 quad "(by convention)"
$

This has occurred in a couple of common series,

$
sum^infinity_(n = 0) n! x^n &= 1 + x + 2! x^2 + dots \
sum^infinity_(n = 0) x^n / n! &= 1 + x + x^2 / 2! + dots \
&= e^x \
sum^infinity_(n = 0) x^n &= 1 + x + x^2 + dots
$

Suppose that $sum^infinity_(n = 0) a_n x^n$ converges for 
$abs(x) < R, R > 0$; and denote $(-R, R)$

$ f(x) = sum^infinity_(n = 0) a_n x^n $

Then $f(x)$ is continuous and it has derivatives of all orders
for $abs(x) < R$.

Then 
$
f(x) &= a_0 + a_1 x + a_2 x^2 + dots \
f'(x) &= a_1 + 2 a_2 x + 3 a_3 x^2 + dots \
&= sum^infinity_(n = 1) n a_n x^(n - 1) \
f''(x) &= sum^infinity_(n = 2) n(n - 1) a_n x^(n - 2) \
$

In fact, $a_n = (f^((n)) (0)) / n!$

$
f(x) &= sum^infinity_(n = 0) frac(f^((n)) (0), n!) x^n \
&= f(0) + frac(f'(0), 1!) x + frac(f''(0), 2!) x^2 + dots
$

#example[
  $
  f(x) &= e^x \
  f^((n)) (x) &= e^x, f^((n)) (0) = 1 \
  a_n &= frac(f^((n)) (0), n!) = 1 / n! \
  e^x &= sum^infinity_(n = 0) x^n / n!
  $
]

This also applies for $cos(x)$ and $sin(x)$.

_Solve_

$ y' = y(x) $

_Solution_

$ y(x) = e^x y(0) $

Solve using $ y = sum^infinity_(n = 0) a_n x^n $

Need to find constants $a_n$ for all $n$.

$
y' &= a_1 + 2 a_2 x + 3 a_3 x^2 + dots \
a_1 + 2 a_2 x + 3 a_3 x^2 + dots &= a_0 + a_1 x + a_2 x^2 + 
a_3 x^3 + dots
$

Equate coefficients:

$
a_1 &= a_0 \
2 a_2 &= a_1 => a_2 = a_1 / 2 \
3 a_3 &= a_2 => a_3 = a_2 / 3 = a_1 / (2 dot 3) \
4 a_4 &= a_3 => a_4 = a_1 / (2 dot 3 dot 4)
$

$
y &= a_0 + a_1 x + a_2 x^2 + a_3 x^3 + dots \
&= a_0 + a_0 x + a_0 / 2 x^2 + a_0 / (2 dot 3) x^3 + a_0 /
(2 dot 3 dot 4) x^4 + dots \
y(x) &= a_0 (1 + x + x^2 / 2! + x^3 / 3! + dots) \
$

Notice that derivatives of $y(x)$ are the same,

$
y(x) &= a_0 (1 + x + x^2 / 2! + x^3 / 3! + dots) \
y'(x) &= a_0 (1 + x + x^2 / 2! + x^3 / 3! + dots) \
$

$ y(x) = a_0 e^x, a_0 = y(0) $

#example[
  $ y'' + P(x) y' + Q(x) y = 0, P(x) = 0, Q(x) = 1 $
]

_Solve_

$ y'' + y = 0 $

_Assume_

$ y(x) = sum^infinity_(n = 0) a_n x^n $

$
y(x) &= a_0 + a_1 x + a_2 x^2 + a_3 x^3 + dots \
y'(x) &= a_1 + 2 a_2 x + 3 a_3 x^2 + 4 a_4 x^3 + dots \
y''(x) &= 2 a_2 + 2 dot 3 a_3 x + 3 dot 4 a_4 x^2 + 4 dot 5 a_5 x^3 + dots \
$

$
0 &= y'' + y \
&= 2 a_2 + a_0 + (2 dot 3 a_3 + a_1) x + (3 dot 4 a_4 + a_2)
x^2 + (4 dot 5 a_5 + a_3) x^3
$

All the coefficients are $0$.

$
2 a_2 + a_0 &= 0 => a_2 = - a_0 / 2 \
2 dot 3 a_3 + a_1 &= 0 => a_3 = - a_1 / (2 dot 3) \
3 dot 4 a_4 + a_2 &= 0 => a_4 = a_0 / (2 dot 3 dot 4) \
4 dot 5 a_5 + a_3 &= 0 => a_5 = a_1 / (2 dot 3 dot 4 dot 5)
$

$
y(x) &= a_0 + a_1 x + a_2 x^2 + a_3 x^3 + dots \
&= a_0 (1 - x^2 / 2! + x^4 / 4! - dots) + a_1 (x - x^3 / 3! + x^5 / 5! - dots) \
y(x) &= a_0 cos(x) + a_1 sin(x)
$

#example[
  $ x^2 y'' + x y' = 0 $
]

$
y &= sum^infinity_(n = 0) a_n x^n \
y' &= sum^infinity_(n = 1) n a_n x^(n - 1) \
y'' &= sum^infinity_(n = 2) n (n - 1) a_n x^(n - 2)
$

_Substitute_

$
x^2 y'' + x y' &= 0 \
x^2 (sum n (n - 1) a_n x^(n- 2)) + x(sum n a_n x^(n-1)) &= 0
$

= Introduction to Partial Differential Equations (PDE)

Unknown $u(x, y)$, $x$ and $y$ independent.

$
u_x = dvp(u, x), u_y = dvp(u, y), u_(x y) = dvp(u, x, y, deg: 2), 
u_(x x) = dvp(u, x, x, deg: 2)
$

A PDE has the form

$ F(x, y, u(x, y), u_x, u_y) = 0 $

_Laplace's equation_

$
u_(x x) + u_(y y) &= 0 \
dvp(u, x, deg: 2) + dvp(u, y, deg: 2) &= 0
$

In this case,
$ F(x, y, u, u_x, u_y) = dvp(u, x, deg: 2) + dvp(u, y, deg: 2) $

Find: $u(x,y) = e^x sin(y)$

$
dvp(u, x) &= e^x sin(y) \
dvp(u, x, deg: 2) &= e^x sin(y) \
$

$
dvp(u, y) &= e^x cos(y) \
dvp(u, y, deg: 2) &= - e^x sin(y)
$

$
dvp(u, x, deg: 2) + dvp(u, y, deg: 2) &= e^x sin(y) + (-
e^x sin(y)) \
&= 0
$

Wave equation,

$ dvp(u, t, deg: 2) = a^2 dvp(u, x, deg:2 ) $

a is a constant.

$
u(x, t) &= sin(x - a t) \
dvp(u, t) &= cos(x - a t) dot dv(, t) (x - a t) \
&= - a cos(x - a t) \
dvp(u, t, deg: 2) &= - a^2 sin(x - a t)
$

Check $a^2 dvp(u, x, deg: 2)$ with $u(x, t) = sin(x - a t)$:

$
dvp(u, x) &= cos(x - a t) \
dvp(u, x, deg: 2) &= - sin(x - a t) \
a^2 dvp(u, x, deg: 2) &= - a^2 sin(x - a t) = dvp(u, t, deg: 2) checkmark
$

Examples of partial equations that model some phenomena

+ $u_x + y u_y = 0$ (Transport equation)
+ $u_x + u u_y = 0$ (Shock wave)
+ $u_(x x) + u_(y y) = 0$ (Laplace equation)

#note[
  That 1. and 2. have order 1; while 3. has order 2. Transport
  and Laplace are _linear_, but shock wave is non-linear.
]

Linearity: $LL = "operator"$

$
LL[u + v] &= LL[u] + LL[v], LL[c u] = c dot LL[u] \
LL &= dvp(, x) + y dvp(, y) \
LL[u] &= (dvp(, x) + y dvp(, y))[u] = dvp(u, x) + y dvp(u, y) \
LL[u + v] &= (dvp(, x) + y dvp(, y)) [u + v] \
&= dvp(, x) [u + v] + y dvp(, y) [u + v] \
&= dvp(u, x) + dvp(v, x) + y(dvp(u, y) + dvp(v, y)) \
&= dvp(u, x) + y dvp(u, y) + dvp(v, x) + y dvp(v, y) \
&= (dvp(, x) + y dvp(, y))[u] + (dvp(, x) + y dvp(, y))[v] \
&= LL[u] + LL[v]
$

#example[
  $ cos(x y^2) u_x - y^2 u_y = tan(x^2 + y^2) $
  is an inhomogeneous equation that is linear.

  Solve PDE. Find all solutions to

  $ u_(x x) = 0 $

  Find $u(x, y)$ that satisfy the above.

  $
  dvp(u, x, deg: 2) = 0
  $

  Proposed solution

  - $u(x, y) = x$
  - $u(x, y) = a x + b$

  Integration

  $
  integral dvp(u, x, deg: 2) dif x &= integral 0 dif x \
  dvp(u, x) &= f(y) quad "(constant w.r.t. " x ")" \
  integral dvp(u, x) dif x &= integral f(y) dif x \
  u(x, y) &= f(y) x + g(y)
  $
]

#example[
  Solve the PDE $u_(x x) + u = 0$. Notice that this is just the
  ODE $u'' + u = 0$

  $
  u(x, y) = f(y) cos(x) + g(y) sin(x)
  $
]

#example[
  Solve the PDE $u_(x y) = 0$

  $
  dvp(, x) (dvp(u, y)) = dvp(u, x, y, deg: 2) = 0
  $

  By FTC

  $
  integral dvp(, x) (dvp(u, y)) dif x &= integral 0 dif x \
  dvp(u, y) &= f(y) \
  u = integral dvp(u, y) dif y &= integral f(y) dif y \
  u(x, y) &= F(y) + G(x) \
  "where" F(y) &= integral f(y) dif y \
  "and" F' &= f
  $
]

_Moral._ A PDE has arbitrary functions in its solution.

== Geometric Interpretations

$
a u_x + b u_y = 0
$

Where $a$, $b$ are constants.

Geometric interpretation.

Quantity $a u_x + b u_y$ is the directional derivative of
$u$ in the direction of the vectors $arrow(v) = (a, b) =
a e_1 + b e_2$

$
arrow(v) = a hat(i) + b hat(j) \
arrow(v) = b hat(i) - a hat(j)
$

Are orthogonal (AKA perpendicular). Verify by dot product:

$
vec(a, b) dot vec(b, -a) = a b + b (-a) = 0
$

Given

$
arrow(v) = a hat(i) + b hat(j)
$

The lines parallel to $arrow(v)$ have the equations:

$
b x - a y = c
$

Where $c$ is any constant.

The solution is constant on each line. Therefore,
$u(x, y)$ depeonds on $b x - a y$ only.

$
u(x, y) = f(b x - a y)
$

Verify $f$ is a solution:

$
u_x &= f'(b x - a y) * b \
u_y &= f'(b x - a y) * (- a) \
a u_x + b u_y = a b f' + (-a) b f' = 0
$

#heading(level: 3, numbering: none)[
  Coordinate Method, Change of Variables
]

$
x' = a x + b y \
y' = b x - a y
$

Chain-rule

$
u_x = dvp(u, x) &= dvp(u, x') dvp(x', x) + dvp(u, y') dvp(y', x) \
&= a u_x' + b u_y' \
u_y = dvp(u, y) &= dvp(u, y') dvp(y', y) + dvp(u, x') dvp(x', y) \
&= - a u_y' + b u_x'
$

$
a u_x + b u_y &= 0 \
a (a u_x' + b u_y') + b (-a u_y' + b u_x') &= 0 \
(a^2 + b^2) u_x' &= 0 \
a^2 + b^2 > 0 => u_x' &= 0
$

#example[
  $
  4 u_x - 3 u_y = 0
  $

  We have that

  $
  u(x, y) &= f(b x - a y) \
  &= f(-3 x - 4 y)
  $

  This is the general solution. We want the particular solution.
  
  When $x = 0$

  $
  u(x, y) &= f(-3 x - 4 y) \
  y^3 = u(0, y) &= f(-4 y) \
  f(-4 y) &= y^3 \
  $

  Let $z = -4 y => y = -z/4$. 

  $
  f(z) &= - z^3 / 64 \
  u(x, y) &= f(-3 x - 4 y) \
  &= - (-3 x - 4 y)^3 / 64 \
  u(x, y) &= (3 x + 4 y)^3 / 64
  $
]

= Course Review

#heading(level: 3, numbering: none)[
  Integrating factor
]

$
y' + p y &= q \
mu (t) &= e ^(integral P(t))
$

#example[
  $
  y' + 2 y &= e^(-t) \
  mu (t) &= e ^(2 t) \
  e^(2 t) y' + 2 e^(2 t) y &= e^(-2 t) \
  dv(, t)(e^(2 t) y) &= e^(-2 t) \
  e^(2 t) y &= -2 e^(-2 t) \
  y &= -2 e ^(-4t)
  $
]

#heading(level: 3, numbering: none)[
  Exact equations
]

$
M(t, y) + N(t, y) dv(y, t) &= 0 \
M(t, y) dif t + N(t, y) dif y &= 0
$

Exactness: $dvp(M, y) = dvp(N, t)$

#example[
  $
  (2t y + 3) dif t + (t^2 + 4y) dif y &= 0 \
  M(t, y) &= 2 t y + 3 \
  N(t, y) &= t^2 + 4y
  $

  Check for exactness:

  $
  dvp(M, y) &= 2t \
  dvp(N, t) &= 2t
  $

  Since $dvp(M, y) = dvp(N, t)$, we seek $Phi(t, y)$
  such that

  $
  dvp(Phi, t) = M = 2t y + 3 \
  $

  Integrate w.r.t $t$

  $
  Phi(t, y) = integral dvp(Phi, t) dif t &= integral 2 t y
  + 3 \
  &= t^2 y + 3 t + h(y) \
  $

  $h(y)$ is a constant w.r.t $t$

  $
  dvp(Phi, y) &= t^2 + h'(y) \
  dvp(Phi, y) &= N(t, y) \
  t^2 + h'(y) &= t^2 + 4 y \
  h'(y) &= 4y \
  h(y) &= 2 y^2 \
  Phi(t,y) &= t^2 y + 3t + 2y^2 = C
  $
]

#heading(level: 3, numbering: none)[
  Second-order equations
]

$
y'' + P y' + Q y &= 0 \
$

Assumption: $y = e^(r t)$

$
y' &= r e^(r t) \
y'' &= r^2 e^(r t)
$

$
y'' + P y' + Q y &= 0 \
r^2 e^(r t) + P r e^(r t) + Q e ^(r t) &= 0 \
(r^2 + P r + Q) e^(r t) &= 0, e^(r t) > 0 \
r^2 + P r + Q &= 0
$

#example[
  $
  y'' - 4 y' + 4 y &= 0 \
  r^2 - 4 r + 4 &= 0 \
  (r - 2)^2 &= 0 \
  r &= 2
  $

  $
  y(t) = C_1 e^(2 t) + C_2 t e^(2 t)
  $
]

Conditions.

$
a y'' + b y' + c y &= 0 \
$

where $a$, $b$, and $c$ are constants.

If $y = e(r t)$ is a solution, we obtain

$
a r^2 + b r + c &= 0 \
r &= frac(- b plus.minus sqrt(b^2 - 4 a c), 2 a) \
$

+ If $b^2 - 4 a c > 0$, then we get two distinct roots
  $r_1, r_2, (r_1 eq.not r_2)$

  $
  y(t) = C_1 e^(r_1 t) + C_2 e^(r_2 t)
  $

+ If $b^2 - 4 a c = 0$, we get repeated roots
  $r_1 = r_2$

  $
  y(t) = (C_1 + t C_2) e^(r t)
  $

+ If $b^2 - 4 a c < 0$, we get complex roots

  $
  y(t) = e^(r_1 t) &= e^((alpha + i beta) t) \
  &= e^(alpha t) cos(beta t) + i e^(alpha t) sin(beta t) \
  y(t) &= C_1 e^(alpha t) cos(beta t) + C_2 e^(alpha t) sin(beta t)
  $

#heading(level: 3, numbering: none)[
  Linear Algebra
]

If $y_1, y_2$ are solutions to $y'' + P y' + Q y = 0$,
and 

$W[y_1, y_2](t) = y_1(t) y_2'(t) - y_2(t) y_1'(t)
eq.not 0$, $y_1, y_2$ are linearly independent,
otherwise dependent.

Linear transformation $T: RR^2 arrow RR^2$ is linear
if

$
T(x + y) &= T(x) + T(y) \
T(c x) &= c T(x)
$

Vector spaces.

if $W in V$, then $W$ is a subspace if

+ $arrow(0) in W, (W eq.not 0)$
+ if $x in W$ and $c$ is any scalar, then $c x in W$
+ if $x in W$ and $y in W$, then $x + y in W$.

Basis = linearly independent vectors and span the space

$
V &= RR^2 \
beta &= {vec(1, 0), vec(0, 1)} \
vec(x, y) &= x vec(1, 0) + y vec(0, 1)
$

System of differential equations

$
dv(x, t) &= a x + b y \
dv(y, t) &= c x + d y
$

$
arrow(X)'(t) = A arrow(X) (t)
$

$
arrow(X)(t) = vec(x, y), arrow(X)'(t) = vec(dv(x, t), dv(y, t))
$

$
A = mat(a, b; c, d).
$

A solution is $arrow(X)(t) = e^(A t) arrow(X)(0)$

A general solution:

$
A v &= lambda v
$

#example[
  Solve the system

  $
  arrow(x)' = mat(2, 1; 0, 3) arrow(x)
  $

  $
  A v &= lambda v \
  P(lambda) = det(A - lambda I) &= 0
  $

  $
  I = mat(1, 0; 0, 1) \
  A = mat(2, 1; 0, 3)
  $

  $
  0 = det mat(2 - lambda, 1; 0, 3 - lambda) = 
  (2 - lambda)(3 - lambda)
  $

  Roots $lambda_1 = 2, lambda_2 = 3$

  $
  arrow(x) = C_1 e ^(lambda_1 t) arrow(v_1) + 
  C_2 e^(lambda_2 t) arrow(v_2)
  $

  Seek $arrow(v_1)$ for $lambda_1 = 2$.
  $arrow(v_1) = vec(v_1, v_2)$


  $
  mat(2 - lambda_1, 1; 0, 3 - lambda_1) vec(v_1, v_2)
  &= vec(0, 0) \
  mat(0, 1; 0, 1) vec(v_1, v_2) &= vec(0, 0) \
  0 dot v_1 + 1 dot v_2 &= 0\
  0 dot v_1 + 1 dot v_2 &= 0
  $

  $
  arrow(v_1) = vec(1, 0)
  $

  $
  arrow(x)(t) = C_1 e^(2 t) vec(3, 0) + C_2 e^(3 t)
  vec(w_1, w_2)
  $
]

Equilibrium

$
dot(x) = a x + b y &= X(x, y) \
dot(y) = c x + d y &= Y(x, y)
$

Equilibrium: $dot(x) = 0, dot(y) = 0$

Linearize:

$
J &= mat(dvp(X, x), dvp(X, y); dvp(Y, x), dvp(Y, y)) \
arrow(x)' &= J arrow(x) \
$

$
arrow(x) = vec(x, y), arrow(x)' = vec(dot(x), dot(y))
$

#example[
  $
  dot(x) &= ln(x) - y \
  dot(y) &= - x y \
  $

  Equilibrium: $dot(x) = 0, dot(y) = 0$

  $
  0 &= ln(x) - y \
  0 &= - x y \
  $

  $
  J = mat(1/x, - 1; - x, - y)_((1,0)) = mat(1, -1; 0, -1)
  $

  $
  arrow(x)' = mat(1, -1; 0, -1) arrow(x)
  $
]
