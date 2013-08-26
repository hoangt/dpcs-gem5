#MyBench.py

import m5
from m5.objects import *

spec_dir = '/home/mark/spec_cpu2006_install/'
bench_dir = spec_dir + 'benchspec/CPU2006/'
out_dir = 'spec2006_out/'
x86_suffix = '_base.amd64-m64-gcc42-nn'
alpha_suffix = '_base.alpha'
x86_run_suffix = 'run/run_base_test_amd64-m64-gcc42-nn.0000/'
alpha_run_suffix = 'run/run_base_test_alpha.0000/'

#temp
binary_dir = spec_dir
data_dir = spec_dir

#400.perlbench
perlbench_dir = bench_dir + '400.perlbench/'
perlbench_rundir = perlbench_dir + alpha_run_suffix
perlbench = LiveProcess()
perlbench.executable =  perlbench_rundir + 'perlbench' + alpha_suffix
perlbench.cmd = perlbench.executable + ' -I' + perlbench_rundir + ' -I' + perlbench_rundir + '/lib ' + perlbench_rundir + 'attrs.pl'
perlbench.output = out_dir+'perlbench.out'
#perlbench.cmd = perlbench.executable + ' -I' + perlbench_rundir + ' -I' + perlbench_rundir + '/lib ' + perlbench_rundir + 'gv.pl'
#perlbench.cmd = perlbench.executable + ' -I' + perlbench_rundir + ' -I' + perlbench_rundir + '/lib ' + perlbench_rundir + 'makerand.pl'
#perlbench.cmd = perlbench.executable + ' -I' + perlbench_rundir + ' -I' + perlbench_rundir + '/lib ' + perlbench_rundir + 'pack.pl'
#perlbench.cmd = perlbench.executable + ' -I' + perlbench_rundir + ' -I' + perlbench_rundir + '/lib ' + perlbench_rundir + 'redef.pl'
#perlbench.cmd = perlbench.executable + ' -I' + perlbench_rundir + ' -I' + perlbench_rundir + '/lib ' + perlbench_rundir + 'ref.pl'
#perlbench.cmd = perlbench.executable + ' -I' + perlbench_rundir + ' -I' + perlbench_rundir + '/lib ' + perlbench_rundir + 'regmesg.pl'
#perlbench.cmd = perlbench.executable + ' -I' + perlbench_rundir + ' -I' + perlbench_rundir + '/lib ' + perlbench_rundir + 'test.pl'

# perlbench ref running commands
#perlbench.cmd = perlbench.executable + ' -I' + perlbench_rundir + ' -I' + perlbench_rundir + '/lib ' + perlbench_rundir + 'checkspam.pl 2500 5 25 11 150 1 1 1 1'
#perlbench.cmd = perlbench.executable + ' -I' + perlbench_rundir + ' -I' + perlbench_rundir + '/lib ' + perlbench_rundir + 'diffmail.pl 4 800 10 17 19 300'
#perlbench.cmd = perlbench.executable + ' -I' + perlbench_rundir + ' -I' + perlbench_rundir + '/lib ' + perlbench_rundir + 'splitmail.pl 1600 12 26 16 4500'

#401.bzip2
bzip2_dir = bench_dir + '401.bzip2/'
bzip2_rundir = bzip2_dir + alpha_run_suffix
bzip2 = LiveProcess()
bzip2.executable =  bzip2_rundir + 'bzip2' + alpha_suffix
bzip2.cmd = bzip2.executable + ' ' + bzip2_rundir + 'input.program 5'
#bzip2.cmd = bzip2.executable + ' ' + bzip2_rundir + 'dryer.jpg 2'
bzip2.output = out_dir + 'bzip2.out'

# bzip2 ref running commands
#bzip2.cmd = bzip2.executable + ' ' + bzip2_rundir + 'input.source 280' 
#bzip2.cmd = bzip2.executable + ' ' + bzip2_rundir + 'chicken.jpg 30' 
#bzip2.cmd = bzip2.executable + ' ' + bzip2_rundir + 'liberty.jpg 30' 
#bzip2.cmd = bzip2.executable + ' ' + bzip2_rundir + 'input.program 280' 
#bzip2.cmd = bzip2.executable + ' ' + bzip2_rundir + 'text.html 280' 
#bzip2.cmd = bzip2.executable + ' ' + bzip2_rundir + 'input.combined 200' 

