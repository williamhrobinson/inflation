# Inflation Analysis: Breadth of Price Increases & Real Returns for Savers

An interactive [Power BI dashboard / Python analysis] examining whether inflation has been broad-based or concentrated in a few categories, and whether savers have been keeping pace, built on [BLS CPI / FRED] data.

## Dashboard Overview

### Business Questions

1. **Has inflation been broad-based, or concentrated in a few categories?**
2. **Are savers beating inflation?**

This project looks past the single headline inflation number to show which categories are driving price growth and what that means in real terms for households holding cash and savings.

## Key Findings

- **Headline inflation:** [X.X%] year-over-year as of [month, year], versus a [X.X%] average over [period]
- **Breadth:** [X of Y] categories are running above [2% / headline]. [Category A] and [Category B] account for [X%] of the total increase, so inflation is [broad-based / concentrated]
- **Fastest-rising categories:** [Category] at [X%], [Category] at [X%]
- **Savers:** [Savings vehicle] yielded [X.X%] against [X.X%] inflation, a real return of [+/-X.X pts]. Savers have [beaten / trailed] inflation since [month, year]
- **Takeaway:** [One sentence: what the data says about who is being squeezed]

| Rank | Category | Inflation (YoY) | Gap vs. Headline |
|------|----------|-----------------|------------------|
| 1 | [Category] | [X.X%] | [+X.X pts] |
| 2 | [Category] | [X.X%] | [+X.X pts] |
| 3 | [Category] | [X.X%] | [+X.X pts] |
| 4 | [Category] | [X.X%] | [+X.X pts] |
| 5 | [Category] | [X.X%] | [+X.X pts] |

| Savings Vehicle | Avg. Rate | Avg. Inflation | Real Return |
|-----------------|-----------|----------------|-------------|
| [Savings account] | [X.X%] | [X.X%] | [+/-X.X pts] |
| [1-yr CD] | [X.X%] | [X.X%] | [+/-X.X pts] |
| [Treasury / other] | [X.X%] | [X.X%] | [+/-X.X pts] |

## Dashboard Pages

1. **Executive Overview**: Headline inflation trend, current rate, and the largest category contributors
2. **Breadth of Inflation**: Share of categories above target, category-level inflation, and contribution to the total
3. **Are Savers Winning?**: Nominal savings rates vs. inflation, with real return over time
4. **Key Takeaways**: Synthesized findings and implications

## Recommendations

- **Watch [Category] first.** It is the largest driver of price growth ([X%] YoY), so it has the biggest impact on household budgets.
- **Look beyond the headline number.** [If concentrated: a few categories are doing most of the work, so the headline overstates broad pressure. If broad-based: price growth is widespread, so the headline is a fair signal.]
- **Compare savings products to inflation, not just to each other.** [Vehicle] delivered a positive real return, while [vehicle] did not.
- **Track real returns over time.** The gap between savings rates and inflation has [widened / narrowed] since [date].
- **Note the limits of CPI.** It measures an average basket and may not reflect any one household's spending.

## Tools & Methods

- **[Power BI Desktop / Python]**: data modeling, visualization, dashboard design
- **[DAX / pandas]**: measures for year-over-year inflation, category contribution, and real return (nominal rate minus inflation)
- **Data preparation**: [e.g., aligning monthly series, calculating YoY change, grouping categories] via [Power Query / pandas]

## Dataset

[Source name], [series used], covering [start date] to [end date], [frequency]. Savings rate data from [source].

## Files

- `[path/to/dashboard-or-notebook]`: full interactive dashboard
- `data/`: source datasets
- `screenshots/`: dashboard page exports

Built by Will [Last name] — [LinkedIn]