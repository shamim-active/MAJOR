ask <- par(ask=TRUE)

test_data <- data.frame(coef1=c(1, 1.59, 1.3, 1.24),
                        coef2=c(1, 1.7, 1.4, 1.04))

test_data$low1 <- test_data$coef1 - 1.96*c(0, .2, .1, .15)
test_data$high1 <- test_data$coef1 + 1.96*c(0, .2, .1, .15)

test_data$low2 <- test_data$coef2 - 1.96*c(0, .1, .15, .2)
test_data$high2 <- test_data$coef2 + 1.96*c(0, .1, .15, .2)

col_no <- grep("coef", colnames(test_data))
row_names <- list(
  list("Category 1", "Category 2", "Category 3", expression(Category >= 4)),
  list("ref",
       substitute(expression(bar(x) == val),
                  list(val = round(rowMeans(test_data[2, col_no]), 2))),
       substitute(expression(bar(x) == val),
                  list(val = round(rowMeans(test_data[3, col_no]), 2))),
       substitute(expression(bar(x) == val),
                  list(val = round(rowMeans(test_data[4, col_no]), 2))))
)

coef <- with(test_data, cbind(coef1, coef2))
low <- with(test_data, cbind(low1, low2))
high <- with(test_data, cbind(high1, high2))

# Change all to diamonds
forestplot(row_names, coef, low, high,
           fn.ci_norm=fpDrawDiamondCI,
           title="Cool study",
           zero = 1, boxsize=0.25,
           col=fpColors(box=c("royalblue", "gold"),
                        line=c("darkblue", "orange"),
                        summary=c("darkblue", "red")),
           xlab="The estimates",
           new_page = TRUE,
           legend=c("Treatment", "Placebo"),
           legend_args = fpLegend(title="Group",
                                  pos = list("topright", inset=.1),
                                  r=unit(.1, "snpc"),
                                  gp = gpar(col="#CCCCCC", lwd=1.5)))

# Change first to diamonds
forestplot(row_names, coef, low, high,
           fn.ci_norm=c("fpDrawDiamondCI",
                             rep("fpDrawNormalCI",
                                 times=nrow(coef)-1)),
           title="Cool study",
           zero = 1, boxsize=0.25,
           col=fpColors(box=c("royalblue", "gold"),
                        line=c("darkblue", "orange"),
                        summary=c("darkblue", "red")),
           xlab="The estimates",
           new_page = TRUE,
           legend=c("Treatment", "Placebo"),
           legend_args = fpLegend(title="Group",
                                  pos = list("topright", inset=.1),
                                  r=unit(.1, "snpc"),
                                  gp = gpar(col="#CCCCCC", lwd=1.5)))

# You can also use a list with the actual functions
# as long as it is formatted [[row]][[column]]
# Note: if you have a non-square input then
# the software will reformat [[col]][[row]]
# to [[row]][[col]]
forestplot(row_names, coef, low, high,
           fn.ci_norm=list(list(fpDrawDiamondCI, fpDrawCircleCI),
                                list(fpDrawNormalCI, fpDrawNormalCI),
                                list(fpDrawNormalCI, fpDrawCircleCI),
                                list(fpDrawNormalCI, fpDrawNormalCI)),
           title="Cool study",
           zero = 1, boxsize=0.25,
           col=fpColors(box=c("royalblue", "gold"),
                        line=c("darkblue", "orange"),
                        summary=c("darkblue", "red")),
           xlab="The estimates",
           new_page = TRUE,
           legend=c("Treatment", "Placebo"),
           legend_args = fpLegend(title="Group",
                                  pos = list("topright", inset=.1),
                                  r=unit(.1, "snpc"),
                                  gp = gpar(col="#CCCCCC", lwd=1.5)))

par(ask=ask)