#403.gcc
gcc_dir = bench_dir + '403.gcc/'
gcc_rundir = gcc_dir + alpha_run_suffix
gcc = LiveProcess()
gcc.executable =  gcc_rundir + 'gcc' + alpha_suffix
gcc.cmd = gcc.executable + ' ' + gcc_rundir + 'cccp.i -o ' + gcc_rundir + 'cccp.s'
gcc.output = out_dir + 'gcc.out'

#410.bwaves
bwaves_dir = bench_dir + '410.bwaves/'
bwaves_rundir = bwaves_dir + alpha_run_suffix
bwaves = LiveProcess()
bwaves.executable = bwaves_rundir + 'bwaves' + alpha_suffix
bwaves.cmd = bwaves.executable
bwaves.output = out_dir + 'bwaves.out'

#416.gamess
#gamess=LiveProcess()
#gamess.executable =  binary_dir+'416.gamess_base.alpha-gcc'
#gamess.cmd = [gamess.executable]
#gamess.input='exam29.config'
#gamess.output='exam29.output'

#429.mcf
mcf_dir = bench_dir + '429.mcf/'
mcf_rundir = mcf_dir + alpha_run_suffix
mcf = LiveProcess()
mcf.executable =  mcf_rundir + 'mcf' + alpha_suffix
mcf.cmd = mcf.executable + ' inp.in'
mcf.output = out_dir + 'mcf.out'

#433.milc
milc=LiveProcess()
milc.executable = binary_dir+'433.milc_base.alpha-gcc'
stdin=data_dir+'433.milc/data/test/input/su3imp.in'
milc.cmd = [milc.executable]
milc.input=stdin
milc.output='su3imp.out'

#434.zeusmp
zeusmp=LiveProcess()
zeusmp.executable =  binary_dir+'434.zeusmp_base.alpha-gcc'
zeusmp.cmd = [zeusmp.executable]
zeusmp.output = 'zeusmp.stdout'

#435.gromacs
gromacs = LiveProcess()
gromacs.executable =  binary_dir+'435.gromacs_base.alpha-gcc'
data=data_dir+'435.gromacs/data/test/input/gromacs.tpr'
gromacs.cmd = [gromacs.executable] + ['-silent','-deffnm',data,'-nice','0']

#436.cactusADM
cactusADM = LiveProcess()
cactusADM.executable =  binary_dir+'436.cactusADM_base.alpha-gcc'
data=data_dir+'436.cactusADM/data/test/input/benchADM.par'
cactusADM.cmd = [cactusADM.executable] + [data]
cactusADM.output = 'benchADM.out'

#437.leslie3d
leslie3d=LiveProcess()
leslie3d.executable =  binary_dir+'437.leslie3d_base.alpha-gcc'
stdin=data_dir+'437.leslie3d/data/test/input/leslie3d.in'
leslie3d.cmd = [leslie3d.executable]
leslie3d.input=stdin
leslie3d.output='leslie3d.stdout'

#444.namd
namd = LiveProcess()
namd.executable =  binary_dir+'444.namd_base.alpha-gcc'
input=data_dir+'444.namd/data/all/input/namd.input'
namd.cmd = [namd.executable] + ['--input',input,'--iterations','1','--output','namd.out']
namd.output='namd.stdout'

#445.gobmk
gobmk=LiveProcess()
gobmk.executable =  binary_dir+'445.gobmk_base.alpha-gcc'
stdin=data_dir+'445.gobmk/data/test/input/capture.tst'
gobmk.cmd = [gobmk.executable]+['--quiet','--mode','gtp']
gobmk.input=stdin
gobmk.output='capture.out'

#447.dealII
dealII=LiveProcess()
dealII.executable =  binary_dir+'447.dealII_base.alpha-gcc'
dealII.cmd = [gobmk.executable]+['8']
dealII.output='log'


#450.soplex
soplex=LiveProcess()
soplex.executable =  binary_dir+'450.soplex_base.alpha-gcc'
data=data_dir+'450.soplex/data/test/input/test.mps'
soplex.cmd = [soplex.executable]+['-m10000',data]
soplex.output = 'test.out'

#453.povray
povray=LiveProcess()
povray.executable =  binary_dir+'453.povray_base.alpha-gcc'
data=data_dir+'453.povray/data/test/input/SPEC-benchmark-test.ini'
#povray.cmd = [povray.executable]+['SPEC-benchmark-test.ini']
povray.cmd = [povray.executable]+[data]
povray.output = 'SPEC-benchmark-test.stdout'

