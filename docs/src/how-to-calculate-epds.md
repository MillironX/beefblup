```@meta
CurrentModule = BeefBLUP
```

# How to Calculate EPDs

Not to exclude our Australian comrades or our dairy friends, this guide could
alternately be called

- How to Calculate Expected Breeding Values (EBVs)
- How to Calculate Predicted Transmitting Abilities (PTAs)
- How to Calculate Expected Progeny Differences (EPDs)

Since I'm mostly talking to American beef producers, though, we'll stick with
EPDs for most of this discussion.

Expected Breeding Values (EBVs) (which are more often halved and published as
Expected Progeny Differences [EPDs] or Predicted Transmitting Abilities [PTAs]
in the United States) are generally found using Charles Henderson's linear
mixed-model equations. Great, you say, what is that? I'm glad you asked...

## The mathematical model

Every genetics textbook starts with the following equation

```math
P = G + E
```

Where:

- _P_ = phenotype
- _G_ = genotype (think: breeding value)
- _E_ = environmental factors

Now, we can't identify _every_ environmental factor that affects phenotype, but
we can identify some of them, so let's substitute _E_ with some absolutes. A
good place to start is the "contemporary group" listings for the trait of
interest in the [BIF Guidelines], though for the purposes of this example, I'm
only going to consider sex, and birth year.

```math
P = G + E_{year} + E_{sex}
```

Where:

- _E<sub>n</sub>_ is the effect of _n_ on the phenotype

Now let's say I want to find the weaning weight breeding value (_G_) of my
favorite herd bull. I compile his stats, and then plug them into the equation
and solve for G, right? Let's try that.

### Calf Records

ID | Birth Year | Sex    | YW (kg)
-- | -          | -      | -
1  | 1990       | Male   | 354

```math
354 \textup{kg} &= G_1 + E_{1990} + E_{male}
```

Hmm. I just realized I don't know any of those _E_ values. Come to think of it,
I remember from math class that I will need as many equations as I have
unknowns, so I will add equations for other animals that I have records for.

### Calf Records

ID | Birth Year | Sex    | YW (kg)
-- | -          | -      | -
1  | 1990       | Male   | 354
2  | 1990       | Female | 251
3  | 1991       | Male   | 327
4  | 1991       | Female | 328
5  | 1991       | Male   | 301
6  | 1991       | Female | 270
7  | 1992       | Male   | 330

```math
\begin{aligned}
251 \textup{kg} &= G_2 + E_{1990} + E_{female} \\
327 \textup{kg} &= G_3 + E_{1991} + E_{male} \\
328 \textup{kg} &= G_4 + E_{1991} + E_{female} \\
301 \textup{kg} &= G_5 + E_{1991} + E_{male} \\
270 \textup{kg} &= G_6 + E_{1991} + E_{female} \\
330 \textup{kg} &= G_7 + E_{1992} + E_{male}
\end{aligned}
```

Drat! Every animal I added brings more variables into the system than it
eliminates! In fact, since each cow brings in _at least_ one term
(_G<sub>n</sub>_), I will never be able to write enough equations to solve for
_G_ numerically. I will have to use a different approach.

## The statistical model: the setup

Since I can never solve for _G_ directly, I will have to find some way to
estimate it. I can switch to a statistical model and solve for _G_ that way. The
caveat with a statistical model is that there will be some level of error, but
so long as we know and can control the level of error, that will be better than
not knowing _G_ at all.

Since we're switching into a statistical space, we should also switch the
variables we're using. I'll rewrite the first equation as

```math
y = b + u + e
```

Where:

- _y_ = Phenotype
- _b_ = Environment
- _u_ = Genotype
- _e_ = Error

It's not as easy as simply substituting _b_ for every _E_ that we had above,
however. The reason for that is that we must make the assumption that
environment is a **fixed effect** and that genotype is a **random effect**. I'll
go over why that is later, but for now, understand that we need to transform the
environment terms and genotype terms separately.

We'll start with the environment terms.

## The statistical model: environment as fixed effects

