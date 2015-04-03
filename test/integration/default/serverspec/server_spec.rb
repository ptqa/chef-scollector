# Encoding: utf-8
require 'serverspec'

set :backend, :exec

describe package('runit') do
  it { should be_installed }
end

describe file('/etc/service/scollector') do
  it { should be_symlink }
end

# as default attributes
describe file('/etc/sv/scollector/run') do
  it { should be_file }
  it { should contain '-conf=' }
end

describe file('/etc/scollector/scollector.conf') do
  it { should be_file }
  it { should contain 'http://127.0.0.1:8070' }
end

describe process('scollector') do
  it { should be_running }
end
