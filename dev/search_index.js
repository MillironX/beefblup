var documenterSearchIndex = {"docs":
[{"location":"beefblup-cli/","page":"CLI Reference (WIP)","title":"CLI Reference (WIP)","text":"CurrentModule = BeefBLUP","category":"page"},{"location":"beefblup-cli/#beefblup-Command-Line-Interface-(CLI)-documentation","page":"CLI Reference (WIP)","title":"beefblup Command Line Interface (CLI) documentation","text":"","category":"section"},{"location":"beefblup-cli/","page":"CLI Reference (WIP)","title":"CLI Reference (WIP)","text":"A work in progress","category":"page"},{"location":"beefblup-cli/","page":"CLI Reference (WIP)","title":"CLI Reference (WIP)","text":"Notice: This document is a draft for what the command-line interface for beefblup would look like as of version 1.0, if beefblup was even a command-line application to begin with (it's not). It is modeled (loosely) after the man page format. It is not intended to be taken seriously, but instead to serve as a useful thought experiment and brainstorming ground on the future of beefblup. Please use it if it clarifies things for you. If it doesn't, ignore it.","category":"page"},{"location":"beefblup-cli/#Input-file","page":"CLI Reference (WIP)","title":"Input file","text":"","category":"section"},{"location":"beefblup-cli/","page":"CLI Reference (WIP)","title":"CLI Reference (WIP)","text":"beefblup requires a very specific format of input file. The format may be in comma-separated values (CSV) or Excel 2007+ (XLSX) format. CSV files should not be quoted (and therefore cannot have commas within cell values). Other formats may be forthcoming.","category":"page"},{"location":"beefblup-cli/","page":"CLI Reference (WIP)","title":"CLI Reference (WIP)","text":"A beefblup data file must have at least six columns appearing in this order:","category":"page"},{"location":"beefblup-cli/","page":"CLI Reference (WIP)","title":"CLI Reference (WIP)","text":"ID\nSire ID\nDam ID\nBirthdate\nFixed effect(s)\nResponse variable(s)","category":"page"},{"location":"beefblup-cli/","page":"CLI Reference (WIP)","title":"CLI Reference (WIP)","text":"The first row always contains column names. The values of column names are unimportant for the first four columns, as they will always be treated the same regardless of the name. The generated report will use the column names of fixed effects and response variables as given.","category":"page"},{"location":"beefblup-cli/","page":"CLI Reference (WIP)","title":"CLI Reference (WIP)","text":"Each fixed effect should have its own column, to as many as are needed. There is no limit to the number of fixed effects as defined by beefblup, however its dependencies might have some. The same rules apply to response variables.","category":"page"},{"location":"beefblup-cli/","page":"CLI Reference (WIP)","title":"CLI Reference (WIP)","text":"Unknown values should be left blank (,,). Do not substitute null placeholders (e.g. NULL, NA, 0, nothing, undefined, etc.) for unknown values.","category":"page"},{"location":"beefblup-cli/","page":"CLI Reference (WIP)","title":"CLI Reference (WIP)","text":"An example spreadsheet might have the following format","category":"page"},{"location":"beefblup-cli/","page":"CLI Reference (WIP)","title":"CLI Reference (WIP)","text":"ID Sire ID Dam ID Birthdate Sex Weaning Weight\n1   1/1/1990 Male 354\n2 1  1/1/1990 Female 251\n3 1  1/1/1991 Male 327\n4 1 2 1/1/1991 Female 328\n5  2 1/1/1991 Male 301\n6   1/1/1991 Female 270\n7   1/1/1992 Male 330","category":"page"},{"location":"beefblup-cli/#Synopsis","page":"CLI Reference (WIP)","title":"Synopsis","text":"","category":"section"},{"location":"beefblup-cli/","page":"CLI Reference (WIP)","title":"CLI Reference (WIP)","text":"beefblup [-G SNPs_file] [-M num_response_vars] [-o report_spreadsheet]\n[--no-aod] [--no-year] [--no-season] [--no-autob] [--maternal] input_file\n[report_file]","category":"page"},{"location":"beefblup-cli/#Command-line-basic-syntax","page":"CLI Reference (WIP)","title":"Command line basic syntax","text":"","category":"section"},{"location":"beefblup-cli/","page":"CLI Reference (WIP)","title":"CLI Reference (WIP)","text":"The most basic input is to simply pass the input file name to the program.","category":"page"},{"location":"beefblup-cli/","page":"CLI Reference (WIP)","title":"CLI Reference (WIP)","text":"beefblup filename.csv","category":"page"},{"location":"beefblup-cli/","page":"CLI Reference (WIP)","title":"CLI Reference (WIP)","text":"In this case beefblup will insert fixed-effects for age-of-dam, year, and season, and will calculate the EBVs for the response variable in the final column. The report will then be saved as filename_report.txt.","category":"page"},{"location":"beefblup-cli/#Suppressing-automatically-calculated-fixed-effects","page":"CLI Reference (WIP)","title":"Suppressing automatically-calculated fixed effects","text":"","category":"section"},{"location":"beefblup-cli/","page":"CLI Reference (WIP)","title":"CLI Reference (WIP)","text":"If you don't wish to include one of the automatically calculated fixed-effects from your model, you can pass arguments to suppress them.","category":"page"},{"location":"beefblup-cli/#Suppress-Age-of-dam","page":"CLI Reference (WIP)","title":"Suppress Age-of-dam","text":"","category":"section"},{"location":"beefblup-cli/","page":"CLI Reference (WIP)","title":"CLI Reference (WIP)","text":"beefblup --no-aod filename.csv","category":"page"},{"location":"beefblup-cli/#Suppress-year","page":"CLI Reference (WIP)","title":"Suppress year","text":"","category":"section"},{"location":"beefblup-cli/","page":"CLI Reference (WIP)","title":"CLI Reference (WIP)","text":"beefblup --no-year filename.csv","category":"page"},{"location":"beefblup-cli/#Suppress-season","page":"CLI Reference (WIP)","title":"Suppress season","text":"","category":"section"},{"location":"beefblup-cli/","page":"CLI Reference (WIP)","title":"CLI Reference (WIP)","text":"beefblup --no-season filename.csv","category":"page"},{"location":"beefblup-cli/#Suppress-all-calculated-fixed-effects","page":"CLI Reference (WIP)","title":"Suppress all calculated fixed effects","text":"","category":"section"},{"location":"beefblup-cli/","page":"CLI Reference (WIP)","title":"CLI Reference (WIP)","text":"beefblup --no-autob filename.csv","category":"page"},{"location":"beefblup-cli/","page":"CLI Reference (WIP)","title":"CLI Reference (WIP)","text":"The argument --no-autob comes from the nomenclature of assigning fixed-effects to the matrix b in Henderson's mixed-model equations.","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"CurrentModule = BeefBLUP","category":"page"},{"location":"how-to-calculate-epds/#How-to-Calculate-EPDs","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"","category":"section"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"Not to exclude our Australian comrades or our dairy friends, this guide could alternately be called","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"How to Calculate Expected Breeding Values (EBVs)\nHow to Calculate Predicted Transmitting Abilities (PTAs)\nHow to Calculate Expected Progeny Differences (EPDs)","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"Since I'm mostly talking to American beef producers, though, we'll stick with EPDs for most of this discussion.","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"Expected Breeding Values (EBVs) (which are more often halved and published as Expected Progeny Differences (EPDs) or Predicted Transmitting Abilities (PTAs) in the United States) are generally found using Charles Henderson's linear mixed-model equations. Great, you say, what is that? I'm glad you asked...","category":"page"},{"location":"how-to-calculate-epds/#The-mathematical-model","page":"How to Calculate EPDs","title":"The mathematical model","text":"","category":"section"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"Every genetics textbook starts with the following equation","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"P = G + E","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"Where:","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"P = phenotype\nG = genotype (think: breeding value)\nE = environmental factors","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"Now, we can't identify every environmental factor that affects phenotype, but we can identify some of them, so let's substitute E with some absolutes. A good place to start is the \"contemporary group\" listings for the trait of interest in the BIF Guidelines, though for the purposes of this example, I'm only going to consider sex, and birth year.","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"P = G + E_year + E_sex","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"Where:","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"E_n is the effect of n on the phenotype","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"Now let's say I want to find the weaning weight breeding value (G) of my favorite herd bull. I compile his stats, and then plug them into the equation and solve for G, right? Let's try that.","category":"page"},{"location":"how-to-calculate-epds/#Calf-Records","page":"How to Calculate EPDs","title":"Calf Records","text":"","category":"section"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"ID Birth Year Sex YW (kg)\n1 1990 Male 354","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"354   textupkg = G_1 + E_1990 + E_male","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"Hmm. I just realized I don't know any of those E values. Come to think of it, I remember from math class that I will need as many equations as I have unknowns, so I will add equations for other animals that I have records for.","category":"page"},{"location":"how-to-calculate-epds/#Calf-Records-2","page":"How to Calculate EPDs","title":"Calf Records","text":"","category":"section"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"ID Birth Year Sex YW (kg)\n1 1990 Male 354\n2 1990 Female 251\n3 1991 Male 327\n4 1991 Female 328\n5 1991 Male 301\n6 1991 Female 270\n7 1992 Male 330","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"beginaligned\n251  textupkg = G_2 + E_1990 + E_female \n327  textupkg = G_3 + E_1991 + E_male \n328  textupkg = G_4 + E_1991 + E_female \n301  textupkg = G_5 + E_1991 + E_male \n270  textupkg = G_6 + E_1991 + E_female \n330  textupkg = G_7 + E_1992 + E_male\nendaligned","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"Drat! Every animal I added brings more variables into the system than it eliminates! In fact, since each cow brings in at least one term (G_n), I will never be able to write enough equations to solve for G numerically. I will have to use a different approach.","category":"page"},{"location":"how-to-calculate-epds/#The-statistical-model:-the-setup","page":"How to Calculate EPDs","title":"The statistical model: the setup","text":"","category":"section"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"Since I can never solve for G directly, I will have to find some way to estimate it. I can switch to a statistical model and solve for G that way. The caveat with a statistical model is that there will be some level of error, but so long as we know and can control the level of error, that will be better than not knowing G at all.","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"Since we're switching into a statistical space, we should also switch the variables we're using. I'll rewrite the first equation as","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"y = b + u + e","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"Where:","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"y = Phenotype\nb = Environment\nu = Genotype\ne = Error","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"It's not as easy as simply substituting b for every E that we had above, however. The reason for that is that we must make the assumption that environment is a fixed effect and that genotype is a random effect. I'll go over why that is later, but for now, understand that we need to transform the environment terms and genotype terms separately.","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"We'll start with the environment terms.","category":"page"},{"location":"how-to-calculate-epds/#The-statistical-model:-environment-as-fixed-effects","page":"How to Calculate EPDs","title":"The statistical model: environment as fixed effects","text":"","category":"section"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"To properly transform the equations, I will have to introduce b_mean terms in each animal's equation. This is part of the fixed effect statistical assumption, and it will let us obtain a solution.","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"Here are the transformed equations:","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"beginaligned\n354  textupkg = u_1 + b_mean + b_1990 + b_male   + e_1 \n251  textupkg = u_2 + b_mean + b_1990 + b_female + e_2 \n327  textupkg = u_3 + b_mean + b_1991 + b_male   + e_3 \n328  textupkg = u_4 + b_mean + b_1991 + b_female +e_4 \n301  textupkg = u_5 + b_mean + b_1991 + b_male   + e_5 \n270  textupkg = u_6 + b_mean + b_1991 + b_female + e_6 \n330  textupkg = u_7 + b_mean + b_1992 + b_male   + e_7\nendaligned","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"Statistical methods work best in matrix form, so I'm going to convert the set of equations above to a single matrix equation that means the exact same thing.","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"beginbmatrix\n354  textupkg \n251  textupkg \n327  textupkg \n328  textupkg \n301  textupkg \n270  textupkg \n330  textupkg\nendbmatrix\n=\nbeginbmatrix\nu_1 \nu_2 \nu_3 \nu_4 \nu_5 \nu_6 \nu_7\nendbmatrix\n+\nb_mean\n+\nbeginbmatrix\nb_1990 \nb_1990 \nb_1991 \nb_1991 \nb_1991 \nb_1991 \nb_1992\nendbmatrix\n+\nbeginbmatrix\nb_male \nb_female \nb_male \nb_female \nb_male \nb_female \nb_male\nendbmatrix\n+\nbeginbmatrix\ne_1 \ne_2 \ne_3 \ne_4 \ne_5 \ne_6 \ne_7\nendbmatrix","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"That's a nice equation, but now my hand is getting tired writing all those b terms over and over again, so I'm going to use the dot product to condense this down.","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"beginbmatrix\n354 textupkg \n251 textupkg \n327 textupkg \n328 textupkg \n301 textupkg \n270 textupkg \n330 textupkg\nendbmatrix\n=\nbeginbmatrix\nu_1 \nu_2 \nu_3 \nu_4 \nu_5 \nu_6 \nu_7\nendbmatrix\n+\nbeginbmatrix\n1  1  0  0  1  0 \n1  1  0  0  0  1 \n1  0  1  0  1  0 \n1  0  1  0  0  1 \n1  0  1  0  1  0 \n1  0  0  1  1  0\nendbmatrix\nbeginbmatrix\nb_mean \nb_1990 \nb_1991 \nb_1992 \nb_male \nb_female\nendbmatrix\n+\nbeginbmatrix\ne_1 \ne_2 \ne_3 \ne_4 \ne_5 \ne_6 \ne_7\nendbmatrix","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"That matrix in the middle with all the zeros and ones is called the incidence matrix, and essentially reads like a table with each row corresponding to an animal, and each column corresponding to a fixed effect. For brevity, we'll just call it X, though. One indicates that the animal and effect go together, and zero means they don't. For our record, we could write a table to go with X, and it would look like this:","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"Animal mean 1990 1991 1992 male female\n1 yes yes no no yes no\n2 yes yes no no no yes\n3 yes no yes no yes no\n4 yes no yes no no yes\n5 yes no yes no yes no\n6 yes no yes no no yes\n7 yes no no yes yes no","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"Now that we have X, we have the ability to start making changes to allow us to solve for u. Immediately, we see that X is singular, meaning it can't be solved directly. We kind of already knew that, but now we can quantify it. We calculate the rank of X, and find that there is only enough information contained in it to solve for 4 variables, which means we need to eliminate two columns.","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"There are several ways to effectively eliminate fixed effects in this type of system, but one of the simplest and the most common methods is to declare a base population, and lump the fixed effects of animals within the base population into the mean fixed effect. Note that it is possible to declare a base population that has no animals in it, but that gives weird results. For this example, we'll follow the convention built into beefblup and pick the last occuring form of each variable.","category":"page"},{"location":"how-to-calculate-epds/#Base-population","page":"How to Calculate EPDs","title":"Base population","text":"","category":"section"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"Year: 1992\nSex: Female","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"Now in order to use the base population, we simply drop the columns representing conformity with the traits in the base population from X``.  Our new equation looks like","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"beginbmatrix\n354  textupkg \n251  textupkg \n327  textupkg \n328  textupkg \n301  textupkg \n270  textupkg \n330  textupkg\nendbmatrix\n=\nbeginbmatrix\nu_1 \nu_2 \nu_3 \nu_4 \nu_5 \nu_6 \nu_7\nendbmatrix\n+\nbeginbmatrix\n1  1  0 1 \n1  1  0 0 \n1  0  1 1 \n1  0  1 0 \n1  0  1 1 \n1  0  0 1\nendbmatrix\n+\nbeginbmatrix\nb_mean \nb_1990 \nb_1991 \nb_male \nendbmatrix\n+\nbeginbmatrix\ne_1 \ne_2 \ne_3 \ne_4 \ne_5 \ne_6 \ne_7\nendbmatrix","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"And the table for humans to understand:","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"Animal mean 1990 1991 female\n1 yes yes no no\n2 yes yes no yes\n3 yes no yes no\n4 yes no yes yes\n5 yes no yes no\n6 yes no yes yes\n7 yes no no no","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"Even though each animal is said to participate in the mean, the result for the mean will now actually be the average of the base population. Math is weird sometimes.","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"Double-checking, the rank of X is still 4, so we can solve for the average of the base population, and the effect of being born in 1990, the effect of being born in 1991, and the effect of being male.","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"Whew! That was some transformation. We still haven't constrained this model enough to solve it, though. Now on to the genotype.","category":"page"},{"location":"how-to-calculate-epds/#The-statistical-model:-genotype-as-random-effect","page":"How to Calculate EPDs","title":"The statistical model: genotype as random effect","text":"","category":"section"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"Remember I said above that genotype was a random effect? Statisticians say \"a random effect is an effect that influences the variance and not the mean of the observation in question.\" I'm not sure exactly what that means or how that is applicable to genotype, but it does let us add an additional constraint to our model.","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"The basic gist of genetics is that organisms that are related to one another are similar to one another. Based on a pedigree, we can even say how related to one another animals are, and quantify that as the amount that the genotype terms should be allowed to vary between related animals.","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"We'll need a pedigree for our animals:","category":"page"},{"location":"how-to-calculate-epds/#Calf-Records-3","page":"How to Calculate EPDs","title":"Calf Records","text":"","category":"section"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"ID Sire Dam Birth Year Sex YW (kg)\n1 NA NA 1990 Male 354\n2 NA NA 1990 Female 251\n3 1 NA 1991 Male 327\n4 1 NA 1991 Female 328\n5 1 2 1991 Male 301\n6 NA 2 1991 Female 270\n7 NA NA 1992 Male 330","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"Now, because cows sexually reproduce, the genotype of one animal is halfway the same as that of either parent (exception: inbreeding, see below). It should go without saying that each animal's genotype is identical to that of itself. From this we can then find the numerical multiplier for any relative (grandparent = 1/4, full sibling = 1, half sibling = 1/2, etc.). Let's write those values down in a table.","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"ID 1 2 3 4 5 6 7\n1 1 0 1/2 1/2 1/2 0 0\n2 0 1 0 0 1/2 1/2 0\n3 1/2 0 1 1/4 1/4 0 0\n4 1/2 0 1/4 1 1/4 0 0\n5 1/2 1/2 1/4 1/4 1 1/4 0\n6 0 1/2 0 0 1/4 1 0\n7 0 0 0 0 0 0 1","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"Hmm. All those numbers look suspiciously like a matrix. Why don't I put them into a matrix called A?","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"beginbmatrix\n1  0  frac12  frac12  frac12  0  0 \n0  1  0  0  frac12  frac12  0 \nfrac12  0  1  frac14  frac14  0  0 \nfrac12  0  frac14  1  frac14  0  0 \nfrac12  frac12  frac14  frac14  1  frac14  0 \n0  frac12  0  0  frac14  1  0 \n0  0  0  0  0  0  1\nendbmatrix","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"Now I'm going to take the matrix with all of the u values, and call it μ. To quantify the idea of genetic relationship, I will then say that","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"textupvar(μ) = A σ_μ^2","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"Where:","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"A = the relationship matrix defined above\nσ_μ^2 = the standard deviation of all the genotypes","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"To fully constrain the system, I have to make two more assumptions: 1) that the error term in each animal's equation is independent from all other error terms, and 2) that the error term for each animal is independent from the value of the genotype. I will call the matrix holding the e values ε and then say","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"textupvar(ϵ) = I σ_ϵ^2","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"textupcov(μ ϵ) = textupcov(ϵ μ) = 0","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"Substituting in the matrix names, our equation now looks like","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"beginbmatrix\n354 textupkg \n251 textupkg \n327 textupkg \n328 textupkg \n301 textupkg \n270 textupkg \n330 textupkg\nendbmatrix\n= μ + X\nbeginbmatrix\nb_mean \nb_1990 \nb_1991 \nb_male \nendbmatrix\n+ ϵ","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"We are going to make three changes to this equation before we are ready to solve it, but they are cosmetic details for this example.","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"Call the matrix on the left side of the equation Y (sometimes it's called the matrix of observations)\nMultiply μ by an identity matrix called Z. Multiplying by the identity matrix is the matrix form of multiplying by one, so nothing changes, but if we later want to find one animal's genetic effect on another animal's performance (e.g. a maternal effects model), we can alter Z to allow that\nCall the matrix with all the b values β.","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"With all these changes, we now have","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"Y = Z μ + X β + ϵ","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"This is the canonical form of the mixed-model equation, and the form that Charles Henderson used to first predict breeding values of livestock.","category":"page"},{"location":"how-to-calculate-epds/#Solving-the-equations","page":"How to Calculate EPDs","title":"Solving the equations","text":"","category":"section"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"Henderson proved that the mixed-model equation can be solved by the following:","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"beginbmatrix\nhatβ \nhatμ\nendbmatrix\n=\nbeginbmatrix\nXX  XZ \nZX  ZZ+A^-1λ\nendbmatrix^-1\nbeginbmatrix\nXY \nZY\nendbmatrix","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"Where","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"The variables with hats are the statistical estimates of their mixed-model counterparts\nThe predicted value of μ is called the Best Linear Unbiased Predictor or BLUP\nThe estimated value of β is called the Best Linear Unbiased Estimate or BLUE\n' is the transpose operator\nλ is a single real number that is a function of the heritability for the trait being predicted. It can be left out in many cases (λ = 1).\nλ = frac1-h^2h^2","category":"page"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"What happened to","category":"page"},{"location":"how-to-calculate-epds/#Footnotes","page":"How to Calculate EPDs","title":"Footnotes","text":"","category":"section"},{"location":"how-to-calculate-epds/#Exception","page":"How to Calculate EPDs","title":"Exception","text":"","category":"section"},{"location":"how-to-calculate-epds/","page":"How to Calculate EPDs","title":"How to Calculate EPDs","text":"An animal can share its genome with itself by a factor of more than one: that's called inbreeding! We can account for this, and beefblup does as it calculates A. This is an area that actually merits a good deal of study: see chapter 2 of Linear Models for the Prediction of Animal Breeding Values by Raphael A. Mrode (ISBN 978 1 78064 391 5).","category":"page"},{"location":"","page":"Home","title":"Home","text":"CurrentModule = BeefBLUP","category":"page"},{"location":"#beefblup","page":"Home","title":"beefblup","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for BeefBLUP.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"beefblup","category":"page"}]
}