To properly transform the equations, I will have to introduce
_b<sub>mean</sub>_ terms in each animal's equation. This is part of the fixed
effect statistical assumption, and it will let us obtain a solution.

Here are the transformed equations:

```math
\begin{aligned}
354 \textup{kg} &= u_1 + b_{mean} + b_{1990} + b_{male} + e_1 \\
251 \textup{kg} &= u_2 + b_{mean} + b_{1990} + b_{female} + e_2 \\
327 \textup{kg} &= u_3 + b_{mean} + b_{1991} + b_{male} + e_3 \\
328 \textup{kg} &= u_4 + b_{mean} + b_{1991} + b_{female} +e_4 \\
301 \textup{kg} &= u_5 + b_{mean} + b_{1991} + b_{male} + e_5 \\
270 \textup{kg} &= u_6 + b_{mean} + b_{1991} + b_{female} + e_6 \\
330 \textup{kg} &= u_7 + b_{mean} + b_{1992} + b_{male} + e_7
\end{aligned}
```

Statistical methods work best in matrix form, so I'm going to convert the set of
equations above to a single matrix equation that means the exact same thing.

```math
\begin{bmatrix}
354 \textup{kg} \\
251 \textup{kg} \\
327 \textup{kg} \\
328 \textup{kg} \\
301 \textup{kg} \\
270 \textup{kg} \\
330 \textup{kg}
\end{bmatrix}
=
\begin{bmatrix}
u_1 \\
u_2 \\
u_3 \\
u_4 \\
u_5 \\
u_6 \\
u_7
\end{bmatrix}
+
b_{mean}
+
\begin{bmatrix}
b_{1990} \\
b_{1990} \\
b_{1991} \\
b_{1991} \\
b_{1991} \\
b_{1991} \\
b_{1992}
\end{bmatrix}
+
\begin{bmatrix}
b_{male} \\
b_{female} \\
b_{male} \\
b_{female} \\
b_{male} \\
b_{female} \\
b_{male}
\end{bmatrix}
+
\begin{bmatrix}
e_1 \\
e_2 \\
e_3 \\
e_4 \\
e_5 \\
e_6 \\
e_7
\end{bmatrix}
```

That's a nice equation, but now my hand is getting tired writing all those _b_
terms over and over again, so I'm going to use [the dot product] to condense
this down.

```math
\begin{bmatrix}
354 \textup{kg} \\
251 \textup{kg} \\
327 \textup{kg} \\
328 \textup{kg} \\
301 \textup{kg} \\
270 \textup{kg} \\
330 \textup{kg}
\end{bmatrix}
=
\begin{bmatrix}
u_1 \\
u_2 \\
u_3 \\
u_4 \\
u_5 \\
u_6 \\
u_7
\end{bmatrix}
+
\begin{bmatrix}
1 & 1 & 0 & 0 & 1 & 0 \\
1 & 1 & 0 & 0 & 0 & 1 \\
1 & 0 & 1 & 0 & 1 & 0 \\
1 & 0 & 1 & 0 & 0 & 1 \\
1 & 0 & 1 & 0 & 1 & 0 \\
1 & 0 & 0 & 1 & 1 & 0
\end{bmatrix}
+
\begin{bmatrix}
b_{mean} \\
b_{1990} \\
b_{1991} \\
b_{1992} \\
b_{male} \\
b_{female}
\end{bmatrix}
+
\begin{bmatrix}
e_1 \\
e_2 \\
e_3 \\
e_4 \\
e_5 \\
e_6 \\
e_7
\end{bmatrix}
```

That matrix in the middle with all the zeros and ones is called the **incidence
matrix**, and essentially reads like a table with each row corresponding to an
animal, and each column corresponding to a fixed effect. For brevity, we'll just
call it _**X**_, though. One indicates that the animal and effect go together,
and zero means they don't. For our record, we could write a table to go with
_**X**_, and it would look like this:

