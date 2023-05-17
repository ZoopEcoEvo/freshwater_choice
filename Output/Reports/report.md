Effect of different water types of freshwater copepod survival
================
Current as of 2023-05-17

- <a href="#survival" id="toc-survival">Survival</a>
- <a href="#body-size" id="toc-body-size">Body Size</a>
- <a href="#fecundity" id="toc-fecundity">Fecundity</a>

Copepods were collected from Lake Champlain on April 26th 2023. Water
temperature was \~7˚C. Several species were abundant, but we only
examined survival of adult female *Leptodiaptomus sicilis* here. We
expect results will be broadly generalizable to other species

# Survival

We examined survival in three different water types: 63-um filtered lake
water, bottled spring water (Crystal Geyser brand), and reverse-osmosis
filtered water. Survival was tracked for 35 individual copepods. Shown
below is the change in survival over time. Lines for the different
treatments are shown in different colors. Data for the two groups is
lumped together.

``` r
mort_data = mort_data %>%  
  mutate("status" = if_else(death_day <= max(mort_data$death_day) - 1, 1, 0),
         treatment = factor(treatment, levels = c("FLW","BSW","ROW")),
         exp_rep = factor(exp_rep, levels = c("W","F"))
  )

surv_model = survfit(Surv(death_day, status) ~ treatment, data = mort_data)

#summary(surv_model, times = c(1:14))

ggsurvplot(
  fit = surv_model,
  xlab = "Days",
  ylab = "Survival Proportion",
  title = "Kaplan-Meier Proportional Survival Estimates",
  conf.int = TRUE,
  pval = FALSE)
```

<img src="../Figures/markdown/surv-curves-1.png" style="display: block; margin: auto;" />

Shown below are estimates of the proportional hazard ratio (the change
in risk of mortality relative to the control) for the different
treatments, but also for the two experimental replicates.

``` r

cox_model <- coxph(Surv(death_day, status) ~ treatment + exp_rep + volume, data = mort_data)

#summary(cox_model)

ggforest(cox_model, data = mort_data)
```

<img src="../Figures/markdown/hazard-ratios-1.png" style="display: block; margin: auto;" />

# Body Size

After 20 days, surviving females were measured (prosome length; mm).
Sizes ranged from 0.784 mm to 0.915 mm.

``` r
ggplot(size_data, aes(x = length)) + 
  geom_histogram(binwidth = 0.025, colour = "black") + 
  labs(x = "Prosome Length (mm)") + 
  theme_matt()
```

<img src="../Figures/markdown/size-hist-1.png" style="display: block; margin: auto;" />

# Fecundity

*Leptodiaptomus* retains eggs in loosely attached ovisacs, which allows
us to measure fecundity. Here we refer to fecundity as the number of
eggs contained in the clutch.

The initial clutch size (reflecting fecundity in the field) varied
between 4 and 20 eggs.

``` r
clutch_data %>% 
  filter(clutch_num == 1) %>%  
  ggplot(aes(x = clutch_size)) +
  geom_histogram(binwidth = 2, fill = "grey90", colour = "grey20") + 
  labs(x = "Fecundity (number of eggs)") + 
  theme_matt()
```

<img src="../Figures/markdown/clutch-hist-1.png" style="display: block; margin: auto;" />

Eggs took between 1 and 8 days to hatch.

``` r
ggplot(clutch_data, aes(x = treatment, y = clutch_hold_time)) + 
  geom_boxplot() + 
  geom_point(size = 3, alpha = 0.4, position = position_jitter(width = 0.05, height = 0)) + 
  ylim(c(0, max(clutch_data$clutch_hold_time, na.rm = T))) + 
  labs(x = "Water Treatment", 
       y = "Clutch Hold Time (days)") + 
  theme_matt()
```

<img src="../Figures/markdown/hold-times-1.png" style="display: block; margin: auto;" />

``` r
size_fec.model = lm(data = size_egg, clutch_size ~ length)

egg_slope = coefficients(size_fec.model)[2]
```

We might expect that larger females produce larger clutches of eggs.
While limited by the small sample size, we see a positive trend here,
where fecundity increases by about 62.8 eggs per 0.1 mm in size.

``` r
size_egg = inner_join(clutch_data, mutate(size_data, cup = as.numeric(cup)), by = c("exp_rep", "cup", "treatment", "volume")) %>% 
  select(exp_rep, cup, treatment, clutch_size, length)

ggplot(size_egg, aes(x = length, y = clutch_size)) + 
  geom_smooth(method = "lm", size = 2, colour = "grey70") + 
  geom_point(size = 4, aes(colour = treatment)) + 
  scale_colour_manual(values = c("BSW" = "turquoise3", "FLW" = "darkolivegreen3")) + 
  labs(x = "Prosome Length (mm)", 
       y = "Clutch Size (# eggs)") + 
  theme_matt()
```

<img src="../Figures/markdown/size-fecundity-plot-1.png" style="display: block; margin: auto;" />

``` r
knitr::kable(car::Anova(size_fec.model, type = "III"))
```

|             |   Sum Sq |  Df |   F value |   Pr(\>F) |
|:------------|---------:|----:|----------:|----------:|
| (Intercept) | 44.54544 |   1 |  7.101053 | 0.0184876 |
| length      | 70.11445 |   1 | 11.177046 | 0.0048288 |
| Residuals   | 87.82305 |  14 |        NA |        NA |
