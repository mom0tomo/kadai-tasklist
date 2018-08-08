(1...10).each do |number|
  Task.create(content: 'test' + number.to_s, status: 'active')
 end