# Results
# Entire U.S. analysis. We want to see the change of all monitor values in the entire U.S.
# in 1999 and 2012 and we take the log of the PM values to adjust for the skew in the data
boxplot(log2(x0), log2(x1))
# Then we want to know the characteristic of those two variables
summary(x0)
summary(x1)

# from the summary of x1, it appears that there are some negative values of PM. This is weird,
# so we decide to like into this.

negative <- x1 < 0
mean(negative, na.rm = T)
# First of all, we found the negative values is a relatively small proportion.
# Then do these values occur in some regular? We can look into it, but the original data are
#character strings, so we convert them into Date format at first.
dates <- pm1$Date
dates <- as.Date(as.character(dates), "%Y%m%d")
# extract the month from each of dates with negative values
missing.months <- month.name[as.POSIXlt(dates)$mon + 1]
# don't know what's the mean of this command
tab <- table(factor(missing.months, levels = month.name))
#The function factor is used to encode a vector as a factor
#(the terms ‘category’ and ‘enumerated type’ are also used for factors). 
#If argument ordered is TRUE, the factor levels are assumed to be ordered.
#factor(x = character(), levels, labels = levels, exclude = NA, ordered = is.ordered(x), nmax = NA)
round(100 * tab / sum(tab))

# Change in PM levels at an individual monitor
# To identify a monitor in New York State has data in 1999 and 2000;
#1.only New York; 2. Only County.Code and Site.ID
site0 <- unique(subset(pm0, State.Code == 36, c(County.Code, Site.ID)))
site1 <- unique(subset(pm1, State.Code == 36, c(County.Code, Site.ID)))
# subsetsubset(x, subset, select, drop = FALSE, ...)
# Return subsets of vectors, matrices or data frames which meet conditions.
#unique returns a vector, data frame or array like x but with duplicate elements/rows removed.
str(site0)
str(site1)

# choose the monitors that has data in both periods
both <- intersect(site0, site1)
# How to decide which one to choose?

pm0$county.site <- with(pm0, paste(County.Code, Site.ID, sep = "."))
pm1$county.site <- with(pm1, paste(County.Code, Site.ID, sep = "."))
#with() Evaluate an R expression in an environment constructed from data, 
cnt0 <- subset(pm0, State.Code == 36 & county.site %in% both)
cnt1 <- subset(pm1, State.Code == 36 & county.site %in% both)

#subset the original data frames to only include the data from the monitors that overlap between 1999 and 2012
sapply(split(cnt0, cnt0$county.site), nrow)
sapply(split(cnt1, cnt1$county.site), nrow)

#focus on County 63 and site ID 2008
both.county <- 63
both.id <- 2008

#choose county 63 and side ID 2008
pm1sub <- subset(pm1, State.Code == 36 & County.Code == both.county & Site.ID == both.id)
pm0sub <- subset(pm1, State.Code == 36 & County.Code == both.county & Site.ID == both.id)

#plot the time series data of PM
dates1 <- as.Date(as.character(pm1sub$Date), "%Y%m%d")
x1sub <-pm1sub$Sample.Value
dates0 <- as.Date(as.character(pm0sub$Date), "%Y%m%d")
x0sub <-pm1sub$Sample.Value

#but we need to find global range. This can make it easier to compare.

rng <- range(x0sub, x1sub, na.rm = T)
par(mfrow = c(1, 2), mar = c(4, 5, 2, 1))
# I guess this is a little complicated function
plot(dates0, x0sub, pch = 20, ylim = rng, xlab = "", ylab = expression(PM[2.5] * "(" *
                                                                           mu * g/m^3 * ")"))
abline(h = median(x1sub, na.rm = T))

