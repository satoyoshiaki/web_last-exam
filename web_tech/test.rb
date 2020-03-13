
require 'webrick'
server = WEBrick::HTTPServer.new({
  :DocumentRoot => '.',
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
  :Port => '3000',
})
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}
#　先頭の引数で指定したURLを叩くと、最後の引数で指定したファイルが開く。
server.mount('/test', WEBrick::HTTPServlet::ERBHandler, 'test.html.erb')
server.mount('/indicate.cgi', WEBrick::HTTPServlet::CGIHandler, 'indicate.rb')
server.mount('/goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya.rb')
server.mount('/info', WEBrick::HTTPServlet::ERBHandler, 'info.html.erb')
server.mount('/bad_goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'bad_goya.rb')
server.mount('/goya_take.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya_take.rb')
server.start