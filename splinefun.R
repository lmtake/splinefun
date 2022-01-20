## locale setting
#In strsplit(code, "/n", fixed = TRUE) :input string 1 is invalid in this locale
#このエラーに対する対処

Sys.getlocale()
Sys.setlocale("LC_ALL","English")
#setlocaleをEnglishにしないとbeav1のデータセットを使用する際にエラーが出る
#日本語で初めから作る場合は不要と思われる。

## データセット
library(MASS)
Dataset <- data.frame(beav1,encoding="utf-8")
head(Dataset)

## 平滑化するデータ

# 平滑化を行うデータを作成。2列目をxにと3列目をyに使用する
x <- Dataset[,2]
y <- Dataset[,3]

## スプライン補間
#スプライン補間とプロットためのデータ準備

# スプライン関数で平滑化の計算
sp <- splinefun(x, y)
# 平滑化データの作成
xest <- seq(min(x), max(x), by = 0.1) #xの区切りを自由に変えて
yest <- sp(xest)
#列名取得
rowx <- colnames(Dataset[2])
rowy <- colnames(Dataset[3])

## plot

# 図の作成。補間プロットをラインで
plot(xest, yest, type = "l", col = "red",
     xlab=rowx,ylab=rowy)
#元のデータをプロット
points(x, y, pch = 16, col = "black")


#table(yest) データを見る場合実行 膨大ならやらなくていい
Z=data.frame(xest,yest)#補間データを出力用に結合
write.csv(Z,file="OutData1.csv")#csvにする。
