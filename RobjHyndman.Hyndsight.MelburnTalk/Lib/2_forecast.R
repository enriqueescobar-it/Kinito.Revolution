library(forecast)

# ETS forecasts
fit <- ets(USAccDeaths)
forecastFit <- forecast(fit)
plot(forecastFit)

# Automatic ARIMA forecasts
fit <- auto.arima(WWWusage)
plot(forecast(fit, h=20))

# ARFIMA forecasts
library(fracdiff)
x <- fracdiff.sim( 100, ma=-.4, d=.3)$series
fit <- arfima(x)
plot(forecast(fit, h=30))

# Forecasting with STL
tsmod <- stlm(USAccDeaths, modelfunction=ar)
plot(forecast(tsmod, h=36))

plot(stlf(AirPassengers, lambda=0))

decomp <- stl(USAccDeaths,s.window="periodic")
plot(forecast(decomp))

# TBATS forecasts
fit <- tbats(USAccDeaths, use.parallel=FALSE)
plot(forecast(fit))

taylor.fit <- tbats(taylor)
plot(forecast(taylor.fit))