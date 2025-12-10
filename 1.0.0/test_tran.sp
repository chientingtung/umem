*memristor test*
*ngspice-44.2_64

.control
pre_osdi ./code/umem.osdi
run
wrdata ./OUT/test_tran.txt v(1) i(v2)
.endc

.temp 25

.model rram umem_va devmod=0 tm=1.7n area=25e-14 rth=5e5 cth=1e-15 x0=0.15n 
+tau0=1e-15 ea0=1.24 ea0_r=1.24 am=0.8 am_r=0.5 a0=-0.1 b0=3
+rhot=3e-3 v0=0.45 rs=4000 areanom=25e-14

.model ftj umem_va devmod=1 pdfmod=0 tm=8n pr=0.2 tau0=400n ea0=2.0 a0=0.2 b0=2.0 am=3.0
+md1=0.1 md2=5 epar=34 efb=1e7 rhot=1e-5 x1=0.3 v0=0.45

.model mram umem_va devmod=2 tm=1e-9 area=5e-15 areanom=5e-15 rhot=4.5e-3 ic0=4e-5 ic0_r=2.5e-5 v0=1.5 tmr0=1.13 vr0=0.8 tau0=2e-8 rs=0

v1 1 0 pwl 0 0 1m 2.5 2m 0 3m -2.5 4m 0 
v2 2 0 0

n1 1 2 3 rram
*n1 1 2 3 ftj
*n1 1 2 3 mram

.ic v(3)=1.69 
*.ic v(3)=-0.23 
*.ic v(3)=1

.tran 1u 4m 

.end