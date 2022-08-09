

df_2016 <- readxl::read_xlsx(here::here("data", "Summary 2016 to 2019.xlsx")) %>%
  janitor::clean_names()


df_2016_summary <- df_2016 %>%
  mutate(month = month(month, label = TRUE),
         date = glue::glue("{year}-{month}"), # concatenates year-month
         date = ym(date), # changes to date format
         time = time_length(interval(min(date), date),
                            unit = "month")) %>%
  mutate(log_illnesses = log(n_illnesses),
         log_hospitalizations = log(n_hospitalizations),
         log_fatalities = log(n_deaths))

tsplot(df_2016_summary$log_illnesses)




#### 

df_nors_db <- readxl::read_xlsx(here::here("data", "NationalOutbreakPublicDataTool (3).xlsx")) %>%
  janitor::clean_names()


csv_outbreaks <- readxl::read_xlsx(here::here("data", "19952020.xlsx"),sheet = 1) %>%
  janitor::clean_names()

df_outbreaks_summary <- csv_outbreaks %>%
  mutate(date = glue::glue("{year}-{month}"), # concatenates year-month
         date = ym(date), # changes to date format
         time = time_length(interval(min(date), date),
                            unit = "month")) %>% # computes number
  # of months since
  # lowest date
  
  filter(str_detect(etiology, "Salmonella")) %>%
  group_by(time, year, month, date) %>%
  summarize(total_illnesses = sum(illnesses, na.rm = TRUE),
            total_hospitalizations = sum(hospitalizations, na.rm = TRUE),
            total_fatalities = sum(deaths, na.rm = TRUE),
            log_illnesses = log(total_illnesses),
            log_hospitalizations = log(total_hospitalizations),
            log_fatalities = log(total_fatalities)) %>%
  ungroup() %>%
  mutate(diff_log_illnesses = c(NA, diff(log_illnesses)),
         diff_log_hospitalizations = c(NA, diff(log_hospitalizations)),
         diff_log_fatalities = c(NA, diff(log_fatalities))) %>%
  arrange(time)

df_nors_summary <- df_nors_db %>%
  mutate(month = month(month, label = TRUE),
         date = glue::glue("{year}-{month}"), # concatenates year-month
         date = ym(date), # changes to date format
         time = time_length(interval(min(date), date),
                            unit = "month")) %>%
  # filter(primary_mode != "Indeterminate/Other/Unknown") %>%
  group_by(time, year, month, date) %>%
  summarize(total_illnesses = sum(illnesses, na.rm=TRUE),
         total_hospitalizations = sum(hospitalizations, na.rm=TRUE),
         total_fatalities = sum(deaths, na.rm=TRUE)) %>%
  mutate(log_illnesses = log(total_illnesses),
         log_hospitalizations = log(total_hospitalizations),
         log_fatalities = log(total_fatalities))
