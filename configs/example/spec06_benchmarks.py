#MyBench.py

import m5
from m5.objects import *

gem5_dir = '/home/mark/gem5/'
spec_dir = '/home/mark/spec_cpu2006_install/'
out_dir = gem5_dir + 'spec2006out/'
alpha_suffix = '_base.alpha'

#temp
binary_dir = spec_dir
data_dir = spec_dir

#400.perlbench
perlbench = LiveProcess()
perlbench.executable =  'perlbench' + alpha_suffix
perlbench.cmd = [perlbench.executable] + ['-I.', '-I./lib', 'attrs.pl']
#perlbench.output = out_dir+'perlbench.out'

#401.bzip2
bzip2 = LiveProcess()
bzip2.executable =  'bzip2' + alpha_suffix
bzip2.cmd = [bzip2.executable] + ['input.program', '5']
#bzip2.output = out_dir + 'bzip2.out'

#403.gcc
gcc = LiveProcess()
gcc.executable = 'gcc' + alpha_suffix
gcc.cmd = [gcc.executable] + ['cccp.i', '-o', 'cccp.s']
#gcc.output = out_dir + 'gcc.out'

#410.bwaves
bwaves = LiveProcess()
bwaves.executable = 'bwaves' + alpha_suffix
bwaves.cmd = [bwaves.executable]
#bwaves.output = out_dir + 'bwaves.out'

#416.gamess
gamess=LiveProcess()
gamess.executable = 'gamess' + alpha_suffix
gamess.cmd = [gamess.executable]
gamess.input = 'exam29.config'
#gamess.output = out_dir + 'gamess.out'

#429.mcf
mcf = LiveProcess()
mcf.executable =  'mcf' + alpha_suffix
mcf.cmd = [mcf.executable] + ['inp.in']
#mcf.output = out_dir + 'mcf.out'

#433.milc
milc=LiveProcess()
milc.executable = 'milc' + alpha_suffix
milc.cmd = [milc.executable]
milc.input = 'su3imp.in'
#milc.output = out_dir + 'milc.out'

#434.zeusmp
zeusmp=LiveProcess()
zeusmp.executable = 'zeusmp' + alpha_suffix
zeusmp.cmd = [zeusmp.executable]
#zeusmp.output = out_dir + 'zeusmp.out'

#435.gromacs
gromacs = LiveProcess()
gromacs.executable = 'gromacs' + alpha_suffix
gromacs.cmd = [gromacs.executable] + ['-silent','-deffnm', 'gromacs', '-nice','0']
#gromacs.output = out_dir + 'gromacs.out'

#436.cactusADM
cactusADM = LiveProcess()
cactusADM.executable = 'cactusADM' + alpha_suffix 
cactusADM.cmd = [cactusADM.executable] + ['benchADM.par']
#cactusADM.output = out_dir + 'cactusADM.out'

#437.leslie3d
leslie3d=LiveProcess()
leslie3d.executable = 'leslie3d' + alpha_suffix
leslie3d.cmd = [leslie3d.executable]
leslie3d.input = 'leslie3d.in'
#leslie3d.output = out_dir + 'leslie3d.out'

#444.namd
namd = LiveProcess()
namd.executable = 'namd' + alpha_suffix
namd.cmd = [namd.executable] + ['--input', 'namd.input', '--output', 'namd.out', '--iterations', '1']
#namd.output = out_dir + 'namd.out'

#445.gobmk
gobmk=LiveProcess()
gobmk.executable = 'gobmk' + alpha_suffix
gobmk.cmd = [gobmk.executable] + ['--quiet','--mode', 'gtp']
gobmk.input = 'dniwog.tst'
#gobmk.output = out_dir + 'gobmk.out'

#447.dealII
dealII=LiveProcess()
dealII.executable = 'dealII' + alpha_suffix
dealII.cmd = [gobmk.executable]+['8']
#dealII.output = out_dir + 'dealII.out'

#450.soplex
soplex=LiveProcess()
soplex.executable = 'soplex' + alpha_suffix
soplex.cmd = [soplex.executable] + ['-m10000', 'test.mps']
#soplex.output = out_dir + 'soplex.out'

