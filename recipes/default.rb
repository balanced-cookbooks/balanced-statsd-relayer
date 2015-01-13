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

require 'chef/mixin/deep_merge'

include_recipe 'balanced-apt'

apt_repository 'ppa-nodejs' do
  uri 'http://ppa.launchpad.net/chris-lea/node.js/ubuntu'
  distribution node['lsb']['codename']
  components ['main']
  keyserver 'keyserver.ubuntu.com'
  key 'B9316A7BC7917B12'
  action :add
end

%w(nodejs balanced-statsd-relayer).each do |pkg|
   package pkg do
     action :upgrade
   end
end

if node['balanced-statsd-relayer']['overwrite_config']
  statsd = node['balanced-statsd-relayer']

  template "#{statsd['conf_dir']}/config.js" do
    source 'config.js.erb'
    owner 'root'
    group 'root'
    mode 0644

    config_hash = {
        port: statsd['port'],
        graphitePort: statsd['graphite_port'],
        graphiteHost: statsd['graphite_host'],
        server: statsd['server'],
        backends: statsd['backends'],
        debug: statsd['debug'],
        address: statsd['address'],
        address_ipv6: statsd['address_ipv6'],
        mgmt_address: statsd['mgmt_address'],
        mgmt_port: statsd['mgmt_port'],
        title: statsd['title'],
        healthStatus: statsd['health_status'],
        flushInterval: statsd['flush_interval'],
        percentThreshold: statsd['percent_threshold'],
        flush_counts: statsd['flush_counts'],
        graphite: {
            :legacyNamespace => statsd['graphite']['legacy_namespace']
        }
    }

    Chef::Mixin::DeepMerge.deep_merge!(statsd['extra_config'], config_hash)
    variables config_hash: config_hash
    notifies :restart, 'service[statsd]', :delayed
  end
end

service 'statsd' do
  action :restart
end