#
# Author:: Mahmoud Abdelkader <mahmoud@balancedpayments.com>
#
# Copyright 2015, Balanced, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['balanced-statsd-relayer']['overwrite_config']             = false
default['balanced-statsd-relayer']['conf_dir']                     = '/opt/statsd'


default['balanced-statsd-relayer']['debug']                        = false
default['balanced-statsd-relayer']['address']                      = '0.0.0.0'
default['balanced-statsd-relayer']['address_ipv6']                 = false
default['balanced-statsd-relayer']['port']                         = 8125
default['balanced-statsd-relayer']['server']                       = './servers/udp'

default['balanced-statsd-relayer']['mgmt_address']                 = '0.0.0.0'
default['balanced-statsd-relayer']['mgmt_port']                    = 8126

default['balanced-statsd-relayer']['graphite_host']                = '127.0.0.1'
default['balanced-statsd-relayer']['graphite_port']                = 2003

default['balanced-statsd-relayer']['delete_idle_stats']            = false
default['balanced-statsd-relayer']['delete_timers']                = false
default['balanced-statsd-relayer']['delete_gauges']                = false
default['balanced-statsd-relayer']['delete_sets']                  = false
default['balanced-statsd-relayer']['delete_counters']              = false
default['balanced-statsd-relayer']['dump_messages']                = false

default['balanced-statsd-relayer']['flush_counts']                 = true
default['balanced-statsd-relayer']['flush_interval']               = 10000
default['balanced-statsd-relayer']['percent_threshold']            = 90
default['balanced-statsd-relayer']['health_status']                = 'up'
default['balanced-statsd-relayer']['title']                        = 'statsd'


# Graphite storage config
default['balanced-statsd-relayer']['graphite']['legacy_namespace'] = true
default['balanced-statsd-relayer']['graphite']['global_prefix']    = 'stats'
default['balanced-statsd-relayer']['graphite']['global_suffix']    = ''
default['balanced-statsd-relayer']['graphite']['prefix_counter']   = 'counters'
default['balanced-statsd-relayer']['graphite']['prefix_timer']     = 'timers'
default['balanced-statsd-relayer']['graphite']['prefix_gauge']     = 'gauges'
default['balanced-statsd-relayer']['graphite']['prefix_set']       = 'sets'

# backends
default['balanced-statsd-relayer']['backends']                     = ['./backends/repeater']
default['balanced-statsd-relayer']['extra_config']                = {
    :repeater => {
        :tcp => {
            :debug => true,
            :enabled => true,
            :host => "internal-metrics.vandelay.io",
            :maxConnections => 10,
            :port => 8125,
        }
    }
}
