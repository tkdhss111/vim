rm(list=ls())
setwd("~/Documents/journals/asai/2020-05_special_issue_ai_contest/fig")

#
# Convert png, bmp, jpg and pdf to eps
#
#system('sh ./image2eps.sh')

#
# File basenames
#
FILES <- c('rmse_annual_by_daytype','rmse_actual', 'rmse_annual_by_month', 'contest_result_actual')

#
# Read CSV tables
#
ds <- vector('list', length(FILES)) 

for (i in seq_along(FILES))
{
  ds[[i]] <- as.matrix(read.csv(file = paste0('data/', FILES[i], '.csv'))[, -1])
}

px <- as.POSIXct(read.csv(file = paste0('data/', FILES[4], '.csv'))[, 1])

#
# Column names for graphics
#
CNMS <- vector('list', length(FILES))
CNMS[[1]] <- c('平日', '土曜', '日曜', '祝日', '特異日', '通年')
CNMS[[2]] <- c('平日', '土曜', '日曜', '9/2 〜 9/10')
CNMS[[3]] <- c(paste(1:12, '月'), '通年')
CNMS[[4]] <- c('実績値', '予測値（でんき予報）') 

#
# Annual RMSE
#
par(cex=1.5, cex.lab=1.2)

for (i in 1:2)
{
  print(FILES[i])
  cairo_ps(paste0(FILES[i], '.ps'))
  barplot (height      = ds[[i]],
           beside      = T,
           names.arg   = CNMS[[i]],
           ylim        = c(0, 150),
           ylab        = 'RMSE  x10 [ MW ]',
           legend.text = paste0(1:5, '位'),
           args.legend = list(x = "topleft", bty='n',
                              title=expression(underline('上位者'))))
  for (j in dev.list() ) dev.off(j)
# system(paste0('evince ', FILES[i], '.ps'))
}

#
# Actual RMSE
#
cairo_ps(paste0(FILES[3], '.ps'), width=8, height=8)
COL <- c('black', 'red', 'blue', 'darkgreen', 'darkorange')
COL <- gray(1/(5:1)) 
matplot (ds[[3]][1, 1:12], type='n', xaxt='n', yaxt='n', xlab='', ylab='', fg='white', col.axis='white', ylim=c(20, 130))
abline(v=1:12, lwd=100, col=gray(.9))
abline(h=seq(0, 150, 20), v=seq(1, 12, 2), col='white', lty=1)
abline(h=seq(0, 150, 10), v=seq(1, 12, 1), col='white', lty=2, lwd=.1)
axis(1, las=1, at=1:12,            labels=paste0(1:12, '月'), col.ticks='black', col='white')
axis(2, las=2, at=seq(0, 150, 20), labels=seq(0, 150, 20),    col.ticks='black', col='white')
mtext('2015年',           side=1, line=3, cex=1.2, col='black')
mtext('RMSE  x10 [ MW ]', side=2, line=3, cex=1.2, col='black')
legend('topleft', horiz=F, bty='o', col=COL, cex=1.0, pch=1:5, lty=1:5, lwd=2,
       bg=gray(.9), box.col=gray(.9), text.col='black', title=expression(underline('上位者')), legend=paste0(1:5, '位'))
for (i in 1:5)
{
  matlines(ds[[3]][i, 1:12], type='o', pch=i, col=COL[i], lty=i, lwd=2)
}

for (j in dev.list() ) dev.off(j)

#system(paste0('evince ', FILES[3], '.ps'))

#
# Load curves
#
cairo_ps(paste0(FILES[4], '.ps'), width=8, height=8)
CNMS.D <- c('y', 'yhat')
par(mar = .1 + c(4, 5, 1, 1), cex=1.1)
COL <- gray(c(0.0, 0.7)) 
NHRS <- 24*9
at1  <- 1:NHRS
at6  <- seq(1, NHRS, 6)
at12a <- seq(1, NHRS+12, 12)
at24  <- seq(1, NHRS, 24)
at24a <- seq(1, NHRS+24, 24)
px1  <- as.POSIXct(px[at1])
px6  <- as.POSIXct(px[at6])
px12a <- seq(as.POSIXct(px[1]), along.with = at12a, by = 60*60*12)
px24  <- as.POSIXct(px[at24])
px24a <- seq(as.POSIXct(px[1]), along.with = at24a, by = 60*60*24)
matplot (x=px1,
         y=ds[[4]][at1, CNMS.D[1]]/10,
         type='n', xaxt='n', yaxt='n', xlab='', ylab='',
         ylim=c(2000, 4500))
abline(v=px12a, h=seq(0, 6000,  500), col='gray', lty=2, lwd=.1)
abline(v=px24a, h=seq(0, 6000, 1000), col='gray', lty=1, lwd=1)
axis(1, las=1, at=px24+60*60*12, labels=format(px24, '%a'), line = -3.5, lwd=0)
axis(1, las=1, at=px12a,         labels=as.numeric(format(px12a, '%H')))
axis(2, las=2, at=seq(0, 6000, 1000), labels=format(seq(0, 6000, 1000), big.mark=','))
mtext('時間帯',             side=1, line=3, cex=1.7)
mtext('需要値　x10 [ MW ]', side=2, line=4, cex=1.7)
legend('topleft', horiz=F, bg='white', bty='o', col=COL, lwd=2, cex=1.2,
        title=expression(underline('需要')), legend=CNMS[[4]])
for (j in 2:1)
{
  matlines(x=px1, y=ds[[4]][at1, CNMS.D[j]]/10, type='l', col=COL[j], lwd=2)
}

for (j in dev.list() ) dev.off(j)

#system(paste0('evince ', FILES[4], '.ps'))

