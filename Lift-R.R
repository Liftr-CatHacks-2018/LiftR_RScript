library("DBI", lib.loc="~/R/win-library/3.4")
library("RMySQL", lib.loc="~/R/win-library/3.4")

con <- RMySQL::dbConnect(RMySQL::MySQL(),
                 user="liftrAdmin", password="Vw5MxF2X6vvJ",
                 dbname="LiftData", host="liftrdb2.cdviygl7ogql.us-east-2.rds.amazonaws.com")

rs <- RMySQL::dbSendQuery(con, "SELECT * FROM RawLiftScores;")
dat <- RMySQL::fetch(rs)

idRV <- runif(n=1000, min=0, max=12)
scoreRV <- rchisq(n=1000, df=75, ncp = 0)
acTimes <- rep("2018-04-08 12:20:42", 1000)

inTab = RMySQL::dbReadTable(con, "RawLiftScores")

tab = data.frame(AquisitionTime=acTimes,LifterID=floor(idRV), Score=scoreRV)

RMySQL::dbWriteTable(con, "RawLiftScores", tab, overwrite=TRUE)



hist(scoreRV, 500)
#plot(floor(idRV), scoreRV)


