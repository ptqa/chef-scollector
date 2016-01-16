# Encoding: utf-8
require 'serverspec'

set :backend, :exec

describe command('/opt/go/bin/scollector -conf=/etc/scollector/scollector.toml -p -d|head') do
  its(:stdout) { should match /OpenTSDB/ }
end
