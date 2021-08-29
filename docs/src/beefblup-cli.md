```@meta
CurrentModule = BeefBLUP
```

# beefblup Command Line Interface (CLI) documentation

> _A work in progress_

**Notice:** This document is a draft for what the command-line interface for
beefblup would look like as of version 1.0, if beefblup was even a command-line
application to begin with (it's not). It is modeled (loosely) after the man page
format. It is not intended to be taken seriously, but instead to serve as a
useful thought experiment and brainstorming ground on the future of beefblup.
Please use it if it clarifies things for you. If it doesn't, ignore it.

## Input file

beefblup requires a very specific format of input file. The format may be in
comma-separated values (CSV) or Excel 2007+ (XLSX) format. CSV files should not
be quoted (and therefore cannot have commas within cell values). Other formats
may be forthcoming.

A beefblup data file must have at least six columns appearing in this order:

- ID
- Sire ID
- Dam ID
- Birthdate
- Fixed effect(s)
- Response variable(s)

The first row always contains column names. The values of column names are
unimportant for the first four columns, as they will always be treated the same
regardless of the name. The generated report will use the column names
of fixed effects and response variables as given.

Each fixed effect should have its own column, to as many as are needed. There is
no limit to the number of fixed effects as defined by beefblup, however its
dependencies might have some. The same rules apply to response variables.

Unknown values should be left blank (`,,`). Do not substitute null placeholders
(e.g. `NULL`, `NA`, `0`, `nothing`, `undefined`, etc.) for unknown values.

An example spreadsheet might have the following format

| ID  | Sire ID | Dam ID | Birthdate | Sex    | Weaning Weight |
| --- | ------- | ------ | --------- | ------ | -------------- |
| 1   |         |        | 1/1/1990  | Male   | 354            |
| 2   | 1       |        | 1/1/1990  | Female | 251            |
| 3   | 1       |        | 1/1/1991  | Male   | 327            |
| 4   | 1       | 2      | 1/1/1991  | Female | 328            |
| 5   |         | 2      | 1/1/1991  | Male   | 301            |
| 6   |         |        | 1/1/1991  | Female | 270            |
| 7   |         |        | 1/1/1992  | Male   | 330            |

## Synopsis

```bash
beefblup [-G SNPs_file] [-M num_response_vars] [-o report_spreadsheet]
[--no-aod] [--no-year] [--no-season] [--no-autob] [--maternal] input_file
[report_file]
```

## Command line basic syntax

The most basic input is to simply pass the input file name to the program.

```bash
beefblup filename.csv
```

In this case beefblup will insert fixed-effects for age-of-dam, year, and
season, and will calculate the EBVs for the response variable in the final
column. The report will then be saved as `filename_report.txt`.

## Suppressing automatically-calculated fixed effects

If you don't wish to include one of the automatically calculated fixed-effects
from your model, you can pass arguments to suppress them.

### Suppress Age-of-dam

```bash
beefblup --no-aod filename.csv
```

### Suppress year

```bash
beefblup --no-year filename.csv
```

### Suppress season

```bash
beefblup --no-season filename.csv
```

### Suppress all calculated fixed effects

```bash
beefblup --no-autob filename.csv
```

The argument `--no-autob` comes from the nomenclature of assigning fixed-effects
to the matrix _b_ in Henderson's mixed-model equations.
