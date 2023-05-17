
### Formatting survival and mortality data 
surv = raw_surv_data %>%  
  pivot_longer(cols = starts_with("day"), # Changes data from wide to long format
               names_to = "day",
               names_prefix = "day",
               values_to = "alive") %>% 
  mutate(ID = paste(exp_rep, cup, sep = "_"))

mort_data = surv %>% 
  filter(alive == 1) %>% # Filters to just data where the individual is alive
  group_by(ID) %>%  
  mutate(day = as.numeric(day)) %>% 
  filter(day == max(day)) %>%  # Filters to just the last day each individual is recorded as alive
  mutate(death_day = day + 1) %>%  # Which day the individual would have been recorded as dead. 
  # NOTE - this will "force" death for individuals that survived the entire experiment, but this is accounted for in the follow up analyses
  select(ID, exp_rep, cup, treatment, volume, death_day)

### Writes data to output directory 
write.csv(surv, file = "Output/Data/surv.csv", row.names = F)
write.csv(mort_data, file = "Output/Data/mort.csv", row.names = F)

### Formatting fecundity data 
fecund_data = raw_fecund_data %>% 
  mutate(across(starts_with("day"), as.character)) %>% 
  pivot_longer(cols = starts_with("day"), # Changes data from wide to long format
               names_to = "day",
               names_prefix = "day",
               values_to = "clutch_size") %>% 
  mutate(ID = paste(exp_rep, cup, sep = "_"))


clutch_data = fecund_data %>%  
  mutate(clutch_size = if_else(clutch_size == "released", "9999", clutch_size), 
         clutch_size = as.numeric(clutch_size),
         day = as.numeric(day)) %>% 
  drop_na(clutch_size) %>%  
  group_by(exp_rep, cup, treatment) %>%  
  mutate("pre_clutch_time" = day - lag(day),
         "clutch_hold_time" = lead(day) - day) %>% 
  filter(clutch_size!=9999) %>% 
  mutate("clutch_num" = row_number())

write.csv(clutch_data, file = "Output/Data/clutch_data.csv", row.names = F)


