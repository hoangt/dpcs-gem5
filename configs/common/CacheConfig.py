# Copyright (c) 2012-2013 ARM Limited
# All rights reserved
# 
# The license below extends only to copyright in the software and shall
# not be construed as granting a license to any other intellectual
# property including but not limited to intellectual property relating
# to a hardware implementation of the functionality of the software
# licensed hereunder.  You may use the software subject to the license
# terms below provided that you ensure that this notice is replicated
# unmodified and in its entirety in all distributions of the software,
# modified or unmodified, in source code or in binary form.
# 
# Copyright (c) 2010 Advanced Micro Devices, Inc.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met: redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer;
# redistributions in binary form must reproduce the above copyright
# notice, this list of conditions and the following disclaimer in the
# documentation and/or other materials provided with the distribution;
# neither the name of the copyright holders nor the names of its
# contributors may be used to endorse or promote products derived from
# this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# Authors: Lisa Hsu

# Configure the M5 cache hierarchy config in one place
#

import m5
from m5.objects import *
from Caches import *

def config_cache(options, system):
    if options.cpu_type == "arm_detailed":
        try:
            from O3_ARM_v7a import *
        except:
            print "arm_detailed is unavailable. Did you compile the O3 model?"
            sys.exit(1)

        dcache_class, icache_class, l2_cache_class = \
            O3_ARM_v7a_DCache, O3_ARM_v7a_ICache, O3_ARM_v7aL2
    else:
        dcache_class, icache_class, l2_cache_class = \
            L1Cache, L1Cache, L2Cache

    # Set the cache line size of the system
    system.cache_line_size = options.cacheline_size
    
    # DPCS
    if options.monte_carlo == "yes":
        mc = 1
    elif options.monte_carlo == "no":
        mc = 0
    else:
        fatal("bad monte carlo option")

    if options.l2cache:
        # DPCS: Parse L2 cache mode option
        if options.l2_cache_mode:
            if options.l2_cache_mode == "vanilla":
                l2mode = 0
                l2tags = LRU()
            elif options.l2_cache_mode == "static":
                l2mode = 1 
                l2tags = DPCSLRU()
            elif options.l2_cache_mode == "dynamic":
                l2mode = 2 
                l2tags = DPCSLRU()
            else:
                fatal("option --l2_cache_mode had an illegal value")
        else:
            l2mode = 0
            l2tags = LRU()

        # Provide a clock for the L2 and the L1-to-L2 bus here as they
        # are not connected using addTwoLevelCacheHierarchy. Use the
        # same clock as the CPUs, and set the L1-to-L2 bus width to 32
        # bytes (256 bits).
        system.l2 = l2_cache_class(clk_domain=system.cpu_clk_domain,
                                   size=options.l2_size,
                                   assoc=options.l2_assoc,
                                   # BEGIN DPCS PARAMS #
                                   mode=l2mode,
                                   hit_latency=options.l2_hit_latency,
                                   monte_carlo=mc,
                                   vdd3=options.vdd3,
                                   vdd2=options.vdd2,
                                   vdd1=options.vdd1,
                                   bit_faultrate1000=options.bit_faultrate1000,
                                   bit_faultrate950=options.bit_faultrate950,
                                   bit_faultrate900=options.bit_faultrate900,
                                   bit_faultrate850=options.bit_faultrate850,
                                   bit_faultrate800=options.bit_faultrate800,
                                   bit_faultrate750=options.bit_faultrate750,
                                   bit_faultrate700=options.bit_faultrate700,
                                   bit_faultrate650=options.bit_faultrate650,
                                   bit_faultrate600=options.bit_faultrate600,
                                   bit_faultrate550=options.bit_faultrate550,
                                   bit_faultrate500=options.bit_faultrate500,
                                   bit_faultrate450=options.bit_faultrate450,
                                   bit_faultrate400=options.bit_faultrate400,
                                   bit_faultrate350=options.bit_faultrate350,
                                   bit_faultrate300=options.bit_faultrate300,
                                   static_power_vdd1000=options.l2_static_power_vdd1000,
                                   static_power_vdd950=options.l2_static_power_vdd950,
                                   static_power_vdd900=options.l2_static_power_vdd900,
                                   static_power_vdd850=options.l2_static_power_vdd850,
                                   static_power_vdd800=options.l2_static_power_vdd800,
                                   static_power_vdd750=options.l2_static_power_vdd750,
                                   static_power_vdd700=options.l2_static_power_vdd700,
                                   static_power_vdd650=options.l2_static_power_vdd650,
                                   static_power_vdd600=options.l2_static_power_vdd600,
                                   static_power_vdd550=options.l2_static_power_vdd550,
                                   static_power_vdd500=options.l2_static_power_vdd500,
                                   static_power_vdd450=options.l2_static_power_vdd450,
                                   static_power_vdd400=options.l2_static_power_vdd400,
                                   static_power_vdd350=options.l2_static_power_vdd350,
                                   static_power_vdd300=options.l2_static_power_vdd300,
                                   access_energy_vdd1000=options.l2_access_energy_vdd1000,
                                   access_energy_vdd950=options.l2_access_energy_vdd950,
                                   access_energy_vdd900=options.l2_access_energy_vdd900,
                                   access_energy_vdd850=options.l2_access_energy_vdd850,
                                   access_energy_vdd800=options.l2_access_energy_vdd800,
                                   access_energy_vdd750=options.l2_access_energy_vdd750,
                                   access_energy_vdd700=options.l2_access_energy_vdd700,
                                   access_energy_vdd650=options.l2_access_energy_vdd650,
                                   access_energy_vdd600=options.l2_access_energy_vdd600,
                                   access_energy_vdd550=options.l2_access_energy_vdd550,
                                   access_energy_vdd500=options.l2_access_energy_vdd500,
                                   access_energy_vdd450=options.l2_access_energy_vdd450,
                                   access_energy_vdd400=options.l2_access_energy_vdd400,
                                   access_energy_vdd350=options.l2_access_energy_vdd350,
                                   access_energy_vdd300=options.l2_access_energy_vdd300,
                                   missThresholdLow=options.dpcs_l2_miss_threshold_low,
                                   missThresholdHigh=options.dpcs_l2_miss_threshold_high,
                                   missPenalty=options.l2_miss_penalty,
                                   vdd_switch_overhead=options.vdd_switch_overhead,
                                   DPCSSampleInterval=options.dpcs_l2_sample_interval,
                                   DPCSSuperSampleInterval=options.dpcs_super_sample_interval,
                                   # END DPCS PARAMS #
                                   tags=l2tags) 

        system.tol2bus = CoherentBus(clk_domain = system.cpu_clk_domain,
                                     width = 32)
        system.l2.cpu_side = system.tol2bus.master
        system.l2.mem_side = system.membus.slave

    for i in xrange(options.num_cpus):
        if options.caches:
            # DPCS: Parse L1 cache mode option
            if options.l1_cache_mode:
                if options.l1_cache_mode == "vanilla":
                    l1mode = 0
                    l1tags = LRU()
                elif options.l1_cache_mode == "static":
                    l1mode = 1 
                    l1tags = DPCSLRU()
                elif options.l1_cache_mode == "dynamic":
                    l1mode = 2 
                    l1tags = DPCSLRU()
                else:
                    fatal("option --l1_cache_mode had an illegal value")
            else:
                l1mode = 0
                l1tags = LRU()
        
            icache = icache_class(size=options.l1i_size,
                                  assoc=options.l1i_assoc,
                                  mode=False, # Assume DPCS always off for i-cache
                                  hit_latency=options.l1_hit_latency, # DPCS
                                  missPenalty=options.l2_hit_latency, # DPCS
                                  monte_carlo=0,
                                  vdd3=options.vdd3,
                                  vdd2=options.vdd2,
                                  vdd1=options.vdd1,
                                  bit_faultrate1000=options.bit_faultrate1000,
                                  bit_faultrate950=options.bit_faultrate950,
                                  bit_faultrate900=options.bit_faultrate900,
                                  bit_faultrate850=options.bit_faultrate850,
                                  bit_faultrate800=options.bit_faultrate800,
                                  bit_faultrate750=options.bit_faultrate750,
                                  bit_faultrate700=options.bit_faultrate700,
                                  bit_faultrate650=options.bit_faultrate650,
                                  bit_faultrate600=options.bit_faultrate600,
                                  bit_faultrate550=options.bit_faultrate550,
                                  bit_faultrate500=options.bit_faultrate500,
                                  bit_faultrate450=options.bit_faultrate450,
                                  bit_faultrate400=options.bit_faultrate400,
                                  bit_faultrate350=options.bit_faultrate350,
                                  bit_faultrate300=options.bit_faultrate300,
                                  static_power_vdd1000=options.l1_static_power_vdd1000,
                                  static_power_vdd950=options.l1_static_power_vdd950,
                                  static_power_vdd900=options.l1_static_power_vdd900,
                                  static_power_vdd850=options.l1_static_power_vdd850,
                                  static_power_vdd800=options.l1_static_power_vdd800,
                                  static_power_vdd750=options.l1_static_power_vdd750,
                                  static_power_vdd700=options.l1_static_power_vdd700,
                                  static_power_vdd650=options.l1_static_power_vdd650,
                                  static_power_vdd600=options.l1_static_power_vdd600,
                                  static_power_vdd550=options.l1_static_power_vdd550,
                                  static_power_vdd500=options.l1_static_power_vdd500,
                                  static_power_vdd450=options.l1_static_power_vdd450,
                                  static_power_vdd400=options.l1_static_power_vdd400,
                                  static_power_vdd350=options.l1_static_power_vdd350,
                                  static_power_vdd300=options.l1_static_power_vdd300,
                                  access_energy_vdd1000=options.l1_access_energy_vdd1000,
                                  access_energy_vdd950=options.l1_access_energy_vdd950,
                                  access_energy_vdd900=options.l1_access_energy_vdd900,
                                  access_energy_vdd850=options.l1_access_energy_vdd850,
                                  access_energy_vdd800=options.l1_access_energy_vdd800,
                                  access_energy_vdd750=options.l1_access_energy_vdd750,
                                  access_energy_vdd700=options.l1_access_energy_vdd700,
                                  access_energy_vdd650=options.l1_access_energy_vdd650,
                                  access_energy_vdd600=options.l1_access_energy_vdd600,
                                  access_energy_vdd550=options.l1_access_energy_vdd550,
                                  access_energy_vdd500=options.l1_access_energy_vdd500,
                                  access_energy_vdd450=options.l1_access_energy_vdd450,
                                  access_energy_vdd400=options.l1_access_energy_vdd400,
                                  access_energy_vdd350=options.l1_access_energy_vdd350,
                                  access_energy_vdd300=options.l1_access_energy_vdd300,
                                  tags=LRU())  # DPCS
            dcache = dcache_class(size=options.l1d_size,
                                  assoc=options.l1d_assoc,
                                  # BEGIN DPCS PARAMS #
                                  mode=l1mode,
                                  hit_latency=options.l1_hit_latency,
                                  monte_carlo=mc,
                                  vdd3=options.vdd3,
                                  vdd2=options.vdd2,
                                  vdd1=options.vdd1,
                                  bit_faultrate1000=options.bit_faultrate1000,
                                  bit_faultrate950=options.bit_faultrate950,
                                  bit_faultrate900=options.bit_faultrate900,
                                  bit_faultrate850=options.bit_faultrate850,
                                  bit_faultrate800=options.bit_faultrate800,
                                  bit_faultrate750=options.bit_faultrate750,
                                  bit_faultrate700=options.bit_faultrate700,
                                  bit_faultrate650=options.bit_faultrate650,
                                  bit_faultrate600=options.bit_faultrate600,
                                  bit_faultrate550=options.bit_faultrate550,
                                  bit_faultrate500=options.bit_faultrate500,
                                  bit_faultrate450=options.bit_faultrate450,
                                  bit_faultrate400=options.bit_faultrate400,
                                  bit_faultrate350=options.bit_faultrate350,
                                  bit_faultrate300=options.bit_faultrate300,
                                  static_power_vdd1000=options.l1_static_power_vdd1000,
                                  static_power_vdd950=options.l1_static_power_vdd950,
                                  static_power_vdd900=options.l1_static_power_vdd900,
                                  static_power_vdd850=options.l1_static_power_vdd850,
                                  static_power_vdd800=options.l1_static_power_vdd800,
                                  static_power_vdd750=options.l1_static_power_vdd750,
                                  static_power_vdd700=options.l1_static_power_vdd700,
                                  static_power_vdd650=options.l1_static_power_vdd650,
                                  static_power_vdd600=options.l1_static_power_vdd600,
                                  static_power_vdd550=options.l1_static_power_vdd550,
                                  static_power_vdd500=options.l1_static_power_vdd500,
                                  static_power_vdd450=options.l1_static_power_vdd450,
                                  static_power_vdd400=options.l1_static_power_vdd400,
                                  static_power_vdd350=options.l1_static_power_vdd350,
                                  static_power_vdd300=options.l1_static_power_vdd300,
                                  access_energy_vdd1000=options.l1_access_energy_vdd1000,
                                  access_energy_vdd950=options.l1_access_energy_vdd950,
                                  access_energy_vdd900=options.l1_access_energy_vdd900,
                                  access_energy_vdd850=options.l1_access_energy_vdd850,
                                  access_energy_vdd800=options.l1_access_energy_vdd800,
                                  access_energy_vdd750=options.l1_access_energy_vdd750,
                                  access_energy_vdd700=options.l1_access_energy_vdd700,
                                  access_energy_vdd650=options.l1_access_energy_vdd650,
                                  access_energy_vdd600=options.l1_access_energy_vdd600,
                                  access_energy_vdd550=options.l1_access_energy_vdd550,
                                  access_energy_vdd500=options.l1_access_energy_vdd500,
                                  access_energy_vdd450=options.l1_access_energy_vdd450,
                                  access_energy_vdd400=options.l1_access_energy_vdd400,
                                  access_energy_vdd350=options.l1_access_energy_vdd350,
                                  access_energy_vdd300=options.l1_access_energy_vdd300,
                                  missThresholdLow=options.dpcs_l1_miss_threshold_low,
                                  missThresholdHigh=options.dpcs_l1_miss_threshold_high,
                                  missPenalty=options.l2_hit_latency,
                                  vdd_switch_overhead=options.vdd_switch_overhead,
                                  DPCSSampleInterval=options.dpcs_l1_sample_interval,
                                  DPCSSuperSampleInterval=options.dpcs_super_sample_interval,
                                  # END DPCS PARAMS #
                                  tags=l1tags) 

            # When connecting the caches, the clock is also inherited
            # from the CPU in question
            if buildEnv['TARGET_ISA'] == 'x86':
                system.cpu[i].addPrivateSplitL1Caches(icache, dcache,
                                                      PageTableWalkerCache(),
                                                      PageTableWalkerCache())
            else:
                system.cpu[i].addPrivateSplitL1Caches(icache, dcache)
        system.cpu[i].createInterruptController()
        if options.l2cache:
            system.cpu[i].connectAllPorts(system.tol2bus, system.membus)
        else:
            system.cpu[i].connectAllPorts(system.membus)

    return system
