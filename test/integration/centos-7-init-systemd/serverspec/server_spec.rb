# Encoding: utf-8
require 'serverspec'

set :backend, :exec

describe file('/etc/systemd/system/scollector.service') do
  it { should exist }
	it { should be_file }
  it { should contain '-conf' }
end


describe file('/etc/scollector/scollector.toml') do
  it { should be_file }
  it { should contain 'http://127.0.0.1:8070' }
  it { should contain '/etc/scollector/collectors' }
end

describe process('scollector') do
  it { should be_running }
end

describe command('/opt/go/bin/scollector -conf=/etc/scollector/scollector.toml -p -d|head') do
  its(:stdout) { should match /OpenTSDB/ }
end
