library(forecast)
library(ggfortify)
library(gridExtra)

data(condmilk)
head(condmilk)
gglagplot(condmilk, lags=12)
ggfreqplot(condmilk)
tsdisplay(condmilk)
frequency(condmilk)
lambda<-BoxCox.lambda(condmilk)
tsdisplay(BoxCox(condmilk, lambda = lambda))
ndiffs(BoxCox(condmilk, lambda = lambda))
nsdiffs(BoxCox(condmilk, lambda = lambda))

fit1<-Arima(condmilk, lambda = lambda, order = c(1, 0, 0), seasonal = list(order=c(1, 0, 1), period = 12))
ggtsdiag(fit1)
tsdisplay(residuals(fit1))
Box.test(residuals(fit1), lag = 36, fitdf=3)

fit2<-auto.arima(condmilk, lambda = lambda) #, stepwise=FALSE, approximation = FALSE, d=0, D=0, max.order = 3)
ggtsdiag(fit1)
tsdisplay(residuals(fit2))
Box.test(residuals(fit2), lag = 36, fitdf=3)

print(paste("AICc(fit1, fit2)", fit1$aicc, fit2$aicc))

fit3<-stlf(condmilk, s.window = 'per', lambda = lambda, method = 'arima')

grid.arrange(autoplot(forecast(fit1, h=24))+ggtitle('fit1'),
            autoplot(forecast(fit2, h=24))+ggtitle('fit2'),
            autoplot(forecast(fit3, h=24))+ggtitle('fit3'))
