library(ggplot2)
library(reshape2)
# Reading the dataset 
data = read.csv('advertising.csv')
# Checking for missing values
sapply(data, function(x) sum(is.na(x)))
# Checking summary statistics of each column
summary(data)
# Multiple Linear Regression
linear_model = lm( sales ~., data)
summary(linear_model)

#Contribution Charts
Base_Sale = linear_model$coefficients[1]
google_ads = linear_model$coefficients[2]*mean(data$google_ads)
facebook = linear_model$coefficients[2]*mean(data$facebook)
ad_campaign = linear_model$coefficients[2]*mean(data$ad_campaign)

df_cc = data.frame(Medium = c("Base Sale","Google Ads","Facebook","Ad Campiagn"),Contribution = c(Base_Sale,google_ads,facebook,ad_campaign))
df_cc$Percentage_Contribution = round(df_cc$Contribution*100/sum(df_cc$Contribution),2)

ggplot(df_cc,aes(y=Percentage_Contribution,x=Medium))+geom_bar(stat='identity',fill = 'blue')+coord_flip()

# Price Elasticity
df_cc$Elasticity = df_cc$Contribution/mean(data$sales)
df_cc2 = df_cc
df_cc2 = df_cc2[df_cc2$Medium != 'Base Sale',c("Medium","Elasticity")]
print(df_cc2)