Animal | mean | 1990 | 1991 | 1992 | male | female
--     | -    | -    | -    | -    | -    | -
1      | yes  | yes  | no   | no   | yes  | no
2      | yes  | yes  | no   | no   | no   | yes
3      | yes  | no   | yes  | no   | yes  | no
4      | yes  | no   | yes  | no   | no   | yes
5      | yes  | no   | yes  | no   | yes  | no
6      | yes  | no   | yes  | no   | no   | yes
7      | yes  | no   | no   | yes  | yes  | no

Now that we have _**X**_, we have the ability to start making changes to allow
us to solve for _u_. Immediately, we see that _**X**_ is **singular**, meaning
it can't be solved directly. We kind of already knew that, but now we can
quantify it. We calculate the [rank of _**X**_], and find that there is only
enough information contained in it to solve for 4 variables, which means we need
to eliminate two columns.

There are several ways to effectively eliminate fixed effects in this type of
system, but one of the simplest and the most common methods is to declare a
**base population**, and lump the fixed effects of animals within the base
population into the mean fixed effect. Note that it is possible to declare a
base population that has no animals in it, but that gives weird results. For
this example, we'll follow the convention built into `beefblup` and pick the
last occuring form of each variable.

### Base population

<dl>
<dt>Year</dt>
<dd>1992</dd>

<dt>Sex</dt>
<dd>Male</dd>
</dl>

Now in order to use the base population, we simply drop the columns representing
conformity with the traits in the base population from _**X**_.  Our new
equation looks like

```math
\begin{bmatrix}
354 \textup{kg} \\
251 \textup{kg} \\
327 \textup{kg} \\
328 \textup{kg} \\
301 \textup{kg} \\
270 \textup{kg} \\
330 \textup{kg}
\end{bmatrix}
=
\begin{bmatrix}
u_1 \\
u_2 \\
u_3 \\
u_4 \\
u_5 \\
u_6 \\
u_7
\end{bmatrix}
+
\begin{bmatrix}
1 & 1 & 0 1 \\
1 & 1 & 0 0 \\
1 & 0 & 1 1 \\
1 & 0 & 1 0 \\
1 & 0 & 1 1 \\
1 & 0 & 0 1
\end{bmatrix}
+
\begin{bmatrix}
b_{mean} \\
b_{1990} \\
b_{1991} \\
b_{male} \\
\end{bmatrix}
+
\begin{bmatrix}
e_1 \\
e_2 \\
e_3 \\
e_4 \\
e_5 \\
e_6 \\
e_7
\end{bmatrix}
```

And the table for humans to understand:

Animal | mean | 1990 | 1991 | female
--     | -    | -    | -    | -
1      | yes  | yes  | no   | no
2      | yes  | yes  | no   | yes
3      | yes  | no   | yes  | no
4      | yes  | no   | yes  | yes
5      | yes  | no   | yes  | no
6      | yes  | no   | yes  | yes
7      | yes  | no   | no   | no

Even though each animal is said to participate in the mean, the result for the
mean will now actually be the average of the base population. Math is weird
sometimes.

Double-checking, the rank of _**X**_ is still 4, so we can solve for the average
of the base population, and the effect of being born in 1990, the effect of
being born in 1991, and the effect of being female (although I think [Calvin
already has an idea about that one]).

Whew! That was some transformation. We still haven't constrained this model
enough to solve it, though. Now on to the genotype.

## The statistical model: genotype as random effect

Remember I said above that genotype was a **random effect**? Statisticians say
"_a random effect is an effect that influences the variance and not the mean of
the observation in question._" I'm not sure exactly what that means or how that
is applicable to genotype, but it does let us add an additional constraint to
our model.

The basic gist of genetics is that organisms that are related to one another are
similar to one another. Based on a pedigree, we can even say how related to one
another animals are, and quantify that as the amount that the genotype terms
should be allowed to vary between related animals.

We'll need a pedigree for our animals:

### Calf Records

ID | Sire | Dam | Birth Year | Sex    | YW (kg)
-- | -    | -   | -          | -      | -
1  | NA   | NA  | 1990       | Male   | 354
2  | NA   | NA  | 1990       | Female | 251
3  | 1    | NA  | 1991       | Male   | 327
4  | 1    | NA  | 1991       | Female | 328
5  | 1    | 2   | 1991       | Male   | 301
6  | NA   | 2   | 1991       | Female | 270
7  | NA   | NA  | 1992       | Male   | 330

