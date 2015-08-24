slices <- read.csv("/work/catapult/perf_insights/data-w-kind.csv", sep=",", header=TRUE)
slices$pctThirdParty <- slices$thirdParty / slices$duration
slices$pctFirstParty <- slices$firstParty / slices$duration
slices$pctUnaccounted <- slices$unaccounted / slices$duration
plot(y=slices$pctThirdParty, x=log10(slices$duration), col=slices$kind)
legend('topleft', legend=levels(slices$kind), col=1:length(slices$kind),pch=1)
abline(v=log10(50), col="purple")
abline(v=log10(16), col="orange")

(map traces locally, do -o foo.json)
js <- fromJSON(file("tpr.json"))
