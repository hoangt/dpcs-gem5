# Copyright (c) 2012-2013 ARM Limited
# All rights reserved.
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
# Authors: Prakash Ramrakhyani

from m5.params import *
from m5.proxy import *
from ClockedObject import ClockedObject

class BaseTags(ClockedObject):
    type = 'BaseTags'
    abstract = True
    cxx_header = "mem/cache/tags/base.hh"
    # Get the size from the parent (cache)
    size = Param.MemorySize(Parent.size, "capacity in bytes")

    # Get the block size from the parent (system)
    block_size = Param.Int(Parent.cache_line_size, "block size in bytes")

    # Get the hit latency from the parent (cache)
    hit_latency = Param.Cycles(Parent.hit_latency,
                               "The hit latency for this cache")
	
    # BEGIN DPCS PARAMS #
    mode = Param.Int(Parent.mode, "DPCS mode")
    monte_carlo = Param.Int(Parent.monte_carlo, "0: off 1: on")
    vdd3 = Param.UInt64(Parent.vdd3, "VDD3")
    vdd2 = Param.UInt64(Parent.vdd2, "VDD2")
    vdd1 = Param.UInt64(Parent.vdd1, "VDD1")
    bit_faultrate1000 = Param.UInt64(Parent.bit_faultrate1000, "")
    bit_faultrate950 = Param.UInt64(Parent.bit_faultrate950, "")
    bit_faultrate900 = Param.UInt64(Parent.bit_faultrate900, "")
    bit_faultrate850 = Param.UInt64(Parent.bit_faultrate850, "")
    bit_faultrate800 = Param.UInt64(Parent.bit_faultrate800, "")
    bit_faultrate750 = Param.UInt64(Parent.bit_faultrate750, "")
    bit_faultrate700 = Param.UInt64(Parent.bit_faultrate700, "")
    bit_faultrate650 = Param.UInt64(Parent.bit_faultrate650, "")
    bit_faultrate600 = Param.UInt64(Parent.bit_faultrate600, "")
    bit_faultrate550 = Param.UInt64(Parent.bit_faultrate550, "")
    bit_faultrate500 = Param.UInt64(Parent.bit_faultrate500, "")
    bit_faultrate450 = Param.UInt64(Parent.bit_faultrate450, "")
    bit_faultrate400 = Param.UInt64(Parent.bit_faultrate400, "")
    bit_faultrate350 = Param.UInt64(Parent.bit_faultrate350, "")
    bit_faultrate300 = Param.UInt64(Parent.bit_faultrate300, "")
    static_power_vdd1000 = Param.Float(Parent.static_power_vdd1000, "")
    static_power_vdd950 = Param.Float(Parent.static_power_vdd950, "")
    static_power_vdd900 = Param.Float(Parent.static_power_vdd900, "")
    static_power_vdd850 = Param.Float(Parent.static_power_vdd850, "")
    static_power_vdd800 = Param.Float(Parent.static_power_vdd800, "")
    static_power_vdd750 = Param.Float(Parent.static_power_vdd750, "")
    static_power_vdd700 = Param.Float(Parent.static_power_vdd700, "")
    static_power_vdd650 = Param.Float(Parent.static_power_vdd650, "")
    static_power_vdd600 = Param.Float(Parent.static_power_vdd600, "")
    static_power_vdd550 = Param.Float(Parent.static_power_vdd550, "")
    static_power_vdd500 = Param.Float(Parent.static_power_vdd500, "")
    static_power_vdd450 = Param.Float(Parent.static_power_vdd450, "")
    static_power_vdd400 = Param.Float(Parent.static_power_vdd400, "")
    static_power_vdd350 = Param.Float(Parent.static_power_vdd350, "")
    static_power_vdd300 = Param.Float(Parent.static_power_vdd300, "")
    access_energy_vdd1000 = Param.Float(Parent.access_energy_vdd1000, "")
    access_energy_vdd950 = Param.Float(Parent.access_energy_vdd950, "")
    access_energy_vdd900 = Param.Float(Parent.access_energy_vdd900, "")
    access_energy_vdd850 = Param.Float(Parent.access_energy_vdd850, "")
    access_energy_vdd800 = Param.Float(Parent.access_energy_vdd800, "")
    access_energy_vdd750 = Param.Float(Parent.access_energy_vdd750, "")
    access_energy_vdd700 = Param.Float(Parent.access_energy_vdd700, "")
    access_energy_vdd650 = Param.Float(Parent.access_energy_vdd650, "")
    access_energy_vdd600 = Param.Float(Parent.access_energy_vdd600, "")
    access_energy_vdd550 = Param.Float(Parent.access_energy_vdd550, "")
    access_energy_vdd500 = Param.Float(Parent.access_energy_vdd500, "")
    access_energy_vdd450 = Param.Float(Parent.access_energy_vdd450, "")
    access_energy_vdd400 = Param.Float(Parent.access_energy_vdd400, "")
    access_energy_vdd350 = Param.Float(Parent.access_energy_vdd350, "")
    access_energy_vdd300 = Param.Float(Parent.access_energy_vdd300, "")
    # END DPCS PARAMS

class LRU(BaseTags):
    type = 'LRU'
    cxx_class = 'LRU'
    cxx_header = "mem/cache/tags/lru.hh"
    assoc = Param.Int(Parent.assoc, "associativity")

class FALRU(BaseTags):
    type = 'FALRU'
    cxx_class = 'FALRU'
    cxx_header = "mem/cache/tags/fa_lru.hh"

class DPCSLRU(BaseTags): # DPCS
    type = 'DPCSLRU'
    cxx_class = 'DPCSLRU'
    cxx_header = "mem/cache/tags/dpcs_lru.hh"
    assoc = Param.Int(Parent.assoc, "associativity")