#453.povray
povray=LiveProcess()
povray.executable = 'povray' + alpha_suffix
povray.cmd = [povray.executable] + ['SPEC-benchmark-test.ini']
#povray.output = out_dir + 'povray.out'

#454.calculix
calculix=LiveProcess()
calculix.executable = 'calculix' + alpha_suffix
calculix.cmd = [calculix.executable] + ['-i', 'beampic']
#calculix.output = out_dir + 'calculix.out' 

#456.hmmer
hmmer=LiveProcess()
hmmer.executable = 'hmmer' + alpha_suffix
hmmer.cmd = [hmmer.executable] + ['--fixed', '0', '--mean', '325', '--num', '45000', '--sd', '200', '--seed', '0', 'bombesin.hmm']
#hmmer.output = out_dir + 'hmmer.out'

#458.sjeng
sjeng=LiveProcess()
sjeng.executable = 'sjeng' + alpha_suffix 
sjeng.cmd = [sjeng.executable] + ['test.txt']
#sjeng.output = out_dir + 'sjeng.out'

#459.GemsFDTD
GemsFDTD=LiveProcess()
GemsFDTD.executable = 'GemsFDTD' + alpha_suffix 
GemsFDTD.cmd = [GemsFDTD.executable]
#GemsFDTD.output = out_dir + 'GemsFDTD.out'

#462.libquantum
libquantum=LiveProcess()
libquantum.executable = 'libquantum' + alpha_suffix
libquantum.cmd = [libquantum.executable] + ['33','5']
#libquantum.output = out_dir + 'libquantum.out' 

#464.h264ref
h264ref=LiveProcess()
h264ref.executable = 'h264ref' + alpha_suffix
h264ref.cmd = [h264ref.executable] + ['-d', 'foreman_test_encoder_baseline.cfg']
#h264ref.output = out_dir + 'h264ref.out'

#465.tonto
tonto=LiveProcess()
tonto.executable = 'tonto' + alpha_suffix
tonto.cmd = [tonto.executable]
#tonto.output = out_dir + 'tonto.out'

#470.lbm
lbm=LiveProcess()
lbm.executable = 'lbm' + alpha_suffix
lbm.cmd = [lbm.executable] + ['20', 'reference.dat', '0', '1', '100_100_130_cf_a.of']
#lbm.output = out_dir + 'lbm.out'

#471.omnetpp
omnetpp=LiveProcess()
omnetpp.executable = 'omnetpp' + alpha_suffix 
omnetpp.cmd = [omnetpp.executable] + ['omnetpp.ini']
#omnetpp.output = out_dir + 'omnetpp.out'

#473.astar
astar=LiveProcess()
astar.executable = 'astar' + alpha_suffix
astar.cmd = [astar.executable] + ['lake.cfg']
#astar.output = out_dir + 'astar.out'

#481.wrf
wrf=LiveProcess()
wrf.executable = 'wrf' + alpha_suffix
wrf.cmd = [wrf.executable]
#wrf.output = out_dir + 'wrf.out'

#482.sphinx3
sphinx3=LiveProcess()
sphinx3.executable = 'sphinx_livepretend' + alpha_suffix 
sphinx3.cmd = [sphinx3.executable] + ['ctlfile', '.', 'args.an4']
#sphinx3.output = out_dir + 'sphinx3.out'

#483.xalancbmk
xalancbmk=LiveProcess()
xalancbmk.executable = 'xalancbmk' + alpha_suffix
xalancbmk.cmd = [xalancbmk.executable] + ['-v','test.xml','xalanc.xsl']
#xalancbmk.output = out_dir + 'xalancbmk.out'

#998.specrand
specrand_i=LiveProcess()
specrand_i.executable = 'specrand' + alpha_suffix
specrand_i.cmd = [specrand_i.executable] + ['324342', '24239']
#specrand_i.output = out_dir + 'specrand_i.out'

#999.specrand
specrand_f=LiveProcess()
specrand_f.executable = 'specrand' + alpha_suffix
specrand_f.cmd = [specrand_f.executable] + ['324342', '24239']
#specrand_f.output = out_dir + 'specrand_f.out'
