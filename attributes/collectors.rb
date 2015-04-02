default['scollector']['collectors'] = {
  redis: {
    interval: 60,
    enabled: false,
    host: '127.1',
    port:  6379,
    metrics:  [
      { name: 'llen_clientbeholdindex', cmd: 'llen', args: 'clientbeholdindex' }
    ]
  }
}