Now, because cows sexually reproduce, the genotype of one animal is halfway the
same as that of either parent.<sup>[a](#a)</sup> It should go without saying
that each animal's genotype is identical to that of itself. From this we can
then find the numerical multiplier for any relative (grandparent = 1/4, full
sibling = 1, half sibling = 1/2, etc.). Let's write those values down in a
table.

ID | 1   | 2   | 3   | 4   | 5   | 6   | 7
-- | -   | -   | -   | -   | -   | -   | -
1  | 1   | 0   | 1/2 | 1/2 | 1/2 | 0   | 0
2  | 0   | 1   | 0   | 0   | 1/2 | 1/2 | 0
3  | 1/2 | 0   | 1   | 1/4 | 1/4 | 0   | 0
4  | 1/2 | 0   | 1/4 | 1   | 1/4 | 0   | 0
5  | 1/2 | 1/2 | 1/4 | 1/4 | 1   | 1/4 | 0
6  | 0   | 1/2 | 0   | 0   | 1/4 | 1   | 0
7  | 0   | 0   | 0   | 0   | 0   | 0   | 1

Hmm. All those numbers look suspiciously like a matrix. Why don't I put them
into a matrix called _**A**_?

```math
\begin{bmatrix}
1 & 0 & \frac{1}{2} & \frac{1}{2} & \frac{1}{2} & 0 & 0 \\
0 & 1 & 0 & 0 & \frac{1}{2} & \frac{1}{2} & 0 \\
\frac{1}{2} & 0 & 1 & \frac{1}{4} & \frac{1}{4} & 0 & 0 \\
\frac{1}{2} & 0 & \frac{1}{4} & 1 & \frac{1}{4} & 0 & 0 \\
\frac{1}{2} & \frac{1}{2} & \frac{1}{4} & \frac{1}{4} & 1 & \frac{1}{4} & 0 \\
0 & \frac{1}{2} & 0 & 0 & \frac{1}{4} & 1 & 0 \\
0 & 0 & 0 & 0 & 0 & 0 & 1
\end{bmatrix}
```

Now I'm going to take the matrix with all of the _u_ values, and call it
_**μ**_. To quantify the idea of genetic relationship, I will then say that

```math
\textup{var}(μ) = \mathbf{A}σ_μ^2
```

Where:

- _**A**_ = the relationship matrix defined above
- _σ<sub>μ</sub><sup>2</sup>_ = the standard deviation of all the genotypes

To fully constrain the system, I have to make two more assumptions: 1) that the
error term in each animal's equation is independent from all other error terms,
and 2) that the error term for each animal is independent from the value of the
genotype. I will call the matrix holding the _e_ values _**ε**_ and then say

```math
\textup{var}(ϵ) = \mathbf{I}σ_ϵ^2
```

```math
\textup{cov}(μ, ϵ) = \textup{cov}(ϵ, μ) = 0
```

Substituting in the matrix names, our equation now looks like

