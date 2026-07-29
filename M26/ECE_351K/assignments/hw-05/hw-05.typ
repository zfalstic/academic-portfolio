#import "@preview/ilm:2.1.1": *

#set text(lang: "en")

#show: ilm.with(
  title: [ECE 351K HW 5],
  authors: "Dawson Zhang",
  date: datetime.today(),
  abstract: [
  ],
  preface: none,
  //bibliography: bibliography("refs.bib"),
  table-of-contents: none,
  figure-index: (enabled: true),
  table-index: (enabled: true),
  listing-index: (enabled: true),
  paper-size: "us-letter",
)

#set math.equation(numbering: none)
#set enum(numbering: "a)")
#let evaluated(expr, size: 100%) = $lr(#expr|, size: #size)$

= Normal Random Variable

$
T ~ N(3, 9)
$

- mean: 3
- variance: 9

*Find $P(0 <= T <= 9)$, expressing your answer in terms of the standard normal
CDF $Phi$*

$
sigma^2 &= 9 \
sigma &= 3
$

$
P(0 <= T <= 9) &= Phi((9 - 3)/3) - Phi((0 - 3)/3) \
&= Phi((9 - 3)/3) - (1 - Phi(3 / 3)) \
&= Phi(2) - (1 - Phi(1)) \
&= 0.8185
$

*Find $P(T > 6)$. You may leave your answer in terms of $Phi$ or evaluate
it numerically*

$
P(T > 6) &= 1 - Phi((6 - 3)/3) \
&= 1- Phi(1) \
&= 0.1587
$

= Joint PDF and Conditional PDF

X and Y have a joint PDF that is uniform over the triangle with vertices 
(0, 0), (2, 0), and (2, 2), shown below. (Include the “otherwise” case in
all PDFs.)

#image("prb-2.png", width: 70%)

+ *Find the joint PDF $f_(X, Y) (x, y)$*

  $
  f_(X, Y) (x,y) = cases(
    1/2 "if" (x,y) in &RR^2 : 0 <= y <= x <= 2,
    0 &"otherwise"
  )
  $

+ *Find the marginal PDF $f_X (x)$*

  $
  f_X (x) &= integral_0^x f_(X, Y) (x,y) dif y \
  &= integral_0^x 1/2 dif y \
  &= evaluated(1/2 y)_0^x \
  &= 1/2 x
  $

  $
  f_X (x) = cases(
    1/2 x &"if" 0 <= x <= 2,
    0 &"otherwise"
  )
  $

+ *Find the marginal PDF $f_Y (y)$*

  $
  f_Y (y) &= integral_y^2 f_(X,Y) (x,y) dif x\
  &= integral_y^2 1/2 dif x \
  &= evaluated(1/2 x)_y^2 \
  &= 1 - 1/2 y
  $

  $
  f_Y (y) = cases(
    1 - 1/2 y &"if" 0 <= y <= 2,
    0 &"otherwise"
  )
  $

+ *Find the conditional PDF $f_(Y | X) (y | x)$*

  $
  f_(Y | X) (y | x) &= (f_(X, Y) (x, y)) / (f_X (x)) \
  &= (1/2)/(1/2 x) \
  &= 1/x
  $

  $
  f_(Y | X) (y | x) = cases(
    1/x &"if" (x,y) in RR^2 : 0 <= y <= x <= 2,
    0 &"otherwise"
  )
  $

+ *Find the conditional expectation $E[Y | X = x]$*

  Conditional PDF $f_(Y | X) (y | x)$ is uniform for any $0 <= x <= 2$.

  $f_(Y | X) (y | x) ~ U(0, x) "for any" 0 <= x <= 2$

  Expected value of continuous uniform is $(b - a)/2$

  $
  E[Y | X = x] &= (b - a) / 2 \
  &= (x - 0) / 2 \
  &= x/2
  $

  $
  E[Y | X = x] = cases(
    x/2 &"if" (x,y) in RR^2 : 0 <= y <= x <= 2,
    0 &"otherwise"
  )
  $

+ *Find the total expectation $E[Y]$*

  $
  E[Y] &= integral_0^2  y f_Y (y) dif y \
  &= integral_0^2 y (1 - 1/2 y) dif y \
  &= integral_0^2 y - 1/2 y^2 dif y \
  &= evaluated(1/2 y^2 - 1/6 y^3)_0^2 \
  &= 1/2 (4) - 1/6 (8) \
  &= 2/3
  $

= Function of a Continuous Random Variable

Find the requested distributions and expectations.

+ *$X ~ N(4, 4)$ and $Y = 3X - 1$. Find $f_Y (y)$*

  For a function in the form $F(X) = a X + b$, where $X ~ N(mu, sigma^2)$

  $
  F(X) ~ N(a mu + b, a^2 sigma^2)
  $

  For our case, $a = 3, b = -1$

  $
  Y = F(X) &~ N(3 dot 4 - 1, 3^2 dot 4) \
  Y &~ N(11, 36)
  $

+ *$X ~ U(0, 2)$ and $Y = X^2$. Find $f_Y (y)$*

  Given $X ~ U(0, 2)$, we know that $f_X (x) = 1/2$ and $F_X (x) = 1/2 x$

  $
  F_Y (y) &= P(Y <= y) \
  &= P(X^2 <= y) \
  &= P(X <= sqrt(y)) \
  &= F_X (sqrt(y)) \
  &= 1/2 sqrt(y)
  $

  $
  f_Y (y) &= dif / (dif y) F_Y (y) \
  &= dif / (dif y) 1/2 sqrt(y) \
  &= 1/2 dot 1/2 y^(-1/2) \
  &= 1/4 y^(-1/2)
  $

  $
  f_Y (y) = cases(
    1/4 y^(-1/2) &"if" y in RR : 0 <= y <= 4,
    0 &"otherwise"
  )
  $

+ *Show that your $f_Y (y)$ from part b) satisfies the normalization axiom
(integrates to 1)*

  $
  integral f_Y (y) dif y &= integral_0^4 1/4 y^(-1/2) dif y \
  &= evaluated(1/2 y^(1/2))_0^4 \
  &= 1/2(2) \
  &= 1
  $

+ *Find $E[Y]$ two ways: first using $f_Y (y)$, then using $f_X (x)$and the
expected value rule. Confirm the answers match.*

  $
  E[Y] &= integral y f_Y (y) dif y \
  &= integral_0^4 y(1/4 y^(-1/2)) dif y \
  &= integral_0^4 1/4 y^(1/2) dif y \
  &= evaluated(1/4 dot 2/ 3 y^(3/2))_0^4 \
  &= 1/4 dot 2/3 dot 8 \
  &= 4/3
  $
