clear all
capture log close
set maxvar 10000
cd "C:\ado\personal\_"  //set path

do _quaidsce__utils.mata //run mata to update libraries
lmbuild lquaidsce.mlib, replace dir( C:\ado\personal\l\)

log using  "C:\Users\jccaro\quaidsce\quaidsce\test.log", replace
webuse food, clear
program drop _all

***debugginb tools
*set trace on
*set tracedepth 4
*set matadebug on
*mata: mata set matalnum on

foreach i of numlist 1/4 {
gen aux = cond(runiform() < 0.2, 0, 1)
replace w`i'=0 if aux==0
drop aux 
}

gen w5=1-w1-w2-w3-w4
replace w5=0 if w5<0.0001
gen p5=0.5*p1+0.5*p3+exp(rnormal())
gen lnp5=ln(p5)

set seed 1
gen nkids = int(runiform()*4)
gen rural = (runiform() > 0.2)
gen income = exp(rnormal())+exp(rnormal())

quaids w1 w2 w3 w4 w5, anot(10) prices(p1 p2 p3 p4 p5) expenditure(expfd) demographics(nkids rural income) nolog 
quaidsce w1 w2 w3 w4 w5, anot(10) prices(p1 p2 p3 p4 p5) expenditure(expfd) demographics(nkids rural income) nolog nocensor
quaidsce w1 w2 w3 w4 w5, anot(10) prices(p1 p2 p3 p4 p5) expenditure(expfd) demographics(nkids rural income) nolog 

log close




