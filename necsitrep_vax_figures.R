# Requirements: install.packages(c("httr","readr","dplyr","lubridate","ggplot2","janitor","scales"))
library(httr)
library(readr)
library(dplyr)
library(lubridate)
library(ggplot2)
library(janitor)
library(scales)

#All data are from the National Immunization Survey-Fall Respiratory Virus Module (NIS-FRVM), used for RespVaxView
#Socrata CSV endpoint for the CDC dataset
sc2_query_url <- "https://data.cdc.gov/resource/ksfb-ug5d.csv?$limit=500000"
flu_query_url <- "https://data.cdc.gov/resource/sw5n-wg2p.csv?$limit=500000"
rsv_query_url <- "https://data.cdc.gov/resource/qeq7-f3ir.csv?$limit=500000"
pedsrsv_query_url <- "https://data.cdc.gov/resource/7nbz-eajm.csv?$limit=500000"


# Optional: If you have a Socrata app token, set it here to avoid throttling:
# app_token <- "YOUR_APP_TOKEN"
# headers <- add_headers(`X-App-Token` = app_token)

sc2 <- GET(sc2_query_url, timeout(60))
  stop_for_status(sc2)
flu <- GET(flu_query_url, timeout(60))
  stop_for_status(flu)
rsv <- GET(rsv_query_url, timeout(60))
  stop_for_status(rsv)

# Read CSVs into R
sc2txt <- content(sc2, "text", encoding = "UTF-8")
  sc2_vax <- read_csv(sc2txt, show_col_types = FALSE)
flutxt <- content(flu, "text", encoding = "UTF-8")
  flu_vax <- read_csv(flutxt, show_col_types = FALSE)
rsvtxt <- content(rsv, "text", encoding = "UTF-8")
  rsv_vax <- read_csv(rsvtxt, show_col_types = FALSE)

# exploratory tables
addmargins(table(current_vax_sc2$demographic_level, current_vax_sc2$demographic_name))
addmargins(table(current_vax_sc2$indicator_label, current_vax_sc2$indicator_category_label))
addmargins(table(current_vax_sc2$geographic_level, current_vax_sc2$week_ending))
addmargins(table(current_vax_sc2$indicator_label, current_vax_sc2$week_ending))

# Clean and subset vaccination data
#current_vax_all <- current_vax_all %>%
#  mutate(week_ending = as.Date(as.character(week_ending), format = "%Y-%m-%d"),

current_vax_sc2 <- sc2_vax %>%
  mutate(week_ending = lubridate::ymd(week_ending)) %>%
  filter(vaccine == "COVID",
           geographic_level == "State",
           geographic_name %in% c("Arizona", "Colorado", "New Mexico", "Utah"),
           demographic_level == "Overall",
           indicator_label == "Up-to-date",
           covid_season == "2025-2026"
         )
current_vax_flu <- flu_vax %>%
  mutate(week_ending = lubridate::ymd(week_ending)) %>%
  filter(vaccine == "FLU",
         geographic_level == "State",
         geographic_name %in% c("Arizona", "Colorado", "New Mexico", "Utah"),
         demographic_level == "Overall",
         indicator_label == "Up-to-date",
         influenza_season == "2025-2026"
  )

current_vax_rsv <- rsv_vax %>%
  mutate(week_ending = lubridate::ymd(week_ending)) %>%
  filter(
         geography_level == "State",
         geography_name %in% c("Arizona", "Colorado", "New Mexico", "Utah"),
         demographic_level == "Overall",
         indicator_label == "Up-to-date"
  )

covid_vax_4level <- current_vax_all %>%
  filter(vaccine == "COVID",
         geographic_level == "State",
         geographic_name %in% c("Arizona", "Colorado", "New Mexico", "Utah"),
         demographic_level == "Overall",
         indicator_label == "4-level vaccination and intent",
         indicator_category_label == "Received a vaccination"
        )

covid_vax_up2date_2526 <- current_vax_sc2 %>%
  filter(vaccine == "COVID",
         geographic_level == "State",
         geographic_name %in% c("Arizona", "Colorado", "New Mexico", "Utah"),
         demographic_level == "Overall",
         indicator_label == "Up-to-date",
         covid_season == "2025-2026"
  )

# ggplot2 line chart
cov_g1 <- ggplot(current_vax_sc2, aes(x = week_ending, y = estimate, color = geographic_name, group = geographic_name)) +
  geom_line(linewidth = 1) +
  geom_point(linewidth = 2) +
  scale_x_date(date_labels = "%Y-%m-%d") +
  scale_y_continuous(labels = label_number(scale = 1, suffix = "%")) +
  labs(
    title = "Adult (18+) COVID-19 vaccination coverage — AZ/CO/NM/UT",
    x = "Week ending",
    y = "Coverage (% Up-to-date)",
    color = "State"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

print(cov_g1)

flu_g1 <- ggplot(current_vax_flu, aes(x = week_ending, y = estimates, color = geographic_name, group = geographic_name)) +
  geom_line(linewidth = 1) +
  geom_point(linewidth = 2) +
  scale_x_date(date_labels = "%Y-%m-%d") +
  scale_y_continuous(labels = label_number(scale = 1, suffix = "%")) +
  labs(
    title = "Adult (18+) Flu vaccination coverage — AZ/CO/NM/UT",
    x = "Week ending",
    y = "Coverage (% Up-to-date)",
    color = "State"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

print(flu_g1)

rsv_g1 <- ggplot(current_vax_rsv, aes(x = week_ending, y = estimate, color = geography_name, group = geography_name)) +
  geom_line(linewidth = 1) +
  geom_point(linewidth = 2) +
  scale_x_date(date_labels = "%Y-%m-%d") +
  scale_y_continuous(labels = label_number(scale = 1, suffix = "%")) +
  labs(
    title = "Older Adults (50+) RSV vaccination coverage — AZ/CO/NM/UT",
    x = "Week ending",
    y = "Coverage (% Up-to-date)",
    color = "State"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

print(rsv_g1)



## NEXT
## add faceted plots for timeseries spaghetti plots, by state/virus
## over time, either include only current season or other
#NOTE: UT data highly incomplete
#add text. eg COVID vaccination was increasing but has leveled off, though this wmay be due to
#inconsistencies in reporting due to the holidays
# flu vaccination is LOW/HIGH despite high rates of flu positivity and flu-associated disease burden (//vice-versa)
#RSV age-specific, note that RSV vaccination data are for <5//<2 only 
#should we present flu and/or COVID vax rates for spec age groups (65+ e.g.)?