![\Large Figure 25. Nearly complete mixed-model
equation](https://latex.codecogs.com/svg.latex?%5Cinline%20%5Cbegin%7Bbmatrix%7D%20354%5Ctextup%7B%20kg%7D%5C%5C%20251%5Ctextup%7B%20kg%7D%5C%5C%20327%5Ctextup%7B%20kg%7D%5C%5C%20328%5Ctextup%7B%20kg%7D%5C%5C%20301%5Ctextup%7B%20kg%7D%5C%5C%20270%5Ctextup%7B%20kg%7D%5C%5C%20330%5Ctextup%7B%20kg%7D%20%5Cend%7Bbmatrix%7D%20%3D%20%5Cmu%20&plus;%20X%20%5Cbegin%7Bbmatrix%7D%20b_%7Bmean%7D%5C%5C%20b_%7B1990%7D%5C%5C%20b_%7B1991%7D%5C%5C%20b_%7Bfemale%7D%5C%5C%20%5Cend%7Bbmatrix%7D%20&plus;%20%5Cvarepsilon)

```math
\begin{bmatrix}
354 \textup{kg} \\
251 \textup{kg} \\
327 \textup{kg} \\
328 \textup{kg} \\
301 \textup{kg} \\
270 \textup{kg} \\
330 \textup{kg}
\end{bmatrix}
= μ + X
\begin{bmatrix}
b_{mean} \\
b_{1990} \\
b_{1991} \\
b_{male} \\
\end{bmatrix}
+ ϵ
```

We are going to make three changes to this equation before we are ready to solve
it, but they are cosmetic details for this example.

1. Call the matrix on the left side of the equation _**Y**_ (sometimes it's
   called the **matrix of observations**)
2. Multiply _**μ**_ by an identity matrix called _**Z**_. Multiplying by the
   identity matrix is the matrix form of multiplying by one, so nothing changes,
   but if we later want to find one animal's genetic effect on another animal's
   performance (e.g. a **maternal effects model**), we can alter _**Z**_ to
   allow that/
3. Call the matrix with all the _b_ values _**β**_.

With all these changes, we now have

```math
Y = Z μ + X β + ϵ
```

This is the canonical form of the mixed-model equation, and the form that
Charles Henderson used to first predict breeding values of livestock.

## Solving the equations

Henderson proved that the mixed-model equation can be solved by the following:

![\Large Figure 27. Solution to mixed-model
equation](https://latex.codecogs.com/svg.latex?%5Cinline%20%5Cbegin%7Bbmatrix%7D%20%5Chat%7B%5Cbeta%7D%5C%5C%20%5Chat%7B%5Cmu%7D%20%5Cend%7Bbmatrix%7D%20%3D%5Cbegin%7Bbmatrix%7D%20X%27X%26X%27Z%5C%5C%20Z%27X%26Z%27Z&plus;A%5E%7B-1%7D%5Clambda%20%5Cend%7Bbmatrix%7D%5E%7B-1%7D%20%5Cbegin%7Bbmatrix%7D%20X%27Y%5C%5C%20Z%27Y%20%5Cend%7Bbmatrix%7D)

```math
\begin{bmatrix}
\hat{β} \\
\hat{μ}
\end{bmatrix}
=
\begin{bmatrix}
X'X & X'Z \\
Z'X & Z'Z&plus;A^{-1}\lambda
\end{bmatrix}^{-1}
\begin{bmatrix}
X'Y \\
Z'Y
\end{bmatrix}
```

Where

- The variables with hats are the statistical estimates of their mixed-model
  counterparts
  - The predicted value of _**μ**_ is called the _Best Linear Unbiased
    Predictor_ or _BLUP_
  - The estimated value of _**β**_ is called the _Best Linear Unbiased Estimate_
    or _BLUE_
- ' is the transpose operator
- λ is a single real number that is a function of the heritability for the trait
  being predicted. It can be left out in many cases (λ = 1).
  - λ = (1-h<sup>2</sup>)/h<sup>2</sup>

What happened to

## Footnotes

### a

An animal **can** share its genome with itself by a factor of more than one:
that's called inbreeding! We can account for this, and `beefblup` does as it
calculates _**A**_. This is an area that actually merits a good deal of study:
see chapter 2 of _Linear Models for the Prediction of Animal Breeding Values_ by
Raphael A. Mrode (ISBN 978 1 78064 391 5).

[BIF Guidelines]:
https://beefimprovement.org/wp-content/uploads/2018/03/BIFGuidelinesFinal_updated0318.pdf
[The Dot Product]:
https://www.khanacademy.org/math/precalculus/x9e81a4f98389efdf:matrices/x9e81a4f98389efdf:multiplying-matrices-by-matrices/v/matrix-multiplication-intro
[rank of _**X**_]: https://math.stackexchange.com/a/2080577 [Calvin already has
an idea about that one]: https://www.gocomics.com/calvinandhobbes/1992/12/02
