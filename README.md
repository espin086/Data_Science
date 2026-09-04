# Data_Science

A grab bag of self-contained R analyses written by JJ Espinoza, one folder per question. Some are personal decisions worked out with data (which handyman to hire, how to split chores between roommates, which kitchen stove to buy, what to feed a baby on a budget), some are statistics exercises (birth weight regression, activity recognition from accelerometer data), and some are text mining (2016 campaign speeches, Spanish worship song lyrics). Each folder holds its own data, scripts, and output images, so nothing depends on anything else in the repo. The scripts are exploratory: they were written to be stepped through line by line in RStudio rather than run as a pipeline.

Despite the repo description mentioning Python, everything committed here is R (`.R` and one `.Rmd`).

## Catalog

| Folder | What it does | Main libraries |
|---|---|---|
| `baby_weight/` | Exploratory regression on the `bwght2.csv` dataset: mother's age, education, prenatal visits, smoking and drinking against birth weight. Ships histograms and scatter plots as PNGs plus the dataset handbook PDF. | base R (`lm`, `hist`, `plot`) |
| `chores/` | Assignment problem for splitting household chores among roommates. Pulls two Google Sheets as CSV, scores how good each person is at each chore, and solves it as a linear program. | `RCurl`, `foreign`, `linprog` |
| `election/` | Text classification of 2016 Hillary Clinton and Donald Trump position statements and speeches. `2. Code/` holds corpus cleaning and term-document-matrix building, single-speech word frequency analysis, and supervised model training with cross-validation. `4. App/App.R` is a Shiny app skeleton that takes pasted text and is meant to predict the speaker. `1. Data/` holds the raw speech text files and the built `TDM.csv`. | `tm`, `plyr`, `class`, `reshape`, `caret`, `doMC`, `shiny` |
| `feed_baby/` | Diet problem as a linear program: minimize the cost of a one-month-old's daily food while meeting calorie, carb, and other nutrient constraints. Reads the food table from a CSV on GitHub. | `RCurl`, `foreign`, `linprog` |
| `find_help_on_yelp/` | Ranks handymen scraped into a Google Sheet from Yelp. Tracks call status per vendor, then uses clustering and principal components (scree plot, means plot) to pick a shortlist, saved to `SelectedHandymen.csv`. | `RCurl`, `foreign`, base R |
| `lyrics/` | Five-step stylometric analysis of the Spanish song collection in `Songs.txt`: token frequency, per-song token distribution, mean word frequency and type-token ratios, hapax richness, and a word cloud. Stopwords are removed in both English and Spanish. | `tm`, `wordcloud`, base R |
| `stoves/` | R Markdown report comparing kitchen stoves on price, weight, dimensions, and oven capacity against a fixed set of requirements. Knitted output is committed as PDF, DOCX, and HTML. | `car`, `knitr` |
| `weights/` | Coursera Practical Machine Learning project: downloads the weight-lifting exercise dataset, keeps the `accel_*` features, drops near-zero-variance columns, and fits a classifier for exercise `classe`. | `caret` |

The `election/`, `lyrics/`, and `weights/` folders have their own README files. `election/README.md` is still an unfilled project template.

## Requirements

R (the scripts predate the tidyverse and use base R plus the packages above). RStudio is the assumed editor. Install what you need:

```r
install.packages(c("RCurl", "foreign", "linprog", "tm", "plyr", "class",
                   "reshape", "caret", "doMC", "shiny", "wordcloud",
                   "car", "knitr"))
```

`doMC` is not available on Windows, so `election/2. Code/4. Supervised Learning of Text.R` needs its `registerDoMC` call removed or swapped for `doParallel` there.

## Installation

```bash
git clone https://github.com/espin086/Data_Science.git
cd Data_Science
```

There is no package to install and no build step.

## Usage

Most scripts open with a hardcoded `setwd()` pointing at a path on the author's old machine. Change that line to the folder you cloned into before running, or set the working directory yourself and delete the call.

```bash
# chores assignment
Rscript "chores/Who Should Do The Dishes.R"

# baby food diet LP
Rscript "feed_baby/Diet Problem - Linear Programming.R"

# handyman shortlist
Rscript "find_help_on_yelp/Finding a Hanyman on Yelp.R"

# lyrics analysis, run in order
Rscript "lyrics/1. First Initial Analysis.R"
Rscript "lyrics/5. Word Cloud.R"

# election text pipeline: clean and build the TDM, then train
Rscript "election/2. Code/1. Data Cleaning and Feature Engineering.R"
Rscript "election/2. Code/4. Supervised Learning of Text.R"
```

Knit the stove report:

```r
rmarkdown::render("stoves/Kitchen Stove Analysis.Rmd")
```

Run the Shiny app:

```r
shiny::runApp("election/4. App")
```

The app's server function currently only echoes the input text back. The three UI tabs (prediction, speech exploration, how it works) are laid out but not wired to the trained model.

Scripts that pull from Google Sheets (`chores/`, `find_help_on_yelp/`) depend on those sheets still being published to the web. If a URL has gone dead, the CSV read will fail.

## License

No LICENSE file is present in this repository.
