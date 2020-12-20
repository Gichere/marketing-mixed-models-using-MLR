# marketing-mixed-models-using-MLR
---
# Application of Market Mix Modellingwith using Multiple Linear Regression
## Quantifying the impact of each of the marketing channels on the sales volume.
Market Mix Modelling (MMM) is an analytical approach that turns marketing and sales data into a quantity that can measure the impact of the marketing channels on the sales volume. This technique is derived through regression between sales and marketing spends on each channel.

Since multilinear regression is used, the equation can be given as follows:

```Sales= β_0 + β_1*(Channel 1) + β_2*(Channel 2)```

Where Sales represents Sales Volume, Channel 1 and Channel 2 are different marketing channels, β_0 represents the Base Sales, which is the sales volume, in the absence of any marketing campaigns, because of natural demand, brand loyalty, and awareness. On the other hand, β_1 and β_2 are the coefficients for Channel 1 and Channel 2, representing the contribution of each channel to the sales volume.

### Importing our libraries, read our dataset, check for missing values and understand the summary statistics of each column:
```
library(ggplot2)
library(reshape2)
```
# Reading the dataset 
```data = read.csv('advertising.csv')```
# Checking for missing values
```sapply(data, function(x) sum(is.na(x)))```
# Checking summary statistics of each column
```summary(data)```
### Performing a Multiple Linear Regression 
With Sales as the dependent variable and google_ads, facebook and ad_campaign spends as the dependent variable:
```
linear_model = lm( sales ~., data)
summary(linear_model)
```
![MLR output](https://github.com/Gichere/marketing-mixed-models-using-MLR/blob/main/mlr.png)

The overall model is very significant with a p-value of 2.2e-16. Apart from the intercept which is a constant term, both Google ads and Facebook turn out to be the most significant variable which also has a very strong and moderate correlation, respectively, with the sales volume. The R-squared value is 0.8972 which means that the model captures 90% of the variance present in the data.

### The equation can be given as:
```Sales= 4.6251241 + 0.0544458*google_ads + 0.1070012*facebook + 0.0003357*ad_campaign```

Here the Base Sales is approximately 4.63 which means that irrespective of whether the marketing strategy is in place or not, this is the minimum sales volume that will be generated. It can also be seen that the contribution from the ad_campaign is insignificant as compared to the other marketing channels because the co-efficient is extremely small.

Also, spends on all of the marketing channels irrespective of the size of contribution has a positive impact on the sales volume. We now look into the contribution charts of google ads, facebook, and ad campaign.

Contribution charts are used as a means of visualizing the impact of marketing activities in terms of the percentage contribution to the sales volume with total contribution as the base.

Contribution of google ads spends = (Coefficient of google ads spends) * Mean(google ads spends)

Similarly, the contribution from other mediums is determined and the percentage of google ads contribution is given by ratio of contribution of google ads to the total contribution.

## Contribution Charts
```
Base_Sale = linear_model$coefficients[1]
google_ads = linear_model$coefficients[2]*mean(data$google_ads)
facebook = linear_model$coefficients[2]*mean(data$facebook)
ad_campaign = linear_model$coefficients[2]*mean(data$ad_campaign)

df_cc = data.frame(Medium = c("Base Sale","Google Ads","Facebook","Ad Campiagn"),Contribution = c(Base_Sale,google_ads,facebook,ad_campaign))
df_cc$Percentage_Contribution = round(df_cc$Contribution*100/sum(df_cc$Contribution),2)

ggplot(df_cc,aes(y=Percentage_Contribution,x=Medium))+geom_bar(stat='identity',fill = 'blue')+coord_flip()
```
![Contribution charts](https://github.com/Gichere/marketing-mixed-models-using-MLR/blob/main/mmm.png)
## Price elasticity
Calculating the effectiveness or elasticity of each medium which is the percentage change in sales volume with a unit change in the spend.
 ```
df_cc$Elasticity = df_cc$Contribution/mean(data$sales)
df_cc2 = df_cc
df_cc2 = df_cc2[df_cc2$Medium != 'Base Sale',c("Medium","Elasticity")]
print(df_cc2)
```
![](https://github.com/Gichere/marketing-mixed-models-using-MLR/blob/main/last.png)
