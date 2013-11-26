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
    vdd3 = Param.Int(Parent.vdd3, "VDD3 (nominal) in mV")
    vdd2 = Param.Int(Parent.vdd2, "VDD2 in mV")
    vdd1 = Param.Int(Parent.vdd1, "VDD1 in mV")
    voltage_parameter_file = Param.String(Parent.voltage_parameter_file, "relative path to input file containing voltage/ber/power/energy data")
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