#454.calculix
calculix=LiveProcess()
calculix.executable =  binary_dir+'454.calculix_base.alpha-gcc'
data='/import/RaidHome/mjwu/work_spec2006/454.calculix/m5/beampic'
calculix.cmd = [calculix.executable]+['-i',data]
calculix.output = 'beampic.log'

#456.hmmer
hmmer=LiveProcess()
hmmer.executable =  binary_dir+'456.hmmer_base.alpha-gcc'
data=data_dir+'456.hmmer/data/test/input/bombesin.hmm'
hmmer.cmd = [hmmer.executable]+['--fixed', '0', '--mean', '325', '--num', '5000', '--sd', '200', '--seed', '0', data]
hmmer.output = 'bombesin.out'

#458.sjeng
sjeng=LiveProcess()
sjeng.executable =  binary_dir+'458.sjeng_base.alpha-gcc'
data=data_dir+'458.sjeng/data/test/input/test.txt'
sjeng.cmd = [sjeng.executable]+[data]
sjeng.output = 'test.out'

#459.GemsFDTD
GemsFDTD=LiveProcess()
GemsFDTD.executable =  binary_dir+'459.GemsFDTD_base.alpha-gcc'
GemsFDTD.cmd = [GemsFDTD.executable]
GemsFDTD.output = 'test.log'

#462.libquantum
libquantum=LiveProcess()
libquantum.executable =  binary_dir+'462.libquantum_base.alpha-gcc'
libquantum.cmd = [libquantum.executable],'33','5'
libquantum.output = 'test.out'

#464.h264ref
h264ref=LiveProcess()
h264ref.executable =  binary_dir+'464.h264ref_base.alpha-gcc'
data=data_dir+'464.h264ref/data/test/input/foreman_test_encoder_baseline.cfg'
h264ref.cmd = [h264ref.executable]+['-d',data]
h264ref.output = 'foreman_test_encoder_baseline.out'

#470.lbm
lbm=LiveProcess()
lbm.executable =  binary_dir+'470.lbm_base.alpha-gcc'
data=data_dir+'470.lbm/data/test/input/100_100_130_cf_a.of'
lbm.cmd = [lbm.executable]+['20', 'reference.dat', '0', '1' ,data]
lbm.output = 'lbm.out'

#471.omnetpp
omnetpp=LiveProcess()
omnetpp.executable =  binary_dir+'471.omnetpp_base.alpha-gcc'
data=data_dir+'471.omnetpp/data/test/input/omnetpp.ini'
omnetpp.cmd = [omnetpp.executable]+[data]
omnetpp.output = 'omnetpp.log'

#473.astar
astar=LiveProcess()
astar.executable =  binary_dir+'473.astar_base.alpha-gcc'
astar.cmd = [astar.executable]+['lake.cfg']
astar.output = 'lake.out'

#481.wrf
wrf=LiveProcess()
wrf.executable =  binary_dir+'481.wrf_base.alpha-gcc'
wrf.cmd = [wrf.executable]+['namelist.input']
wrf.output = 'rsl.out.0000'

#482.sphinx
sphinx3=LiveProcess()
sphinx3.executable =  binary_dir+'482.sphinx_livepretend_base.alpha-gcc'
sphinx3.cmd = [sphinx3.executable]+['ctlfile', '.', 'args.an4']
sphinx3.output = 'an4.out'

#483.xalancbmk
xalancbmk=LiveProcess()
xalancbmk.executable =  binary_dir+'483.Xalan_base.alpha-gcc'
xalancbmk.cmd = [xalancbmk.executable]+['-v','test.xml','xalanc.xsl']
xalancbmk.output = 'test.out'

#998.specrand
specrand_i=LiveProcess()
specrand_i.executable = binary_dir+'998.specrand_base.alpha-gcc'
specrand_i.cmd = [specrand_i.executable] + ['324342','24239']
specrand_i.output = 'rand.24239.out'

#999.specrand
specrand_f=LiveProcess()
specrand_f.executable = binary_dir+'999.specrand_base.alpha-gcc'
specrand_f.cmd = [specrand_i.executable] + ['324342','24239']
specrand_f.output = 'rand.24239.out'
