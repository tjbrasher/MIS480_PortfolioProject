library(stringr)

## importing datasets
project_data = read.csv("hours_by_full_job_code_2022-01-03_thru_2022-08-25 (1).csv", header=TRUE, sep=",")

clients = read.csv("clients.csv", header=TRUE, sep=",")

project_budgets = read.csv("projectsByEstimate.csv", header=TRUE, sep=",")

project_codes = read.csv("eavitime_job_codes_2022-08-25.csv", header=TRUE, sep=",")


project_data$job_code = project_data[c('Client', 'Project')] = str_split_fixed(project_data$job_code, " >> ", 2)

## renaming column to match for merge
names(project_codes)[names(project_codes) == "ï..JobcodeLevel_0"] = "Client"

names(project_codes)[names(project_codes) == "JobcodeLevel_1"] = "Project"

project_codes = project_codes[, !(names(project_codes) %in% "JobcodeLevel_2")]



## joining datasets to assign project numbers to clients
project_code_combine = merge(clients, project_codes, by="Client", all=FALSE)

colnames(project_code_combine)
colnames(project_data)

write.csv(project_code_combine, "project_code_combine.csv")


project_budget_combine = merge(project_code_combine, project_budgets, by="Project", all=FALSE)

colnames(project_budget_combine)

write.csv(project_budget_combine, "project_budget_combine.csv")

project_data_combine = merge(project_budget_combine, project_data, by="Project", all=FALSE)

colnames(project_data_combine)


write.csv(project_data_combine, na="", "project_data_combine.csv")
