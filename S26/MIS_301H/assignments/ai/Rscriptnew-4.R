#Association Rules
install.packages("arules")

install.packages("arulesViz")

library(arules)
library (arulesViz)

str(Titanic)

# convert all columns to factors
Titanic[] <- lapply(Titanic, as.factor)
str(Titanic)

rules = apriori(Titanic, parameter=list(supp=0.05,conf = 0.2,minlen=2)) 

 
rules = sort(rules, by = "lift")

inspect(rules)

#subsetting 
rules.sub <- subset(rules, subset = rhs %in% c("survived=yes"))
inspect (rules.sub)
plot(rules.sub)

#CrossCatalog

qq= as.matrix(CatalogCrossSell2)
qq=as(qq, "transactions")
rules = apriori(qq, parameter=list(supp=0.1,conf = 0.2,minlen=2))
rules = sort(rules, by = "lift")
inspect(rules.sub)
rules.sub = apriori(qq, parameter=list(minlen=2, supp=0.1,conf=0.2), appearance = list(rhs=c("Housewares Division"), default="lhs"))
rules.sub = sort(rules.sub, by = "lift")
inspect(rules.sub)

#Clustering

#Using a subset of the attributes
nbanew=nba_data_2026[c("FG%","AGE","3P%","+/-","FT%","BLK","AST","REB","MIN", "PTS","TOV")]
View(nbanew)
summary(nbanew)

#Scaling of Attributes
nbanew=scale(nbanew)


#view scaled values
summary(nbanew)

# Creating cluster
kc = kmeans(nbanew, 5)

#Viewing cluster information
kc

#Plotting cluster data points for two atttributes
plot(nba_data_2026[c("AST","AGE")], col=kc$cluster)

#Combining names, salary and cluster id
nww=cbind(nba_data_2026[,1],nba_data_2026[,ncol(nba_data)],kc$cluster)
ww=ww[order(ww[,ncol(ww)]),]

View(ww)


# Wine Clustering
wine = Wine
wine_cluster = wine[, 2:14]  # exclude Type column

# Scale the variables
wine_scaled = scale(wine_cluster)

# K-Means with 5 clusters
set.seed(1234)
kc_wine = kmeans(wine_scaled, 5)

# Combine original data with cluster assignments
wine_result = cbind(wine, Cluster = kc_wine$cluster)

# View results
View(wine_result)

# Export to CSV for Excel pivot table
write.csv(wine_result, "wine_clusters.csv", row.names = FALSE)

#Classification

install.packages("party")
library(party)

wine=Wine
wine$Type= factor(wine$Type)

#Creating training and test dataset
set.seed(1234)

ind <- sample (2, nrow(wine), replace = TRUE, prob = c(0.8, 0.2))

train.data <- wine [ind == 1, ]

test.data <- wine [ind == 2, ]

#Creating the formula

myFormula <- as.formula(paste('Type ~', paste(colnames(wine)[2:14], collapse='+')))

myFormula

#Bulding the classsification model
wine_ctree <- ctree(myFormula, data = train.data)
print (wine_ctree)

plot (wine_ctree)

#Making predictions for the training dataset and determining the accuracy
trainPred <- predict(wine_ctree, newdata = train.data)

table(trainPred, train.data$Type)

accuracy=1-8/length(trainPred)
accuracy

#Making predictions for the test dataset and determining the accuracy
testPred <- predict(wine_ctree, newdata = test.data)

table(testPred, test.data$Type)
accuracy=1-5/length(testPred) #Accuracy = 1 - Error Rate
accuracy